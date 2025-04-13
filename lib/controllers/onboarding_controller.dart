import 'package:ema_cal_ai/controllers/nutrition_planner_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingControllerProvider = Provider.autoDispose(
  (ref) => OnboardingController(ref),
);

class OnboardingController {
  OnboardingController(this.ref);

  Ref ref;

  OnboardingStep currentStep = OnboardingStep.gender;

  Gender? gender;

  WorkoutFrequency? workoutFrequency;

  MeasurementSystem measurementSystem = MeasurementSystem.metric;
  UnitLength height = MetricLength(163);
  UnitWeight weight = MetricWeight(50);

  DateTime? dob;

  UnitWeight? _weightGoal;
  UnitWeight get weightGoal => _weightGoal ?? weight - 10;
  set weightGoal(UnitWeight value) => _weightGoal = value;

  Diet? diet;

  List<MealTimeReminder> mealTimeReminders = [
    MealTimeReminder(label: 'Breakfast', icon: 'assets/images/meal.svg'),
    MealTimeReminder(label: 'Lunch', icon: 'assets/images/meal.svg'),
    MealTimeReminder(label: 'Dinner ', icon: 'assets/images/meal.svg'),
  ];

  UserProfile get profile => UserProfile(
    dob: dob!,
    gender: gender!,
    workoutFrequency: workoutFrequency!,
    height: height,
    weight: weight,
    measurementSystem: measurementSystem,
    weightGoal: weightGoal,
    diet: diet!,
  );

  NutritionPlan? nutritionPlan;

  void moveToPrevStep(BuildContext context, TabController tabController) {
    if (!ref.read(nutritionPlannerCanGoBack)) return;

    if (currentStep == OnboardingStep.gender) return context.pop();

    currentStep = OnboardingStep.values[currentStep.index - 1];
    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void moveToNextStep(BuildContext context, TabController tabController) {
    if (currentStep.index == OnboardingStep.values.last.index) return;

    currentStep = OnboardingStep.values[currentStep.index + 1];
    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
