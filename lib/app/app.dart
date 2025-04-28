import 'package:ema_cal_ai/app/router.dart';
import 'package:ema_cal_ai/app/theme.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/gpt_meal_data/gpt_meal_data_repo.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/gpt_nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmaCalAIApp extends StatelessWidget {
  const EmaCalAIApp({
    super.key,
    required this.keyboardVisibilityController,
    required this.packageInfo,
  });

  final KeyboardVisibilityController keyboardVisibilityController;
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    return createRootProviderScope(
      keyboardVisibilityController: keyboardVisibilityController,
      profileRepo: LocalProfileRepo(),
      mealTimeRemindersRepo: LocalMealTimeRemindersRepo(),
      gptNutritionPlannerRepo: GeminiNutritionPlannerRepo(),
      nutritionPlanRepo: LocalNutritionPlanRepo(),
      gptApiKeyVerifyRepo: GeminiApiKeyVerifyRepo(),
      onboardingSaveRepo: (ref) => LocalOnboardingSaveRepo(ref),
      mealDataRepo: LocalMealDataRepo(),
      gptMealDataRepo: GeminiMealDataRepo(),
      streaksRepo: LocalStreaksRepo(),
      historyRepo: LocalHistoryRepo(),
      packageInfo: packageInfo,
      child: const EmaCalAIAppMaterialApp(),
    );
  }
}

class EmaCalAIAppMaterialApp extends HookWidget {
  const EmaCalAIAppMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerConfig = useMemoized(() => router());
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
        routerConfig: routerConfig,
      ),
    );
  }
}
