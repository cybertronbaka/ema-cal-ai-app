part of '../add_meal_data_page.dart';

class _TitleAndPortionsSection extends ConsumerWidget {
  const _TitleAndPortionsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);
    final controller = ref.watch(addMealDataControllerProvider(pageData.data));

    final textTheme = TextTheme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: controller.data,
                builder: (_, value, _) {
                  return Text(value.mealName, style: textTheme.titleMedium);
                },
              ),
              IconButton(
                key: const Key('edit-title-btn'),
                icon: const Center(
                  child: FaIcon(FontAwesomeIcons.pencil, size: 16),
                ),
                onPressed: () => controller.editTitle(context),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(32),
            ),
            child: ValueListenableBuilder(
              valueListenable: controller.portions,
              builder: (_, value, _) {
                return CounterWidget(
                  onReduce: controller.reducePortion,
                  onAdd: controller.addPortion,
                  value: value,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
