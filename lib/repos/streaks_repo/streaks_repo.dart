import 'package:clock/clock.dart';
import 'package:hive/hive.dart';
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

class LocalStreaksRepo implements StreaksRepo {
  static const boxName = 'streaks';

  @override
  Future<int> get() async {
    final box = await _openBox();
    return _getStreakValue(box)?.count ?? 0;
  }

  _StreakValue? _getStreakValue(Box box) {
    if (box.isEmpty) return null;

    return _StreakValue.fromHive(box);
  }

  Future<void> _save(Box box, _StreakValue value) async {
    await box.putAll(value.toJson());
  }

  @override
  Future<int> add() async {
    final box = await _openBox();
    final current = _getStreakValue(box);
    if (current == null) {
      await _save(box, _StreakValue(count: 1, updatedAt: clock.now()));
      return 1;
    }

    final now = clock.now();
    final lastUpdated = current.updatedAt;

    if (_isSameDay(lastUpdated, now)) return current.count;

    final daysBetween = now.difference(lastUpdated).inDays;
    final newCount = daysBetween == 1 ? current.count + 1 : 1;

    await _save(box, _StreakValue(count: newCount, updatedAt: now));

    return newCount;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }

  @override
  Future<void> validateAndReset() async {
    final box = await _openBox();
    final value = _getStreakValue(box);

    // No streak exists - nothing to validate
    if (value == null) return;

    final now = clock.now();
    final daysSinceUpdate = now.difference(value.updatedAt).inDays;

    // Clear if: Negative count, future date, or 2+ days inactive
    if (value.count < 0 ||
        value.updatedAt.isAfter(now) ||
        daysSinceUpdate >= 2) {
      await clear();
    }
  }

  Future<Box> _openBox() => Hive.openBox(boxName);
}

class _StreakValue {
  const _StreakValue({required this.count, required this.updatedAt});

  factory _StreakValue.fromHive(Box box) {
    return _StreakValue(
      count: box.get('count') as int,
      updatedAt: DateTime.parse(box.get('updated_at') as String),
    );
  }
  final int count;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {'count': count, 'updated_at': updatedAt.toIso8601String()};
  }
}
