import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/gpt_meal_data/gpt_meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

ProviderScope createRootProviderScope({
  KeyboardVisibilityController? keyboardVisibilityController,
  ProfileRepo? profileRepo,
  MealTimeRemindersRepo? mealTimeRemindersRepo,
  NutritionPlannerRepo? nutritionPlannerRepo,
  NutritionPlanRepo? nutritionPlanRepo,
  GptApiKeyVerifyRepo? gptApiKeyVerifyRepo,
  OnboardingSaveRepo Function(Ref)? onboardingSaveRepo,
  MealDataRepo? mealDataRepo,
  GptMealDataRepo? gptMealDataRepo,
  StreaksRepo? streaksRepo,
  required Widget child,
}) {
  final overrides = [
    if (keyboardVisibilityController != null)
      keyboardVisibilityControllerProvider.overrideWithValue(
        keyboardVisibilityController,
      ),

    if (profileRepo != null) profileRepoProvider.overrideWithValue(profileRepo),

    if (mealTimeRemindersRepo != null)
      mealTimeRemindersRepoProvider.overrideWithValue(mealTimeRemindersRepo),

    if (nutritionPlannerRepo != null)
      nutritionPlannerRepoProvider.overrideWithValue(nutritionPlannerRepo),

    if (gptApiKeyVerifyRepo != null)
      gptApiKeyVerifyRepoProvider.overrideWithValue(gptApiKeyVerifyRepo),

    if (nutritionPlanRepo != null)
      nutritionPlanRepoProvider.overrideWithValue(nutritionPlanRepo),

    if (onboardingSaveRepo != null)
      onboardingSaveRepoProvider.overrideWith(onboardingSaveRepo),

    if (mealDataRepo != null)
      mealDataRepoProvider.overrideWithValue(mealDataRepo),

    if (gptMealDataRepo != null)
      gptMealDataRepoProvider.overrideWithValue(gptMealDataRepo),

    if (streaksRepo != null) streaksRepoProvider.overrideWithValue(streaksRepo),
  ];

  return ProviderScope(overrides: overrides, child: child);
}
