part of '../add_meal_data_page.dart';

class _WaterIntakeSection extends ConsumerWidget {
  const _WaterIntakeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);
    if (pageData.data.water == 0) return const SizedBox.shrink();

    final controller = ref.watch(addMealDataControllerProvider(pageData.data));

    return Column(
      children: [
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: controller.data,
          builder: (_, data, _) {
            return WaterIntakeCard.onlyValue(
              value: data.water,
              description: 'Water Level',
              isEditable: true,
              onEdit:
                  () => controller.editNutritionValue(
                    context,
                    MacroNutrients.water,
                  ),
            );
          },
        ),
      ],
    );
  }
}
