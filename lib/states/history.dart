part of 'states.dart';

final weightChartDataProvider =
    StateProvider.family<List<ChartData>, HistoryFilter>((_, _) => []);

final caloriesChartDataProvider =
    StateProvider.family<List<ChartData>, HistoryFilter>((_, _) => []);
