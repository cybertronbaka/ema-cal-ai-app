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
    // final threeMonthsHistory = ref.watch(
    //   weightHistoryProvider(HistoryFilter.last3Months),
    // );
    // final sixMonthsHistory = ref.watch(
    //   weightHistoryProvider(HistoryFilter.last6Months),
    // );
    // final oneYearHistory = ref.watch(
    //   weightHistoryProvider(HistoryFilter.last1Year),
    // );
    // final allTimeHistory = ref.watch(
    //   weightHistoryProvider(HistoryFilter.allTime),
    // );

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
    final data = ref.watch(weightHistoryProvider(filter));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DateChart(
        dateType: switch (filter) {
          HistoryFilter.thisMonth => ChartDateType.months,
          HistoryFilter.last3Months => ChartDateType.months,
          HistoryFilter.last6Months => ChartDateType.months,
          HistoryFilter.last1Year => ChartDateType.years,
          HistoryFilter.allTime => ChartDateType.years,
        },
        // items: [
        //   DateChartItem(date: clock.now(), value: 83),
        //   DateChartItem(
        //     date: clock.now().subtract(const Duration(days: 1)),
        //     value: 84,
        //   ),
        //   DateChartItem(
        //     date: clock.now().subtract(const Duration(days: 2)),
        //     value: 86,
        //   ),
        //   DateChartItem(
        //     date: clock.now().subtract(const Duration(days: 3)),
        //     value: 88,
        //   ),
        // ],
        items:
            data.map((history) {
              return DateChartItem(
                date: history.createdAt,
                value: history.value,
              );
            }).toList(),
      ),
    );
  }
}
