import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:hive/hive.dart';

class OnboardingData {
  OnboardingData({
    required this.currentStep,
    this.dob,
    this.gender,
    this.workoutFrequency,
    this.height = const MetricLength(163),
    this.weight = const MetricWeight(50),
    this.measurementSystem = MeasurementSystem.metric,
    this.weightGoal,
    this.diet,
    this.mealTimeReminders,
    this.gptApiKey,
    this.nutritionPlan,
  });

  factory OnboardingData.fromHive(Box box) {
    return OnboardingData(
      currentStep:
          _nullOrT(
            box.get('current_step'),
            (value) => OnboardingStep.values[value],
          ) ??
          OnboardingStep.values.first,
      dob: _nullOrT(box.get('dob'), (value) => DateTime.parse(value)),
      gender: _nullOrT(box.get('gender'), (value) => Gender.values[value]),
      workoutFrequency: _nullOrT(
        box.get('workout_frequency'),
        (value) => WorkoutFrequency.values[value],
      ),
      height:
          _nullOrT(box.get('height'), (value) => UnitLength.fromJson(value)) ??
          const MetricLength(163),
      weight:
          _nullOrT(box.get('weight'), (value) => UnitWeight.fromJson(value)) ??
          const MetricWeight(50),
      measurementSystem:
          _nullOrT(
            box.get('measurement_system'),
            (value) => MeasurementSystem.values[value],
          ) ??
          MeasurementSystem.metric,
      weightGoal: _nullOrT(
        box.get('weight_goal'),
        (value) => UnitWeight.fromJson(value),
      ),
      diet: _nullOrT(box.get('diet'), (value) => Diet.values[value]),
      mealTimeReminders: _nullOrT(
        box.get('meal_time_reminders'),
        (value) =>
            (value as List).map((r) => MealTimeReminder.fromJson(r)).toList(),
      ),
      gptApiKey: box.get('gpt_api_key'),
      nutritionPlan: _nullOrT(
        box.get('nutrition_plan'),
        (value) => NutritionPlan.fromJson(value),
      ),
    );
  }

  static T? _nullOrT<T>(dynamic value, T Function(dynamic value) fn) {
    if (value == null) return null;

    return fn(value);
  }

  Map<String, dynamic> toJson() {
    return {
      'current_step': currentStep.index,
      'dob': dob?.toIso8601String(),
      'gender': gender?.index,
      'workout_frequency': workoutFrequency?.index,
      'height': height.toJson(),
      'weight': weight.toJson(),
      'measurement_system': measurementSystem.index,
      'weight_goal': weightGoal?.toJson(),
      'diet': diet?.index,
      'meal_time_reminders': mealTimeReminders?.toJson(),
      'gpt_api_key': gptApiKey,
      'nutrition_plan': nutritionPlan?.toJson(),
    };
  }

  OnboardingStep currentStep;
  DateTime? dob;
  Gender? gender;
  WorkoutFrequency? workoutFrequency;
  UnitLength height;
  UnitWeight weight;
  MeasurementSystem measurementSystem;
  UnitWeight? weightGoal;
  Diet? diet;
  List<MealTimeReminder>? mealTimeReminders;
  String? gptApiKey;
  NutritionPlan? nutritionPlan;
}
