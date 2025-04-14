library;

import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nutritionPlanRepoProvider = Provider<NutritionPlanRepo>(
  (_) => throw UnimplementedError(),
);

abstract class NutritionPlanRepo {
  Future<NutritionPlan?> get();
  Future<void> save(NutritionPlan plan);
}

class LocalNutritionPlanRepo extends NutritionPlanRepo {
  static const boxName = 'nutrition_plan';

  @override
  Future<NutritionPlan?> get() async {
    final box = await _openBox();
    if (box.isEmpty) return null;

    return NutritionPlan.fromHive(box);
  }

  @override
  Future<void> save(NutritionPlan plan) async {
    final box = await _openBox();
    await box.putAll(plan.toJson());
  }

  Future<Box> _openBox() => Hive.openBox(boxName);
}
