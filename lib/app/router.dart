import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/pages/add_meal_data/add_meal_data_page.dart';
import 'package:ema_cal_ai/pages/onboarding_entry/onboarding_entry_page.dart';
import 'package:ema_cal_ai/pages/home/home_page.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/onboarding_save_repo/onboarding_save_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final router = GoRouter(
  routes: [
    Routes.onboardingEntry.generateRoute(
      child: const OnboardingEntryPage(),
      redirect: (context, state) async {
        final container = ProviderScope.containerOf(context);

        final profile = await container.read(profileRepoProvider).get();
        container.read(userProfileProvider.notifier).state = profile;

        final plan = await container.read(nutritionPlanRepoProvider).get();
        container.read(currentNutritionPlanProvider.notifier).state = plan;

        final apiKey = await container.read(gptApiKeyRepoProvider).get();
        container.read(gptApiKeyProvider.notifier).state = apiKey;

        final streaks = await container.read(streaksRepoProvider).get();
        container.read(streaksCountProvider.notifier).state = streaks;

        if (profile != null && profile.isOnboardingComplete) {
          return Routes.home.path();
        }

        final onboardingData =
            await container.read(onboardingSaveRepoProvider).get();

        final stepIndex = onboardingData?.currentStep.index;

        if (stepIndex != null) {
          container.read(onboardingDataProvider.notifier).state =
              onboardingData;
        }

        return null;
      },
    ),
    Routes.onboarding.generateRoute(child: const OnboardingPage()),
    Routes.onboardingCompleteOverview.generateRoute(
      child: const OnboardingCompleteOverviewPage(),
    ),
    Routes.home.generateRoute(child: const HomePage()),
    Routes.addMealData.generateRoute(
      builder: (context, state) {
        // Todo: To get from local db and if nothing is found redirect to route not found page under redirect callback
        // if(state.extra is! AddMealDataPage){}
        return ProviderScope(
          overrides: [
            addMealDataPageDataProvider.overrideWithValue(
              state.extra as AddMealDataPageData,
            ),
          ],
          child: const AddMealDataPage(),
        );
      },
    ),
  ],
);
