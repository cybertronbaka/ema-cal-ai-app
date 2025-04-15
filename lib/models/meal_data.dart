import 'package:collection/collection.dart';
import 'package:ema_cal_ai/enums/enums.dart';

class MealData {
  const MealData({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.water,
    required this.createdAt,
  });

  factory MealData.fromJson(Map<String, dynamic> json) {
    return MealData(
      calories: json['calories'] as double,
      protein: json['protein'] as double,
      carbs: json['carbs'] as double,
      fats: json['fats'] as double,
      water: json['water'] as double,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double water;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'water': water,
      'created_at': createdAt.toIso8601String(),
    };
  }

  MealData operator +(MealData other) {
    return MealData(
      calories: calories + other.calories,
      protein: protein + other.protein,
      carbs: carbs + other.carbs,
      fats: fats + other.fats,
      water: water + other.water,
      createdAt: createdAt,
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
