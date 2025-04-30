import 'package:clock/clock.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/chart_data.dart';
import 'package:ema_cal_ai/models/history.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

NutritionPlan genFakeNutritionPlan({
  int? timeframeInWeeks,
  int? calories,
  double? proteinG,
  double? carbsG,
  double? fatsG,
  double? waterLiters,
  String? gymAdvice,
  String? medicalAdvice,
  String? warnings,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return NutritionPlan(
    timeframeInWeeks: timeframeInWeeks ?? 10,
    goal: DailyNutrition(
      calories: calories ?? 1700,
      proteinG: proteinG ?? 50,
      carbsG: carbsG ?? 30,
      fatsG: fatsG ?? 20,
      waterLiters: waterLiters ?? 2.75,
    ),
    notes: NutritionNotes(
      gymAdvice: gymAdvice ?? 'This is test Gym Advice',
      medicalAdvice: medicalAdvice ?? 'This is test Medical Advice',
      warnings: warnings ?? 'This is test Warnings',
    ),
    createdAt: createdAt ?? clock.now(),
    updatedAt: updatedAt ?? clock.now(),
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

PackageInfo genFakePackageInfo() {
  return PackageInfo(
    appName: 'Ema Cal AI',
    packageName: 'com.emacalai',
    version: '1.0.0',
    buildNumber: '',
  );
}

List<ChartData> genChartData(
  int n,
  HistoryFilter filter, {
  String Function(int)? interval,
  double Function(int)? value,
}) {
  List<ChartData> list = [];
  final startDate = DateTime(2025, 01, 01);
  const startValue = 80.0;
  for (var i = 0; i < n; i++) {
    String? intervalText = interval?.call(i);
    if (intervalText == null) {
      final date = startDate.subtract(Duration(days: i));
      if (n > 7) {
        intervalText = switch (filter) {
          HistoryFilter.allTime => DateFormat('yyyy').format(date),
          HistoryFilter.last1Year ||
          HistoryFilter.last3Months ||
          HistoryFilter.last6Months => DateFormat('MMM yyyy').format(date),
          HistoryFilter.thisMonth => DateFormat('MMM dd').format(date),
        };
      } else {
        intervalText = DateFormat('MMM dd').format(date);
      }
    }

    double? realValue = value?.call(i);
    if (realValue == null) {
      final val = startValue - (0.5 * i);
      if (val <= 30) {
        realValue = 30;
      } else {
        realValue = val;
      }
    }

    list.add(ChartData(interval: intervalText, value: realValue));
  }

  return list;
}

History genFakeHistory({
  int? id,
  HistoryType? type,
  double? value,
  DateTime? createdAt,
}) {
  return History(
    id: id,
    type: type ?? HistoryType.weight,
    value: value ?? 50.0,
    createdAt: createdAt ?? clock.now(),
  );
}
