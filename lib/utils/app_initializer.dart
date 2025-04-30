import 'dart:ui';

import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
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
  }) async {
    // Only used in dev when I have to clear stuff
    // await _clearAll(container);
    final profile = await setCurrentProfileIfExists();
    if (profile != null && profile.isOnboardingComplete) {
      // await _saveWeightHistory(container);
      await Future.wait([
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
  // Future<void> _clearAll(WidgetRef ref) async {
  //   await ref.read(profileRepoProvider).clear();
  //   await ref.read(nutritionPlanRepoProvider).clear();
  //   await ref.read(streaksRepoProvider).clear();
  //   await ref.read(onboardingSaveRepoProvider).clear();
  //   await ref.read(mealDataRepoProvider).clear();
  // }

  // Future<UserProfile?> _saveWeightHistory(WidgetRef ref) async {
  //   // await ref.read(historyRepoProvider).clear();
  //   await ref
  //       .read(historyRepoProvider)
  //       .save(
  //         History(
  //           type: HistoryType.weight,
  //           value: 83,
  //           createdAt: clock.now(),
  //         ),
  //       );
  // }

  Future<void> setMealDataIfExists() async {
    await Future.wait([
      Future(() async {
        final today = await container.read(mealDataRepoProvider).today();
        container.read(mealDataTodayProvider.notifier).state = today;
        var sum = const MealDataSum.zero();
        for (var data in today) {
          sum += data;
        }
        container.read(collectiveMealDataTodayProvider.notifier).state = sum;
      }),

      Future(() async {
        final thisWeek = await container.read(mealDataRepoProvider).thisWeek();
        container.read(thisWeekMealDataProvider.notifier).state = thisWeek;
      }),
      Future(() async {
        final recentData = await container
            .read(mealDataRepoProvider)
            .lastNData(5);
        container.read(recentMealDataProvider.notifier).state = recentData;
      }),
    ]);
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
