import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';

// Todo: Simply use DbOnboardingData instead of this.
// Todo: Will need to adapt the ui to and rest of the logic.
// So once the db setup is done, we will do that
class OnboardingData {
  OnboardingData({
    this.id,
    required this.currentStep,
    this.dob,
    this.gender,
    this.workoutFrequency,
    required this.height,
    required this.weight,
    this.isMetric = true,
    this.weightGoal,
    this.diet,
    this.mealTimeReminders,
    this.gptApiKey,
    this.nutritionPlan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OnboardingData.fromDB(DbOnboardingData data) {
    final isMetric = data.isMetric ?? true;

    return OnboardingData(
      id: data.id.toInt(),
      currentStep: data.currentStep,
      dob: data.dob,
      gender: data.gender,
      workoutFrequency: data.workoutFrequency,
      height:
          data.heightCm != null
              ? UnitLength.fromCm(data.heightCm!, isMetric)
              : UnitLength.fromCm(163, isMetric),
      weight:
          data.weightKg != null
              ? UnitWeight.fromKg(data.weightKg!, isMetric)
              : UnitWeight.fromKg(50, isMetric),
      isMetric: isMetric,
      weightGoal: _nullOrT(
        data.weightGoalKg,
        (value) => UnitWeight.fromKg(value, isMetric),
      ),
      diet: data.diet,
      gptApiKey: data.gptApiKey,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  DbOnboardingData toDB() {
    return DbOnboardingData(
      id: -1.toBigInt(),
      currentStep: currentStep,
      dob: dob,
      gender: gender,
      workoutFrequency: workoutFrequency,
      heightCm: height.cm,
      weightKg: weight.kg,
      isMetric: isMetric,
      weightGoalKg: weightGoal?.kg,
      diet: diet,
      gptApiKey: gptApiKey,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static T? _nullOrT<T>(dynamic value, T Function(dynamic value) fn) {
    if (value == null) return null;

    return fn(value);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'current_step': currentStep.index,
      'dob': dob?.toIso8601String(),
      'gender': gender?.index,
      'workout_frequency': workoutFrequency?.index,
      'height': height.toJson(),
      'weight': weight.toJson(),
      'is_metric': isMetric,
      'weight_goal': weightGoal?.toJson(),
      'diet': diet?.index,
      'meal_time_reminders': mealTimeReminders?.toJson(),
      'gpt_api_key': gptApiKey,
      'nutrition_plan': nutritionPlan?.toJson(),
    };
  }

  int? id;
  OnboardingStep currentStep;
  DateTime? dob;
  Gender? gender;
  WorkoutFrequency? workoutFrequency;
  UnitLength height;
  UnitWeight weight;
  bool isMetric;
  UnitWeight? weightGoal;
  Diet? diet;
  List<MealTimeReminder>? mealTimeReminders;
  String? gptApiKey;
  NutritionPlan? nutritionPlan;
  DateTime createdAt;
  DateTime updatedAt;

  OnboardingData copyWith({
    int? id,
    OnboardingStep? currentStep,
    DateTime? dob,
    Gender? gender,
    WorkoutFrequency? workoutFrequency,
    UnitLength? height,
    UnitWeight? weight,
    bool? isMetric,
    UnitWeight? weightGoal,
    Diet? diet,
    List<MealTimeReminder>? mealTimeReminders,
    String? gptApiKey,
    NutritionPlan? nutritionPlan,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OnboardingData(
      id: id ?? this.id,
      currentStep: currentStep ?? this.currentStep,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isMetric: isMetric ?? this.isMetric,
      weightGoal: weightGoal ?? this.weightGoal,
      diet: diet ?? this.diet,
      mealTimeReminders: mealTimeReminders ?? this.mealTimeReminders,
      gptApiKey: gptApiKey ?? this.gptApiKey,
      nutritionPlan: nutritionPlan ?? this.nutritionPlan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
