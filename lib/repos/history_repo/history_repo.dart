import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/history.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyRepoProvider = Provider<HistoryRepo>(
  (_) => throw UnimplementedError(),
);

enum HistoryFilter { thisMonth, last3Months, last6Months, last1Year, allTime }

abstract class HistoryRepo {
  Future<List<History>> getFilteredHistory({
    required HistoryType type,
    required HistoryFilter filter,
  });
  Future<History> save(History history);
  Future<void> clear();
}

class LocalHistoryRepo extends HistoryRepo {
  @override
  Future<List<History>> getFilteredHistory({
    required HistoryType type,
    required HistoryFilter filter,
  }) async {
    final startDate = _getStartDate(filter);

    final query =
        database.select(database.dbHistories)
          ..where(
            (h) =>
                h.type.equals(type.name) &
                h.createdAt.isBiggerOrEqualValue(startDate),
          )
          ..orderBy([(h) => OrderingTerm(expression: h.createdAt)]);

    final items = await query.get();

    return items
        .map(
          (item) => History(
            id: item.id.toInt(),
            type: type,
            value: item.value,
            createdAt: item.createdAt,
          ),
        )
        .toList();
  }

  DateTime _getStartDate(HistoryFilter filter) {
    final now = DateTime.now();
    switch (filter) {
      case HistoryFilter.thisMonth:
        return DateTime(now.year, now.month, 1);
      case HistoryFilter.last3Months:
        return DateTime(now.year, now.month - 3, now.day);
      case HistoryFilter.last6Months:
        return DateTime(now.year, now.month - 6, now.day);
      case HistoryFilter.last1Year:
        return DateTime(now.year - 1, now.month, now.day);
      case HistoryFilter.allTime:
        return DateTime(2020);
    }
  }

  @override
  Future<History> save(History history) async {
    final startOfDay = DateTime(
      history.createdAt.year,
      history.createdAt.month,
      history.createdAt.day,
    );
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(milliseconds: 1));

    final existingQuery = database.select(database.dbHistories)..where(
      (h) =>
          h.type.equals(history.type.name) &
          h.createdAt.isBetweenValues(startOfDay, endOfDay),
    );

    final existing = await existingQuery.getSingleOrNull();

    if (existing != null) {
      // print('Updating..');
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
    } else {
      // print('Inserting..');
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
  }

  @override
  Future<void> clear() async {
    await database.delete(database.dbHistories).go();
  }
}
