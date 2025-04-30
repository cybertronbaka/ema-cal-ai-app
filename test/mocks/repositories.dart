import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/gpt_nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockMealTimeRemindersRepo extends Mock implements MealTimeRemindersRepo {}

class MockGptApiKeyVerifyRepo extends Mock implements GptApiKeyVerifyRepo {}

class MockGptNutritionPlannerRepo extends Mock
    implements GptNutritionPlannerRepo {}

class MockOnboardingSaveRepo extends Mock implements OnboardingSaveRepo {}

class MockNutritionPlanRepo extends Mock implements NutritionPlanRepo {}

class MockMealDataRepo extends Mock implements MealDataRepo {}

class MockStreaksRepo extends Mock implements StreaksRepo {}

class MockHistoryRepo extends Mock implements HistoryRepo {}
