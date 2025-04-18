library;

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealDataRepoProvider = Provider<MealDataRepo>(
  (_) => throw UnimplementedError(),
);

abstract class MealDataRepo {
  Future<List<MealData>> all();
  Future<List<MealData>> today();
  Future<List<MealData>> thisWeek();
  Future<List<MealData>> lastNDays(int n);

  Future<MealData> add(MealData data);
  Future<void> clear();
}

class LocalMealDataRepo extends MealDataRepo {
  @override
  Future<List<MealData>> all() async {
    final data = await database.select(database.dbMealDatas).get();
    return _listFromDb(data);
  }

  List<MealData> _listFromDb(List<DbMealData> data) {
    return data.map((e) => MealData.fromDB(e)).toList();
  }

  @override
  Future<MealData> add(MealData data) async {
    final oldId = data.id.toBigInt();
    final createdAt = data.id == null ? clock.now() : data.createdAt;

    final id = await database
        .into(database.dbMealDatas)
        .insertOnConflictUpdate(
          DbMealDatasCompanion(
            id: oldId.toDbValueOrAbsent(),
            calories: data.calories.toDbValue(),
            protein: data.protein.toDbValue(),
            carbs: data.protein.toDbValue(),
            fats: data.fats.toDbValue(),
            water: data.water.toDbValue(),
            mealName: data.mealName.toDbValue(),
            mealDescription: data.mealDescription.toDbNullableValue(),
            updatedAt: clock.now().toDbValue(),
            createdAt: createdAt.toDbValue(),
          ),
        );

    return data.copyWith(id: id);
  }

  @override
  Future<void> clear() async {
    await database.managers.dbMealDatas.delete();
  }

  @override
  Future<List<MealData>> thisWeek() async {
    final now = clock.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));
    final values =
        await database.managers.dbMealDatas
            .filter(
              (f) =>
                  f.createdAt.isAfter(
                    monday.subtract(const Duration(milliseconds: 1)),
                  ) &
                  f.createdAt.isBefore(sunday.add(const Duration(days: 1))),
            )
            .get();

    return _listFromDb(values);
  }

  @override
  Future<List<MealData>> today() async {
    final now = clock.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final values =
        await database.managers.dbMealDatas
            .filter(
              (f) =>
                  f.createdAt.isAfterOrOn(todayStart) &
                  f.createdAt.isBefore(todayEnd),
            )
            .get();

    return _listFromDb(values);
  }

  @override
  Future<List<MealData>> lastNDays(int n) async {
    final now = clock.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final start = todayStart.subtract(Duration(days: n));
    final todayEnd = todayStart.add(const Duration(days: 1));

    final values =
        await database.managers.dbMealDatas
            .filter(
              (f) =>
                  f.createdAt.isAfterOrOn(start) &
                  f.createdAt.isBefore(todayEnd),
            )
            .get();

    return _listFromDb(values);
  }
}
