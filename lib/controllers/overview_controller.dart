import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final overviewControllerProvider = Provider.autoDispose(
  (ref) => OverviewController(ref),
);

class OverviewController {
  OverviewController(this.ref);

  Ref ref;

  final weightFilters = {
    '1 mth': HistoryFilter.thisMonth,
    '6 mths': HistoryFilter.last6Months,
    '1 yr': HistoryFilter.last1Year,
    'All': HistoryFilter.allTime,
  };

  final caloriesFilters = {
    '1 mth': HistoryFilter.thisMonth,
    '6 mths': HistoryFilter.last6Months,
    '1 yr': HistoryFilter.last1Year,
    'All': HistoryFilter.allTime,
  };

  Future<void> initWeightHistories() async {
    await Future.wait(
      weightFilters.values.map((filter) async {
        final data = await ref
            .read(historyRepoProvider)
            .getChartData(type: HistoryType.weight, filter: filter);

        ref.read(weightChartDataProvider(filter).notifier).state = data;
      }),
    );
  }

  Future<void> initCaloriesHistories() async {
    await Future.wait(
      caloriesFilters.values.map((filter) async {
        final data = await ref
            .read(historyRepoProvider)
            .getChartData(
              type: HistoryType.calories,
              filter: filter,
              aggregateType: AggregateType.sum,
            );

        ref.read(caloriesChartDataProvider(filter).notifier).state = data;
      }),
    );
  }
}
