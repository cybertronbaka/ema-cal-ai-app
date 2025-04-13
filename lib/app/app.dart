import 'package:ema_cal_ai/app/router.dart';
import 'package:ema_cal_ai/app/theme.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:ema_cal_ai/utils/shared_pref_proxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmaCalAIApp extends StatelessWidget {
  const EmaCalAIApp({
    super.key,
    required this.sharedPref,
    required this.keyboardVisibilityController,
  });

  final SharedPreferences sharedPref;
  final KeyboardVisibilityController keyboardVisibilityController;

  @override
  Widget build(BuildContext context) {
    return createRootProviderScope(
      sharedPrefProxy: SharedPrefProxy(sharedPref),
      keyboardVisibilityController: keyboardVisibilityController,
      profileRepo: LocalProfileRepo(),
      mealTimeRemindersRepo: LocalMealTimeRemindersRepo(),
      nutritionPlannerRepo: GeminiNutritionPlannerRepo(),
      gptApiKeyVerifyRepo: GeminiApiKeyVerifyRepo(),
      gptApiKeyRepo: LocalGptApiKeyRepo(),
      child: const EmaCalAIAppMaterialApp(),
    );
  }
}

class EmaCalAIAppMaterialApp extends ConsumerWidget {
  const EmaCalAIAppMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
