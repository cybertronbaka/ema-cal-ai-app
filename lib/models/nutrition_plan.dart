import 'package:ema_cal_ai/enums/enums.dart';
import 'package:hive/hive.dart';

class NutritionPlan {
  NutritionPlan({
    required this.goal,
    required this.timeframeInWeeks,
    required this.notes,
    required this.bmiIndex,
  });

  factory NutritionPlan.fromJson(Map<dynamic, dynamic> json) {
    return NutritionPlan(
      goal: DailyNutrition.fromJson(json['goal']),
      timeframeInWeeks: json['timeframe_in_weeks'] as int,
      bmiIndex: json['bmi_index'] as double,
      notes: NutritionNotes.fromJson(json['notes']),
    );
  }

  factory NutritionPlan.fromHive(Box box) {
    return NutritionPlan(
      goal: DailyNutrition.fromJson(box.get('goal')),
      timeframeInWeeks: box.get('timeframe_in_weeks') as int,
      bmiIndex: box.get('bmi_index') as double,
      notes: NutritionNotes.fromJson(box.get('notes')),
    );
  }
  final DailyNutrition goal;
  final int timeframeInWeeks;
  final NutritionNotes notes;
  final double bmiIndex;

  Map<String, dynamic> toJson() {
    return {
      'goal': goal.toJson(),
      'timeframe_in_weeks': timeframeInWeeks,
      'notes': notes.toJson(),
      'bmi_index': bmiIndex,
    };
  }
}

class DailyNutrition {
  DailyNutrition({
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.waterLiters,
  });

  factory DailyNutrition.fromJson(Map<dynamic, dynamic> json) {
    return DailyNutrition(
      calories: json['calories'] as int,
      proteinG: (json['protein_g'] as num).toDouble(),
      carbsG: (json['carbs_g'] as num).toDouble(),
      fatsG: (json['fats_g'] as num).toDouble(),
      waterLiters: (json['water_liters'] as num).toDouble(),
    );
  }

  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double waterLiters;

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein_g': proteinG,
      'carbs_g': carbsG,
      'fats_g': fatsG,
      'water_liters': waterLiters,
    };
  }

  double fromNutrientType(MacroNutrients type) {
    return switch (type) {
      MacroNutrients.calories => calories.toDouble(),
      MacroNutrients.protein => proteinG,
      MacroNutrients.carbs => carbsG,
      MacroNutrients.fats => fatsG,
      MacroNutrients.water => waterLiters,
    };
  }
}

// NutritionNotes remains unchanged
class NutritionNotes {
  NutritionNotes({
    required this.gymAdvice,
    required this.medicalAdvice,
    required this.warnings,
  });

  factory NutritionNotes.fromJson(Map<dynamic, dynamic> json) {
    return NutritionNotes(
      gymAdvice: json['gym_advice'] as String,
      medicalAdvice: json['medical_advice'] as String,
      warnings: json['warnings'] as String,
    );
  }

  final String gymAdvice;
  final String medicalAdvice;
  final String warnings;

  Map<String, dynamic> toJson() {
    return {
      'gym_advice': gymAdvice,
      'medical_advice': medicalAdvice,
      'warnings': warnings,
    };
  }
}
