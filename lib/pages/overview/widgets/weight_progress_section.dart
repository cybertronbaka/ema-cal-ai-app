part of '../overview_page.dart';

// Todo: Figure out how to handle edge cases like:
// 1: for all time (if there are only 1 - 14 data points)
// 2: if(there are more than 14 months but time difference is too low)
// and such
// ignore: unused_element
class _WeightProgressSection extends HookConsumerWidget {
  const _WeightProgressSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(overviewControllerProvider);
    final tabs = controller.weightFilters.keys.toList();

    useInitHook(() {
      controller.initWeightHistories();
    }, []);

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTabBar(tabs: tabs),
          ),
          SizedBox(
            height: 200,
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

  Widget _buildChartForFilter(WidgetRef ref, HistoryFilter filter) {
    final data = ref.watch(weightChartDataProvider(filter));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DateChart(
        items: data,
      ),
    );
  }
}
