import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealTimeRemindersControllerProvider = Provider.autoDispose(
  (ref) => MealTimeRemindersController(ref),
);

class MealTimeRemindersController {
  MealTimeRemindersController(this.ref);

  Ref ref;

  Future<void> setReminders(
    BuildContext context,
    List<MealTimeReminder> reminders,
  ) async {
    final runner = FutureRunner(context: context, showOverlay: false);

    await runner.run(() async {
      await ref.read(mealTimeRemindersRepoProvider).clear();
      final response = await ref
          .read(mealTimeRemindersRepoProvider)
          .saveAll(reminders);

      ref.read(mealTimeRemindersProvider.notifier).state = response;
    });
  }
}
