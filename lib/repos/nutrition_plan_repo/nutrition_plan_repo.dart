library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nutritionPlanRepoProvider = Provider<NutritionPlanRepo>(
  (_) => throw UnimplementedError(),
);

abstract class NutritionPlanRepo {
  Future<NutritionPlan?> get();
  Future<NutritionPlan> save(NutritionPlan plan);
  Future<void> clear();
}

class LocalNutritionPlanRepo extends NutritionPlanRepo {
  DbNutritionPlan? current;
  @override
  Future<NutritionPlan?> get() async {
    final data = await _getAndSaveCurrent();
    if (data == null) return null;

    return NutritionPlan.fromDB(data);
  }

  Future<DbNutritionPlan?> _getAndSaveCurrent() async {
    final query = database.select(database.dbNutritionPlans)..limit(1);
    final data = await query.getSingleOrNull();

    current = data;
    return data;
  }

  @override
  Future<NutritionPlan> save(NutritionPlan plan) async {
    var record = current == null ? await _getAndSaveCurrent() : current!;

    BigInt? oldId;
    if (record == null) {
      oldId = null.toBigInt();
    } else {
      oldId = record.id;
    }

    final createdAt = oldId == null ? clock.now() : plan.createdAt;
    final now = clock.now();

    final id = await database
        .into(database.dbNutritionPlans)
        .insertOnConflictUpdate(
          DbNutritionPlansCompanion(
            id: oldId.toDbValueOrAbsent(),
            timeframeInWeeks: plan.timeframeInWeeks.toDbValue(),
            bmiIndex: plan.bmiIndex.toDbValue(),
            calories: plan.goal.calories.toDbValue(),
            proteinG: plan.goal.proteinG.toDbValue(),
            carbsG: plan.goal.carbsG.toDbValue(),
            fatsG: plan.goal.fatsG.toDbValue(),
            waterLiters: plan.goal.waterLiters.toDbValue(),
            warnings: plan.notes.warnings.toDbValue(),
            gymAdvice: plan.notes.gymAdvice.toDbValue(),
            medicalAdvice: plan.notes.medicalAdvice.toDbValue(),
            updatedAt: now.toDbValue(),
            createdAt: createdAt.toDbValue(),
          ),
        );

    current = plan.toDB().copyWith(
      id: id.toBigInt(),
      createdAt: createdAt,
      updatedAt: now,
    );

    return NutritionPlan.fromDB(current!);
  }

  @override
  Future<void> clear() async {
    await database.managers.dbNutritionPlans.delete();
  }
}
