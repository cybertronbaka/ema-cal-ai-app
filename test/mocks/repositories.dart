import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_planner_repo/nutrition_planner_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockMealTimeRemindersRepo extends Mock implements MealTimeRemindersRepo {}

class MockGptApiKeyRepo extends Mock implements GptApiKeyRepo {}

class MockGptApiKeyVerifyRepo extends Mock implements GptApiKeyVerifyRepo {}

class MockNutritionPlannerRepo extends Mock implements NutritionPlannerRepo {}
