import 'package:collection/collection.dart';
import 'package:ema_cal_ai/enums/enums.dart';

class MealData {
  const MealData({
    this.id,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.water,
    required this.createdAt,
  });

  factory MealData.fromJson(Map<dynamic, dynamic> json) {
    return MealData(
      id: json['id'],
      calories: double.parse(json['calories'].toString()),
      protein: double.parse(json['protein'].toString()),
      carbs: double.parse(json['carbs'].toString()),
      fats: double.parse(json['fats'].toString()),
      water: double.parse(json['water'].toString()),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final int? id;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double water;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'water': water,
      'created_at': createdAt.toIso8601String(),
    };
  }

  double fromNutrientType(MacroNutrients type) {
    return switch (type) {
      MacroNutrients.calories => calories.toDouble(),
      MacroNutrients.protein => protein,
      MacroNutrients.carbs => carbs,
      MacroNutrients.fats => fats,
    };
  }
}

class MealDataSum {
  const MealDataSum({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.water,
  });

  const MealDataSum.zero()
    : calories = 0,
      protein = 0,
      carbs = 0,
      fats = 0,
      water = 0;

  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double water;

  MealDataSum operator +(MealData other) {
    return MealDataSum(
      calories: calories + other.calories,
      protein: protein + other.protein,
      carbs: carbs + other.carbs,
      fats: fats + other.fats,
      water: water + other.water,
    );
  }

  double fromNutrientType(MacroNutrients type) {
    return switch (type) {
      MacroNutrients.calories => calories.toDouble(),
      MacroNutrients.protein => protein,
      MacroNutrients.carbs => carbs,
      MacroNutrients.fats => fats,
    };
  }
}

extension ListMealDataExt on List<MealData> {
  MealData? findByDate(DateTime date) {
    final searchDate = DateTime.utc(date.year, date.month, date.day);

    return firstWhereOrNull((item) {
      final date = DateTime.utc(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );
      return date == searchDate;
    });
  }
}
