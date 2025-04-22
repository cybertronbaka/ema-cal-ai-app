part of '../dashboard_page.dart';

class _DailyCaloriesIntakeCard extends ConsumerWidget {
  const _DailyCaloriesIntakeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final plan = ref.watch(currentNutritionPlanProvider);
    final mealData = ref.watch(collectiveMealDataTodayProvider);

    final max = plan?.goal.calories.toDouble() ?? 0.0;
    final value = mealData?.calories ?? 0;
    final remaining = (max - value).clamp(0.0, max);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  remaining.toInt().toString(),
                  style: textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Calories left',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: (value / max).clamp(0.0, 1.0),
                      backgroundColor: Colors.grey.withAlpha(100),
                      color: MacroNutrients.calories.color,
                      strokeWidth: 5,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MacroNutrients.calories.color.withAlpha(20),
                      ),
                      child: FaIcon(
                        MacroNutrients.calories.icon,
                        size: 20,
                        color: MacroNutrients.calories.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
