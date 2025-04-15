import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/states/meal_data.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeControllerProvider = Provider.autoDispose(
  (ref) => HomeController(ref),
);

class HomeController {
  HomeController(this.ref);

  Ref ref;

  Future<void> getTodaysMealData() async {
    try {
      final data = await ref.read(mealDataRepoProvider).today();
      ref.read(mealDataTodayProvider.notifier).state = data;

      if (data.isEmpty) return;

      final summedData = data.reduce((sum, meal) => sum + meal);
      ref.read(collectiveMealDataTodayProvider.notifier).state = summedData;
    } catch (e, st) {
      debugPrint('$e\n$st');
    }
  }

  Future<void> getThisWeekMealData() async {
    try {
      final data = await ref.read(mealDataRepoProvider).thisWeek();
      ref.read(thisWeekMealDataProvider.notifier).state = data;
    } catch (e, st) {
      debugPrint('$e\n$st');
    }
  }
}
