import 'dart:async';

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/controllers/nutrition_planner_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/history.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingControllerProvider = Provider.autoDispose(
  (ref) => OnboardingController(ref),
);

// gender,
// workoutFrequency,
// heightAndWeight,
// setDOB,
// setWeightGoal,
// chooseDiet,
// setMealTimes,
// setGeminiApiKey,
// generateNutritionPlan,
class OnboardingController {
  OnboardingController(this.ref) {
    final data = ref.read(onboardingDataProvider);
    if (data == null) return;

    currentStep = data.currentStep;
    gender = data.gender;
    workoutFrequency = data.workoutFrequency;
    height = data.height;
    weight = data.weight;
    isMetric = data.isMetric;
    dob = data.dob;
    if (data.mealTimeReminders != null) {
      mealTimeReminders = data.mealTimeReminders!;
    }
    diet = data.diet;
    gptApiKey = data.gptApiKey;
    nutritionPlan = data.nutritionPlan;
    // No need to do for > 8 because after the last one, isOnboardingComplete is true;
  }

  Ref ref;

  OnboardingStep currentStep = OnboardingStep.gender;

  Gender? gender;

  WorkoutFrequency? workoutFrequency;

  bool isMetric = true;
  static final UnitLength _initialHeight = MetricLength(163);
  static final UnitWeight _initialWeight = MetricWeight(50);

  UnitWeight? _weight;
  UnitWeight get weight => _weight ?? _initialWeight;
  set weight(UnitWeight value) => _weight = value;

  UnitLength? _height;
  UnitLength get height => _height ?? _initialHeight;
  set height(UnitLength value) => _height = value;

  DateTime? dob;

  UnitWeight? _weightGoal;
  UnitWeight get weightGoal => _weightGoal ?? weight - 10;
  set weightGoal(UnitWeight value) => _weightGoal = value;

  Diet? diet;

  List<MealTimeReminder> mealTimeReminders = [
    MealTimeReminder(label: 'Breakfast'),
    MealTimeReminder(label: 'Lunch'),
    MealTimeReminder(label: 'Dinner '),
  ];

  String? gptApiKey;

  UserProfile get profile => UserProfile(
    dob: dob!,
    gender: gender!,
    workoutFrequency: workoutFrequency!,
    height: height,
    weight: weight,
    isMetric: isMetric,
    weightGoal: weightGoal,
    diet: diet!,
    isOnboardingComplete: false,
    gptApiKey: gptApiKey!,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );

  OnboardingData? _data;

  NutritionPlan? nutritionPlan;

  void moveToPrevStep(BuildContext context, TabController tabController) async {
    if (!ref.read(nutritionPlannerCanGoBack)) return;

    if (currentStep == OnboardingStep.gender) {
      context.pushReplacementNamed(Routes.onboardingEntry.name);
      clearData();
      return;
    }

    if (currentStep == OnboardingStep.generateNutritionPlan) {
      nutritionPlan = null;
      saveData();
    }

    FocusManager.instance.primaryFocus?.unfocus();

    currentStep = OnboardingStep.values[currentStep.index - 1];
    saveData();

    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onboardingDone(BuildContext context) async {
    if (currentStep.index != OnboardingStep.values.length - 1) return;

    FocusManager.instance.primaryFocus?.unfocus();

    var newPlan = await ref
        .read(nutritionPlanRepoProvider)
        .save(nutritionPlan!);
    ref.read(currentNutritionPlanProvider.notifier).state = newPlan;

    var newProfile = profile.copyWith(isOnboardingComplete: true);
    newProfile = await ref.read(profileRepoProvider).save(newProfile);
    ref.read(userProfileProvider.notifier).state = newProfile;
    await ref
        .read(historyRepoProvider)
        .saveWeight(
          History(
            type: HistoryType.weight,
            value: newProfile.weight.kg,
            createdAt: clock.now(),
          ),
        );
    clearData();

    if (context.mounted) {
      context.pushReplacementNamed(Routes.onboardingCompleteOverview.name);
    }
  }

  void moveToNextStep(BuildContext context, TabController tabController) {
    if (currentStep.index == OnboardingStep.values.last.index) return;

    FocusManager.instance.primaryFocus?.unfocus();

    currentStep = OnboardingStep.values[currentStep.index + 1];
    saveData();
    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void saveData() async {
    final data = OnboardingData(
      currentStep: currentStep,
      dob: dob,
      gender: gender,
      workoutFrequency: workoutFrequency,
      height: height,
      weight: weight,
      mealTimeReminders: mealTimeReminders,
      isMetric: isMetric,
      weightGoal: weightGoal,
      diet: diet,
      gptApiKey: gptApiKey,
      nutritionPlan: nutritionPlan,
      updatedAt: clock.now(),
      createdAt: clock.now(),
    );
    _data = await ref.read(onboardingSaveRepoProvider).save(data);
    ref.read(onboardingDataProvider.notifier).state = _data;
  }

  void clearData() {
    unawaited(ref.read(onboardingSaveRepoProvider).clear());
    ref.read(onboardingDataProvider.notifier).state = null;
  }
}
