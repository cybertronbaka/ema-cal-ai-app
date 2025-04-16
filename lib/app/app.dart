import 'package:ema_cal_ai/app/router.dart';
import 'package:ema_cal_ai/app/theme.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/gpt_meal_data/gpt_meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmaCalAIApp extends StatelessWidget {
  const EmaCalAIApp({super.key, required this.keyboardVisibilityController});

  final KeyboardVisibilityController keyboardVisibilityController;

  @override
  Widget build(BuildContext context) {
    return createRootProviderScope(
      keyboardVisibilityController: keyboardVisibilityController,
      profileRepo: LocalProfileRepo(),
      mealTimeRemindersRepo: LocalMealTimeRemindersRepo(),
      nutritionPlannerRepo: GeminiNutritionPlannerRepo(),
      nutritionPlanRepo: LocalNutritionPlanRepo(),
      gptApiKeyVerifyRepo: GeminiApiKeyVerifyRepo(),
      gptApiKeyRepo: LocalGptApiKeyRepo(),
      onboardingSaveRepo: LocalOnboardingSaveRepo(),
      mealDataRepo: LocalMealDataRepo(),
      gptMealDataRepo: GeminiMealDataRepo(),
      child: const EmaCalAIAppMaterialApp(),
    );
  }
}

class EmaCalAIAppMaterialApp extends StatelessWidget {
  const EmaCalAIAppMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'This field must not be empty',
        ValidationMessage.email: (error) => 'This must be a valid email',
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollConfiguration.of(
          context,
        ).copyWith(physics: const BouncingScrollPhysics()),
        title: 'Ema Calorie AI',
        theme: AppTheme.data,
        themeMode: ThemeMode.light,
        routerConfig: router,
      ),
    );
  }
}
