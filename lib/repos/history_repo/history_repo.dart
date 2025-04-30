import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/chart_data.dart';
import 'package:ema_cal_ai/models/history.dart';
import 'package:ema_cal_ai/utils/date_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final historyRepoProvider = Provider<HistoryRepo>(
  (_) => throw UnimplementedError(),
);

abstract class HistoryRepo {
  Future<List<History>> getFilteredHistory({
    required HistoryType type,
    required HistoryFilter filter,
  });
  Future<History> saveWeight(History history);

  Future<List<ChartData>> getChartData({
    required HistoryType type,
    required HistoryFilter filter,
  });
  Future<void> clear();
}

class LocalHistoryRepo extends HistoryRepo {
  DbHistory? weightHistoryToday;

  Future<DbHistory?> _getTodaysWeightHistory() async {
    final now = clock.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    if (weightHistoryToday != null &&
        _isOnSameDay(now, weightHistoryToday!.createdAt)) {
      return weightHistoryToday!;
    }

    final existingQuery = database.managers.dbHistories.filter((f) {
      return f.type.equals(HistoryType.weight) &
          f.createdAt.isAfterOrOn(startOfDay) &
          f.createdAt.isBefore(endOfDay);
    });

    final existing = await existingQuery.getSingleOrNull();
    weightHistoryToday = existing;

    return existing;
  }

  bool _isOnSameDay(DateTime now, DateTime other) {
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return other.isAtSameMomentAs(startOfDay) ||
        (other.isAfter(startOfDay) && other.isBefore(endOfDay));
  }

  @override
  Future<History> saveWeight(History history) async {
    if (history.type != HistoryType.weight) {
      throw 'Cannot save non-weight types with this method';
    }

    final existing = await _getTodaysWeightHistory();

    if (existing != null) {
      return _update(existing, history);
    }

    return _insert(history);
  }

  Future<History> _update(DbHistory existing, History history) async {
    final now = clock.now();
    final companion = DbHistoriesCompanion(
      id: existing.id.toDbValue(),
      type: history.type.toDbValue(),
      value: history.value.toDbValue(),
      updatedAt: now.toDbValue(),
      createdAt: existing.createdAt.toDbValue(),
    );

    await database.update(database.dbHistories).replace(companion);

    return History(
      id: existing.id.toInt(),
      type: history.type,
      value: history.value,
      createdAt: existing.createdAt,
    );
  }

  Future<History> _insert(History history) async {
    final now = clock.now();
    final companion = DbHistoriesCompanion.insert(
      type: history.type,
      value: history.value,
      updatedAt: now,
      createdAt: now,
    );

    final id = await database.into(database.dbHistories).insert(companion);

    return History(
      id: id,
      type: history.type,
      value: history.value,
      createdAt: now,
    );
  }

  @override
  Future<List<ChartData>> getChartData({
    required HistoryType type,
    required HistoryFilter filter,
  }) {
    final startDate = _getStartDate(filter).toUtc();
    final localTime = startDate.toIso8601String();

    final groupFormat = switch (filter) {
      HistoryFilter.allTime => '%Y',
      HistoryFilter.last1Year => '%Y-%m',
      HistoryFilter.last3Months => '%Y-%m',
      HistoryFilter.thisMonth => '%Y-%m-%W',
      HistoryFilter.last6Months => '%Y-%m',
    };

    return database
        .customSelect(
          '''
      WITH filtered AS (
        SELECT created_at, value 
        FROM db_histories
        WHERE 
          type = ? AND
          JULIANDAY(created_at) >= JULIANDAY(?)
      ),
      counts AS (SELECT COUNT(*) AS cnt FROM filtered)
      SELECT
        CASE
          WHEN counts.cnt > 7 THEN
            strftime('$groupFormat', datetime(created_at, 'localtime'))
          ELSE
            strftime('%Y/%m/%d', datetime(created_at, 'localtime'))
        END AS interval,
        AVG(value) AS value
      FROM filtered, counts
      GROUP BY interval
      ORDER BY created_at
      ''',
          variables: [Variable<String>(type.name), Variable<String>(localTime)],
        )
        .map((row) {
          return ChartData(
            interval: _formatInterval(row.read<String>('interval')),
            value: row.read<double>('value'),
          );
        })
        .get();
  }

  @override
  Future<List<History>> getFilteredHistory({
    required HistoryType type,
    required HistoryFilter filter,
  }) async {
    final startDate = _getStartDate(filter);

    final query = database.managers.dbHistories
        .filter((h) => h.type.equals(type) & h.createdAt.isAfterOrOn(startDate))
        .orderBy((o) {
          return o.createdAt.desc();
        });

    final items = await query.get();
    final data =
        items
            .map(
              (item) => History(
                id: item.id.toInt(),
                type: type,
                value: item.value,
                createdAt: item.createdAt,
              ),
            )
            .toList();

    return data;
  }

  DateTime _getStartDate(HistoryFilter filter) {
    final now = clock.now();
    switch (filter) {
      case HistoryFilter.thisMonth:
        return DateTime(now.year, now.month, 1);
      case HistoryFilter.last3Months:
        return DateTime(now.year, now.month - 2, 1);
      case HistoryFilter.last6Months:
        return DateTime(now.year, now.month - 5, 1);
      case HistoryFilter.last1Year:
        return DateTime(now.year - 1, now.month, now.day);
      case HistoryFilter.allTime:
        return DateTime(2020);
    }
  }

  @override
  Future<void> clear() async {
    await database.delete(database.dbHistories).go();
  }
}

String _formatInterval(String sqlInterval) {
  if (sqlInterval.contains('-')) {
    final parts = sqlInterval.split('-');
    if (parts.length == 3) {
      // Week format
      return AppDateUtils.getWeekOfMonth(parts);
    } else {
      // Monthly format
      final date = DateTime.parse('$sqlInterval-01');
      return DateFormat('MMM y').format(date); // "Apr 2024"
    }
  } else if (sqlInterval.contains('/')) {
    final parts = sqlInterval.split('/');
    if (parts.length != 3) throw 'What the fuck happened';
    final date = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    return DateFormat('d MMM').format(date); // "14 Apr"
  }
  return sqlInterval;
}
