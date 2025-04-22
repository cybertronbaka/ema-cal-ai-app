part of '../home_content.dart';

class _WaterIntakeSection extends ConsumerWidget {
  const _WaterIntakeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(currentNutritionPlanProvider);
    final mealData = ref.watch(collectiveMealDataTodayProvider);

    return WaterIntakeCard(
      max: plan?.goal.waterLiters ?? 10,
      value: mealData?.water ?? 0,
    );
  }
}
