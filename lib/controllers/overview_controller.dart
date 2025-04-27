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
    '3 mths': HistoryFilter.last3Months,
    '6 mths': HistoryFilter.last6Months,
    '1 yr': HistoryFilter.last1Year,
    'All': HistoryFilter.allTime,
  };

  Future<void> initWeightHistories() async {
    await Future.wait(
      weightFilters.values.map((filter) async {
        final data = await ref
            .read(historyRepoProvider)
            .getFilteredHistory(type: HistoryType.weight, filter: filter);
        ref.read(weightHistoryProvider(filter).notifier).state = data;
      }),
    );
  }
}
