part of '../home_page.dart';

class _RecentlyEatenSection extends ConsumerWidget {
  const _RecentlyEatenSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final todayList = ref.watch(mealDataTodayProvider);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recently eaten', style: textTheme.titleSmall),
        if (todayList.isEmpty) const _NoMealDataCard(),
        if (todayList.isNotEmpty)
          for (var data in todayList) _MealDataCard(data: data),
      ],
    );
  }
}

class _MealDataCard extends StatelessWidget {
  const _MealDataCard({required this.data});

  final MealData data;
  @override
  Widget build(BuildContext context) {
    return Text(data.toJson().toString());
  }
}
