library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealDataRepoProvider = Provider<MealDataRepo>(
  (_) => throw UnimplementedError(),
);

abstract class MealDataRepo {
  Future<List<MealData>> all();
  Future<List<MealData>> today();
  Future<List<MealData>> thisWeek();
  Future<void> add(MealData data);
  Future<void> clear();
}

class LocalMealDataRepo extends MealDataRepo {
  static const boxName = 'meal_data';
  static const _valuesKey = 'data';

  @override
  Future<void> add(MealData data) async {
    final box = await _openBox();

    // Todo: move to drift
    // Hive is definitely not useful
    final fullList = await all();
    await box.put(_valuesKey, [
      ...fullList.map((e) => e.toJson()),
      data.toJson(),
    ]);
  }

  @override
  Future<List<MealData>> all() async {
    final box = await _openBox();
    if (box.isEmpty) return [];

    final allData = box.get(_valuesKey);

    if (allData is! List) {
      throw 'To get Meal Time Reminders from Hive, the values should be list';
    }
    List<MealData> result = [];
    for (var data in allData) {
      result.add(MealData.fromJson(data));
    }

    return result;
  }

  @override
  Future<List<MealData>> thisWeek() async {
    final values = await all();
    if (values.isEmpty) return [];

    final now = clock.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));

    return values.where((meal) {
      final mealDate = meal.createdAt;
      return mealDate.isAfter(
            monday.subtract(const Duration(milliseconds: 1)),
          ) &&
          (mealDate.isBefore(sunday.add(const Duration(days: 1))));
    }).toList();
  }

  @override
  Future<List<MealData>> today() async {
    final allMeals = await all();
    if (allMeals.isEmpty) return [];

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final todaysMeals =
        allMeals.where((meal) {
          return meal.createdAt.isAtSameMomentAs(todayStart) ||
              (meal.createdAt.isAfter(todayStart) &&
                  meal.createdAt.isBefore(todayEnd));
        }).toList();

    return todaysMeals;
  }

  Future<Box> _openBox() => Hive.openBox(boxName);

  @override
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
