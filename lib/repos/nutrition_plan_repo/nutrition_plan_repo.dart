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

    BigInt? oldId = record?.id;

    plan = plan.copyWith(
      id: oldId?.toInt(),
      createdAt: oldId == null ? clock.now() : plan.createdAt,
      updatedAt: clock.now(),
    );

    int id;
    if (oldId == null) {
      id = await _insert(plan);
    } else {
      await _update(plan);
      id = oldId.toInt();
    }

    current = plan.toDB().copyWith(id: id.toBigInt());

    return NutritionPlan.fromDB(current!);
  }

  @override
  Future<void> clear() async {
    await database.managers.dbNutritionPlans.delete();
  }

  Future<int> _insert(NutritionPlan plan) async {
    return database
        .into(database.dbNutritionPlans)
        .insert(
          DbNutritionPlansCompanion.insert(
            timeframeInWeeks: plan.timeframeInWeeks,
            calories: plan.goal.calories,
            proteinG: plan.goal.proteinG,
            carbsG: plan.goal.carbsG,
            fatsG: plan.goal.fatsG,
            waterLiters: plan.goal.waterLiters,
            warnings: plan.notes.warnings,
            gymAdvice: plan.notes.gymAdvice,
            medicalAdvice: plan.notes.medicalAdvice,
            updatedAt: plan.updatedAt,
            createdAt: plan.createdAt,
          ),
        );
  }

  Future<void> _update(NutritionPlan plan) async {
    await database
        .update(database.dbNutritionPlans)
        .replace(
          DbNutritionPlansCompanion(
            id: plan.id.toBigInt().toDbValueOrAbsent(),
            timeframeInWeeks: plan.timeframeInWeeks.toDbValue(),
            calories: plan.goal.calories.toDbValue(),
            proteinG: plan.goal.proteinG.toDbValue(),
            carbsG: plan.goal.carbsG.toDbValue(),
            fatsG: plan.goal.fatsG.toDbValue(),
            waterLiters: plan.goal.waterLiters.toDbValue(),
            warnings: plan.notes.warnings.toDbValue(),
            gymAdvice: plan.notes.gymAdvice.toDbValue(),
            medicalAdvice: plan.notes.medicalAdvice.toDbValue(),
            updatedAt: plan.updatedAt.toDbValue(),
            createdAt: plan.createdAt.toDbValue(),
          ),
        );
  }
}
