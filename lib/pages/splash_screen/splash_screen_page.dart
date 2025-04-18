library;

import 'dart:ui';

import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreenPage extends HookConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useInitHook(() {
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (context.mounted) {
          animationController.forward();
        }
      });
    }, []);

    useInitHook(() async {
      final profile = await _setCurrentProfileIfExists(ref);
      if (profile != null && profile.isOnboardingComplete) {
        await Future.wait([
          _setNutritionPlanIfExists(ref),
          _setGptApiKeyIfExists(ref),
          _validateAndSetStreaks(ref),
          _setMealDataIfExists(ref),
          Future.delayed(const Duration(seconds: 1)),
          // Added So that user will see animation
        ]);

        if (context.mounted) {
          context.replaceNamed(Routes.home.name);
        }

        return;
      }
      await Future.wait([
        _setOnboardingDataIfExists(ref),
        Future.delayed(const Duration(seconds: 1)),
        // Added So that user will see animation
      ]);
      if (context.mounted) {
        context.replaceNamed(Routes.onboardingEntry.name);
      }
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final scale = lerpDouble(1.0, 1.5, animationController.value);

              return Transform.scale(scale: scale, child: child);
            },
            child: const Text(
              'Ema Cal AI',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserProfile?> _setCurrentProfileIfExists(WidgetRef ref) async {
    final profile = await ref.read(profileRepoProvider).get();
    ref.read(userProfileProvider.notifier).state = profile;
    return profile;
  }

  Future<void> _setNutritionPlanIfExists(WidgetRef ref) async {
    final plan = await ref.read(nutritionPlanRepoProvider).get();
    ref.read(currentNutritionPlanProvider.notifier).state = plan;
  }

  Future<void> _setGptApiKeyIfExists(WidgetRef ref) async {
    final apiKey = await ref.read(gptApiKeyRepoProvider).get();
    ref.read(gptApiKeyProvider.notifier).state = apiKey;
  }

  Future<void> _validateAndSetStreaks(WidgetRef ref) async {
    final streaks = await ref.read(streaksRepoProvider).get();
    ref.read(streaksCountProvider.notifier).state = streaks;
  }

  Future<void> _setOnboardingDataIfExists(WidgetRef ref) async {
    final onboardingData = await ref.read(onboardingSaveRepoProvider).get();
    final stepIndex = onboardingData?.currentStep.index;
    if (stepIndex != null) {
      ref.read(onboardingDataProvider.notifier).state = onboardingData;
    }
  }

  Future<void> _setMealDataIfExists(WidgetRef ref) async {
    final today = await ref.read(mealDataRepoProvider).today();
    ref.read(mealDataTodayProvider.notifier).state = today;
    final thisWeek = await ref.read(mealDataRepoProvider).thisWeek();
    ref.read(thisWeekMealDataProvider.notifier).state = thisWeek;
  }
}
