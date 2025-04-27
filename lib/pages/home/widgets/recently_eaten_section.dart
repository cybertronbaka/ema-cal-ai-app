part of '../home_page.dart';

class _RecentlyEatenSection extends ConsumerWidget {
  const _RecentlyEatenSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final recentData = ref.watch(recentMealDataProvider);
    final plan = ref.watch(currentNutritionPlanProvider);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recently eaten', style: textTheme.titleSmall),
        if (recentData.isEmpty || plan == null) const _NoMealDataCard(),
        if (recentData.isNotEmpty && plan != null)
          for (var data in recentData) _MealDataCard(data: data, plan: plan),
      ],
    );
  }
}

class _MealDataCard extends StatelessWidget {
  const _MealDataCard({required this.data, required this.plan});

  final MealData data;
  final NutritionPlan plan;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  data.mealName,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    intl.DateFormat(
                      '( dd-MMM-yyy hh:mm a )',
                    ).format(data.createdAt),
                    style: TextStyle(
                      color: Colors.black.withAlpha(100),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          for (final type in MacroNutrients.values)
            Row(
              spacing: 16,
              children: [
                Expanded(child: FaIcon(type.icon, size: 16, color: type.color)),
                Expanded(
                  flex: 20,
                  child: LinearProgressIndicator(
                    value: (data.fromNutrientType(type) /
                            plan.goal.fromNutrientType(type))
                        .clamp(0.0, 1.0),
                    backgroundColor: AppColors.secondary,
                    color: type.color,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
