library;

import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealTimeRemindersRepoProvider = Provider<MealTimeRemindersRepo>(
  (_) => throw UnimplementedError(),
);

abstract class MealTimeRemindersRepo {
  Future<List<MealTimeReminder>> get();
  Future<void> save(List<MealTimeReminder> reminders);
}

class LocalMealTimeRemindersRepo extends MealTimeRemindersRepo {
  static const boxName = 'mealTimeReminders';
  static const _valuesKey = 'data';

  @override
  Future<List<MealTimeReminder>> get() async {
    final box = await _openBox();
    if (box.isEmpty) return [];

    final reminders = box.get(_valuesKey);

    if (reminders is! List) {
      throw 'To get Meal Time Reminders from Hive, the values should be list';
    }
    List<MealTimeReminder> result = [];
    for (var reminder in reminders) {
      result.add(MealTimeReminder.fromJson(reminder));
    }

    return result;
  }

  @override
  Future<void> save(List<MealTimeReminder> reminders) async {
    final box = await _openBox();
    await box.put(_valuesKey, reminders.toJson());
  }

  Future<Box> _openBox() => Hive.openBox(boxName);
}
