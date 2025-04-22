import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final adjustGoalsControllerProvider = Provider.autoDispose(
  (ref) => AdjustGoalsController(ref),
);

class AdjustGoalsController {
  AdjustGoalsController(this.ref);

  Ref ref;

  Future<void> generateGoals(BuildContext context) async {
    final runner = FutureRunner<NutritionPlan>(
      context: context,
      onDone: (result) async {
        final plan = await ref.read(nutritionPlanRepoProvider).save(result);
        ref.read(currentNutritionPlanProvider.notifier).state = plan;
      },
    );

    await runner.run(() async {
      final profile = ref.read(userProfileProvider)!;
      return ref
          .read(nutritionPlannerRepoProvider)
          .plan(profile, profile.gptApiKey);
    });
  }
}
