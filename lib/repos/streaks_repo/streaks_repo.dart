import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final streaksRepoProvider = Provider<StreaksRepo>(
  (ref) => throw UnimplementedError(),
);

abstract class StreaksRepo {
  Future<int> get();
  Future<int> add();
  Future<void> clear();
  Future<void> validateAndReset();
}

class LocalStreaksRepo extends StreaksRepo {
  DbStreakRecord? current;

  @override
  Future<int> get() async {
    final data = await _getAndSaveCurrent();

    if (data == null) return 0;

    current = data;
    return data.count;
  }

  Future<DbStreakRecord?> _getAndSaveCurrent() async {
    final query = database.select(database.dbStreakRecords)..limit(1);
    final data = await query.getSingleOrNull();

    current = data;
    return data;
  }

  @override
  Future<int> add() async {
    await database.transaction(() async {
      DbStreakRecord? record =
          current == null ? await _getAndSaveCurrent() : current!;

      if (record == null) {
        await _saveAndSaveCurrent(1);
        return 1;
      }

      final now = clock.now();
      final lastUpdated = record.updatedAt;

      if (_isSameDay(lastUpdated, now)) return record.count;

      final daysBetween = now.difference(lastUpdated).inDays;
      final newCount = daysBetween == 1 ? record.count + 1 : 1;
      await _saveAndSaveCurrent(newCount);
    });

    return current!.count;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _saveAndSaveCurrent(int count) async {
    final createdAt = current == null ? clock.now() : current!.createdAt;
    final updatedAt = clock.now();

    int id;
    if (current == null) {
      id = await _insert(count, createdAt, updatedAt);
    } else {
      await _update(count, current!.id, createdAt, updatedAt);
      id = current!.id;
    }

    current = DbStreakRecord(
      id: id,
      count: count,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  Future<int> _insert(int count, DateTime createdAt, DateTime updatedAt) {
    return database
        .into(database.dbStreakRecords)
        .insert(
          DbStreakRecordsCompanion.insert(
            count: count,
            updatedAt: updatedAt,
            createdAt: createdAt,
          ),
        );
  }

  Future<void> _update(
    int count,
    int id,
    DateTime createdAt,
    DateTime updatedAt,
  ) async {
    await database
        .update(database.dbStreakRecords)
        .replace(
          DbStreakRecordsCompanion(
            id: id.toDbValue(),
            count: count.toDbValue(),
            updatedAt: updatedAt.toDbValue(),
            createdAt: createdAt.toDbValue(),
          ),
        );
  }

  @override
  Future<void> clear() async {
    await database.managers.dbStreakRecords.delete();
  }

  @override
  Future<void> validateAndReset() async {
    DbStreakRecord? record =
        current == null ? await _getAndSaveCurrent() : current!;

    if (record == null) return;

    final now = clock.now();
    final daysSinceUpdate = now.difference(record.updatedAt).inDays;

    if (record.count < 0 ||
        record.updatedAt.isAfter(now) ||
        daysSinceUpdate >= 2) {
      await clear();
    }
  }
}
