import 'package:clock/clock.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';

NutritionPlan genFakeNutritionPlan() {
  return NutritionPlan(
    bmiIndex: 21.0,
    timeframeInWeeks: 10,
    goal: DailyNutrition(
      calories: 1700,
      proteinG: 50,
      carbsG: 30,
      fatsG: 20,
      waterLiters: 2.75,
    ),
    notes: NutritionNotes(
      gymAdvice: 'This is test Gym Advice',
      medicalAdvice: 'This is test Medical Advice',
      warnings: 'This is test Warnings',
    ),
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

UserProfile genFakeUserProfile() {
  return UserProfile(
    dob: DateTime(2007, 04, 1),
    gender: Gender.male,
    workoutFrequency: WorkoutFrequency.low,
    height: MetricLength(169),
    weight: MetricWeight(69),
    isMetric: true,
    weightGoal: MetricWeight(59),
    diet: Diet.standard,
    isOnboardingComplete: false,
    gptApiKey: '',
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

List<MealTimeReminder> genFakeMealTimeReminders() {
  return [
    MealTimeReminder(label: 'Breakfast'),
    MealTimeReminder(label: 'Lunch'),
    MealTimeReminder(label: 'Dinner'),
  ];
}

OnboardingData genFakeOnboardingData() {
  return OnboardingData(
    currentStep: OnboardingStep.values.first,
    height: MetricLength(169),
    weight: MetricWeight(69),
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}
