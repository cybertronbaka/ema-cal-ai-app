import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';

class MealData {
  MealData({
    this.id,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.water,
    required this.mealName,
    required this.mealDescription,
    required this.updatedAt,
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
      mealName: json['meal_name'],
      mealDescription: json['meal_name'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  factory MealData.fromDB(DbMealData data) {
    return MealData(
      id: data.id.toInt(),
      calories: data.calories,
      protein: data.protein,
      carbs: data.carbs,
      fats: data.fats,
      water: data.water,
      mealName: data.mealName,
      mealDescription: data.mealDescription,
      updatedAt: data.updatedAt,
      createdAt: data.createdAt,
    );
  }

  final int? id;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double water;
  final String mealName;
  final String? mealDescription;
  final DateTime updatedAt;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'water': water,
      'meal_name': mealName,
      'meal_description': mealDescription,
      'created_at': createdAt.toIso8601String(),
    };
  }

  double fromNutrientType(MacroNutrients type) {
    return switch (type) {
      MacroNutrients.calories => calories.toDouble(),
      MacroNutrients.protein => protein,
      MacroNutrients.carbs => carbs,
      MacroNutrients.fats => fats,
      MacroNutrients.water => water,
    };
  }

  MealData operator *(num scalar) {
    return MealData(
      id: id,
      calories: calories * scalar,
      protein: protein * scalar,
      carbs: carbs * scalar,
      water: water * scalar,
      fats: fats * scalar,
      mealName: mealName,
      mealDescription: mealDescription,
      createdAt: createdAt,
      updatedAt: clock.now(),
    );
  }

  MealData copyNutrientValue(double value, MacroNutrients type) {
    return switch (type) {
      MacroNutrients.calories => copyWith(calories: value),
      MacroNutrients.protein => copyWith(protein: value),
      MacroNutrients.carbs => copyWith(carbs: value),
      MacroNutrients.fats => copyWith(fats: value),
      MacroNutrients.water => copyWith(water: value),
    };
  }

  MealData copyWith({
    int? id,
    double? calories,
    double? protein,
    double? carbs,
    double? fats,
    double? water,
    String? mealName,
    String? mealDescription,
  }) {
    return MealData(
      id: id ?? this.id,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      water: water ?? this.water,
      mealName: mealName ?? this.mealName,
      mealDescription: mealDescription,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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
      MacroNutrients.water => water,
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
