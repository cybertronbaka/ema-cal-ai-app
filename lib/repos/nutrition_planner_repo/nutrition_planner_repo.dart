library;

import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/extensions/date_time.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'gemini/config.dart';
part 'gemini/gemin_nutrition_planner_repo.dart';
part 'gemini/prompt.dart';

final nutritionPlannerRepoProvider = Provider<NutritionPlannerRepo>(
  (_) => throw UnimplementedError(),
);

abstract class NutritionPlannerRepo {
  Future<String> plan(UserProfile profile);
}
