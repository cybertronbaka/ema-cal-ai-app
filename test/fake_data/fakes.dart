import 'package:clock/clock.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';

NutritionPlan genFakeNutritionPlan() {
  return NutritionPlan(
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

UserProfile genFakeUserProfile({
  int? id,
  bool? isOnboardingComplete,
  DateTime? dob,
  Gender? gender,
  WorkoutFrequency? workoutFrequency,
  UnitLength? height,
  UnitWeight? weight,
  bool? isMetric,
  UnitWeight? weightGoal,
  Diet? diet,
  String? gptKey,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return UserProfile(
    id: id,
    dob: dob ?? DateTime(2007, 04, 1),
    gender: gender ?? Gender.male,
    workoutFrequency: workoutFrequency ?? WorkoutFrequency.low,
    height: height ?? MetricLength(169),
    weight: weight ?? MetricWeight(69),
    isMetric: isMetric ?? true,
    weightGoal: weightGoal ?? MetricWeight(59),
    diet: diet ?? Diet.standard,
    isOnboardingComplete: isOnboardingComplete ?? false,
    gptApiKey: gptKey ?? '',
    createdAt: createdAt ?? clock.now(),
    updatedAt: updatedAt ?? clock.now(),
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

MealData genFakeMealData({
  int? id,
  double? calories,
  double? protein,
  double? carbs,
  double? fats,
  double? water,
  String? mealName,
  String? mealDescription,
  DateTime? updatedAt,
  DateTime? createdAt,
}) {
  return MealData(
    id: id,
    calories: calories ?? 100,
    protein: protein ?? 10,
    carbs: carbs ?? 10,
    fats: fats ?? 10,
    water: water ?? 0.1,
    mealName: mealName ?? 'Test Meal',
    mealDescription: mealDescription ?? 'Test meal description',
    updatedAt: updatedAt ?? clock.now(),
    createdAt: createdAt ?? clock.now(),
  );
}
