import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final collectiveMealDataTodayProvider = StateProvider<MealData?>((_) => null);

final mealDataTodayProvider = StateProvider<List<MealData>>((_) => []);

final thisWeekMealDataProvider = StateProvider<List<MealData>>((_) => []);
