import 'dart:ui';

import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppInitializer {
  const AppInitializer(this.container);
  final ProviderContainer container;

  Future<void> init({
    VoidCallback? afterInitializingUserData,
    VoidCallback? onNoUser,
    // Only used in dev when I have to clear stuff
    bool clearAll = false,
  }) async {
    // Only used in dev when I have to clear stuff
    if (clearAll) await _clearAll();
    final profile = await setCurrentProfileIfExists();
    if (profile != null && profile.isOnboardingComplete) {
      // await _saveWeightHistory(container);
      await Future.wait([
        setCurrentWeight(profile),
        setPackageInfo(),
        setNutritionPlanIfExists(),
        validateAndSetStreaks(),
        setMealDataIfExists(),
        setMealTimeReminders(),
        Future.delayed(const Duration(seconds: 1)),
        // Added So that user will see animation
      ]);

      afterInitializingUserData?.call();
      return;
    }
    await Future.wait([
      setOnboardingDataIfExists(),
      Future.delayed(const Duration(seconds: 1)),
      // Added So that user will see animation
    ]);
    onNoUser?.call();
  }

  // Only used in dev when I have to clear stuff
  Future<void> _clearAll() async {
    await container.read(profileRepoProvider).clear();
    await container.read(nutritionPlanRepoProvider).clear();
    await container.read(streaksRepoProvider).clear();
    await container.read(onboardingSaveRepoProvider).clear();
    await container.read(mealDataRepoProvider).clear();
    await container.read(historyRepoProvider).clear();
  }

  Future<void> setCurrentWeight(UserProfile profile) async {
    final weightInKg =
        await container.read(historyRepoProvider).getLatestWeight();
    container.read(currentWeightProvider.notifier).state = UnitWeight.fromKg(
      weightInKg.value,
      profile.isMetric,
    );
  }

  Future<void> setMealDataIfExists() async {
    await Future.wait([
      setTodaysMealDataIfExists(),
      setThisWeekMealDataIfExists(),
      setRecentMealDataIfExists(),
    ]);
  }

  Future<void> setRecentMealDataIfExists() async {
    final recentData = await container.read(mealDataRepoProvider).lastNData(5);
    container.read(recentMealDataProvider.notifier).state = recentData;
  }

  Future<void> setThisWeekMealDataIfExists() async {
    final thisWeek = await container.read(mealDataRepoProvider).thisWeek();
    container.read(thisWeekMealDataProvider.notifier).state = thisWeek;
  }

  Future<void> setTodaysMealDataIfExists() async {
    final today = await container.read(mealDataRepoProvider).today();
    container.read(mealDataTodayProvider.notifier).state = today;
    var sum = const MealDataSum.zero();
    for (var data in today) {
      sum += data;
    }
    container.read(collectiveMealDataTodayProvider.notifier).state = sum;
  }

  Future<UserProfile?> setCurrentProfileIfExists() async {
    final profile = await container.read(profileRepoProvider).get();
    container.read(userProfileProvider.notifier).state = profile;
    container.read(gptApiKeyProvider.notifier).state = profile?.gptApiKey;
    return profile;
  }

  Future<void> setNutritionPlanIfExists() async {
    final plan = await container.read(nutritionPlanRepoProvider).get();
    container.read(currentNutritionPlanProvider.notifier).state = plan;
  }

  Future<void> setMealTimeReminders() async {
    final reminders = await container.read(mealTimeRemindersRepoProvider).get();
    container.read(mealTimeRemindersProvider.notifier).state = reminders;
  }

  Future<void> setPackageInfo() async {
    final packageInfo = container.read(packageInfoProvider);
    container.read(packageInfoProvider.notifier).state = packageInfo;
  }

  Future<void> validateAndSetStreaks() async {
    await container.read(streaksRepoProvider).validateAndReset();
    final streaks = await container.read(streaksRepoProvider).get();
    container.read(streaksCountProvider.notifier).state = streaks;
  }

  Future<void> setOnboardingDataIfExists() async {
    final onboardingData =
        await container.read(onboardingSaveRepoProvider).get();
    final stepIndex = onboardingData?.currentStep.index;
    if (stepIndex != null) {
      container.read(onboardingDataProvider.notifier).state = onboardingData;
    }
    container.read(gptApiKeyProvider.notifier).state =
        onboardingData?.gptApiKey;
  }
}
