part of 'states.dart';

final collectiveMealDataTodayProvider = StateProvider<MealDataSum?>(
  (_) => null,
);

final mealDataTodayProvider = StateProvider<List<MealData>>((_) => []);

final thisWeekMealDataProvider = StateProvider<List<MealData>>((_) => []);

final recentMealDataProvider = StateProvider<List<MealData>>((_) => []);
