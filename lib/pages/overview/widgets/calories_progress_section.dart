part of '../overview_page.dart';

class _CaloriesProgressSection extends HookConsumerWidget {
  const _CaloriesProgressSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectMealData = ref.watch(collectiveMealDataTodayProvider);
    final controller = ref.watch(overviewControllerProvider);
    final tabs = controller.caloriesFilters.keys.toList();
    final textTheme = TextTheme.of(context);

    useInitHook(() {
      controller.initCaloriesHistories();
    }, [collectMealData?.calories]);

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWithPadding(
            Text('Calories intake over time', style: textTheme.titleSmall),
          ),
          _buildWithPadding(CustomTabBar(tabs: tabs)),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                for (var filter in controller.weightFilters.values)
                  _buildChartForFilter(ref, filter),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }

  Widget _buildChartForFilter(WidgetRef ref, HistoryFilter filter) {
    final data = ref.watch(caloriesChartDataProvider(filter));

    return _buildWithPadding(DateChart(items: data));
  }
}
