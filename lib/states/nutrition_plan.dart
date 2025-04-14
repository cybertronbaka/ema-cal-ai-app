import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentNutritionPlanProvider = StateProvider<NutritionPlan?>((_) => null);
