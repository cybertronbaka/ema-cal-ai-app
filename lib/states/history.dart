part of 'states.dart';

final weightHistoryProvider =
    StateProvider.family<List<History>, HistoryFilter>((_, _) => []);
