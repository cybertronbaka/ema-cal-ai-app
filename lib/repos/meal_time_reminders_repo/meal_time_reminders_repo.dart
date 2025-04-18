library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealTimeRemindersRepoProvider = Provider<MealTimeRemindersRepo>(
  (_) => throw UnimplementedError(),
);

abstract class MealTimeRemindersRepo {
  Future<List<MealTimeReminder>> get({int? onboardingDataId});
  Future<List<MealTimeReminder>> saveAll(
    List<MealTimeReminder> reminders, {
    int? onboardingDataId,
  });
  Future<void> clear();
}

class LocalMealTimeRemindersRepo extends MealTimeRemindersRepo {
  @override
  Future<List<MealTimeReminder>> get({int? onboardingDataId}) async {
    final query = database.select(database.dbReminders);
    if (onboardingDataId != null) {
      query.where((f) => f.onboardingData.equals(onboardingDataId.toBigInt()));
    }
    final reminders = await query.get();
    return reminders.map((e) => MealTimeReminder.fromDB(e)).toList();
  }

  @override
  Future<List<MealTimeReminder>> saveAll(
    List<MealTimeReminder> reminders, {
    int? onboardingDataId,
  }) async {
    final now = clock.now();

    List<MealTimeReminder> result = [];
    await database.transaction(() async {
      for (var reminder in reminders) {
        final oldId = reminder.id.toBigInt();
        final createdAt =
            reminder.id == null ? clock.now() : reminder.createdAt;

        final id = await database
            .into(database.dbReminders)
            .insertOnConflictUpdate(
              DbRemindersCompanion(
                id: oldId.toDbValueOrAbsent(),
                type: DbReminderType.mealTime.toDbValue(),
                label: reminder.label.toDbValue(),
                hour: (reminder.timeOfDay?.hour).toDbNullableValue(),
                minute: (reminder.timeOfDay?.minute).toDbNullableValue(),
                onboardingData: onboardingDataId.toBigInt().toDbNullableValue(),
                updatedAt: now.toDbValue(),
                createdAt: createdAt.toDbValue(),
              ),
            );

        result.add(reminder.copyWith(id: id));
      }
    });

    return result;
  }

  @override
  Future<void> clear() async {
    await database.managers.dbReminders.delete();
  }
}
