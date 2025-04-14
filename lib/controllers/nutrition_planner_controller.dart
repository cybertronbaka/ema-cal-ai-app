import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nutritionPlannerCanGoBack = StateProvider.autoDispose((_) => true);

final nutritionPlannerControllerProvider = Provider.autoDispose(
  (ref) => NutritionPlannerController(ref),
);

class NutritionPlannerController {
  NutritionPlannerController(this.ref);

  Ref ref;

  AsyncValue<NutritionPlan> nutritionPlan = const AsyncLoading();

  Future<void> generatePlan(
    UserProfile profile,
    List<MealTimeReminder> reminders,
    String gptApiKey,
  ) async {
    try {
      ref.read(nutritionPlannerCanGoBack.notifier).state = false;
      nutritionPlan = const AsyncLoading();
      ref.notifyListeners();
      await ref.read(profileRepoProvider).save(profile);

      await ref.read(mealTimeRemindersRepoProvider).save(reminders);

      await ref.read(profileRepoProvider).get().then((value) {
        debugPrint(value?.toJson().toString());
      });

      await ref.read(mealTimeRemindersRepoProvider).get().then((value) {
        debugPrint(value.toJson().toString());
      });

      final plan = await ref
          .read(nutritionPlannerRepoProvider)
          .plan(profile, gptApiKey);

      debugPrint(plan.toJson().toString());
      nutritionPlan = AsyncData(plan);
    } catch (e, st) {
      nutritionPlan = AsyncError(e, st);
    } finally {
      ref.read(nutritionPlannerCanGoBack.notifier).state = true;
      ref.notifyListeners();
    }
  }
}
