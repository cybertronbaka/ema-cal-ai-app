part of '../add_meal_data_page.dart';

class _ImageSection extends ConsumerWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);

    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: pageData.image.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                width: double.infinity,
                child: Image.memory(snapshot.requireData, fit: BoxFit.cover),
              );
            },
          ),
        ),
        const Expanded(child: SizedBox.expand()),
      ],
    );
  }
}
