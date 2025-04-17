part of '../home_page.dart';

class _DailyMacroNutrientIntakeCard extends ConsumerWidget {
  const _DailyMacroNutrientIntakeCard({required this.type});

  final MacroNutrients type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final plan = ref.watch(currentNutritionPlanProvider);
    final mealData = ref.watch(collectiveMealDataTodayProvider);

    final max = plan?.goal.fromNutrientType(type).toDouble() ?? 0.0;
    final value = mealData?.fromNutrientType(type) ?? 0;
    final remaining = (max - value).clamp(0.0, max);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withAlpha(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${remaining.toInt()}${type.unit}',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 2),
            Text('${type.label} left', style: textTheme.bodySmall),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        value: (value / max).clamp(0.0, 1.0),
                        backgroundColor: Colors.grey.withAlpha(100),
                        color: type.color,
                        strokeWidth: 5,
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkGrey.withAlpha(20),
                          ),
                          child: const Icon(
                            Icons.bolt_rounded,
                          ), // Todo: Change the icon Use SVGs
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
