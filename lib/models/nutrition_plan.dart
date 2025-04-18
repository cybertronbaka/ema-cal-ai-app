import 'package:clock/clock.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Todo: Simply use DbNutritionPlan instead of this.
// Todo: Will need to adapt the ui to and rest of the logic.
// So once the db setup is done, we will do that
class NutritionPlan {
  NutritionPlan({
    this.id,
    required this.goal,
    required this.timeframeInWeeks,
    required this.notes,
    required this.bmiIndex,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NutritionPlan.fromJson(Map<dynamic, dynamic> json) {
    return NutritionPlan(
      id: null,
      goal: DailyNutrition.fromJson(json['goal']),
      timeframeInWeeks: json['timeframe_in_weeks'] as int,
      bmiIndex: json['bmi_index'] as double,
      notes: NutritionNotes.fromJson(json['notes']),
      createdAt: clock.now(),
      updatedAt: clock.now(),
    );
  }

  factory NutritionPlan.fromDB(DbNutritionPlan data) {
    return NutritionPlan(
      goal: DailyNutrition(
        calories: data.calories,
        proteinG: data.proteinG,
        carbsG: data.carbsG,
        fatsG: data.fatsG,
        waterLiters: data.waterLiters,
      ),
      timeframeInWeeks: data.timeframeInWeeks,
      notes: NutritionNotes(
        gymAdvice: data.gymAdvice,
        medicalAdvice: data.medicalAdvice,
        warnings: data.warnings,
      ),
      bmiIndex: data.bmiIndex,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  DbNutritionPlan toDB() {
    return DbNutritionPlan(
      id: -1.toBigInt(),
      calories: goal.calories,
      proteinG: goal.proteinG,
      carbsG: goal.carbsG,
      fatsG: goal.fatsG,
      waterLiters: goal.waterLiters,
      timeframeInWeeks: timeframeInWeeks,
      gymAdvice: notes.gymAdvice,
      medicalAdvice: notes.medicalAdvice,
      warnings: notes.warnings,
      bmiIndex: bmiIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  final int? id;
  final DailyNutrition goal;
  final int timeframeInWeeks;
  final NutritionNotes notes;
  final double bmiIndex;
  final DateTime updatedAt;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': 'id',
      'goal': goal.toJson(),
      'timeframe_in_weeks': timeframeInWeeks,
      'notes': notes.toJson(),
      'bmi_index': bmiIndex,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  NutritionPlan copyWith({int? id}) {
    return NutritionPlan(
      id: id,
      goal: goal,
      timeframeInWeeks: timeframeInWeeks,
      notes: notes,
      bmiIndex: bmiIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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

  String fromNoteType(NutritionNoteType type) {
    return switch (type) {
      NutritionNoteType.warnings => warnings,
      NutritionNoteType.gymAdvice => gymAdvice,
      NutritionNoteType.medicalAdvice => medicalAdvice,
    };
  }
}

enum NutritionNoteType {
  warnings('Warnings', FontAwesomeIcons.triangleExclamation, Color(0xFFFAF5E5)),
  gymAdvice('Gym Advice', FontAwesomeIcons.dumbbell, Color(0xFFEFF6FF)),
  medicalAdvice(
    'Medical Advice',
    FontAwesomeIcons.stethoscope,
    Color(0xFFFFD6D6),
  );

  const NutritionNoteType(this.label, this.icon, this.bgColor);

  final String label;
  final IconData icon;
  final Color bgColor;
}
