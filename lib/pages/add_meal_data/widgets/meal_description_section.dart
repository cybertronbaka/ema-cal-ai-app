part of '../add_meal_data_page.dart';

class _MealDescriptionSection extends ConsumerWidget {
  const _MealDescriptionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);
    final description = pageData.data.mealDescription;
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(description, style: textTheme.bodySmall),
        ),
      ],
    );
  }
}
