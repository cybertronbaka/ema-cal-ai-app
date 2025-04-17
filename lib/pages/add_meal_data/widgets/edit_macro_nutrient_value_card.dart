part of '../add_meal_data_page.dart';

class _EditMacroNutrientValueCard extends ConsumerWidget {
  const _EditMacroNutrientValueCard({required this.type});

  final MacroNutrients type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);
    final controller = ref.watch(addMealDataControllerProvider(pageData.data));
    final textTheme = TextTheme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(150),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withAlpha(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type.label),
                  Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: controller.data,
                        builder: (_, data, _) {
                          return Text(
                            data.fromNutrientType(type).toStringAsFixed(0),
                            style: textTheme.titleSmall?.copyWith(fontSize: 14),
                          );
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.edit_rounded, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
