library;

import 'dart:convert';

import 'package:ema_cal_ai/extensions/date_time.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'gemini/config.dart';
part 'gemini/gemini_nutrition_planner_repo.dart';
part 'gemini/prompt.dart';

final gptNutritionPlannerRepoProvider = Provider<GptNutritionPlannerRepo>(
  (_) => throw UnimplementedError(),
);

abstract class GptNutritionPlannerRepo {
  Future<NutritionPlan> plan(UserProfile profile, String gptApiKey);
}
