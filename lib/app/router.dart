import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/auth_entry/auth_entry_page.dart';
import 'package:ema_cal_ai/pages/home/home_page.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:ema_cal_ai/repos/nutrition_plan_repo/nutrition_plan_repo.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/states/nutrition_plan.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final router = GoRouter(
  routes: [
    Routes.authEntry.generateRoute(
      child: const AuthEntryPage(),
      redirect: (context, state) async {
        final container = ProviderScope.containerOf(context);

        final profile = await container.read(profileRepoProvider).get();
        container.read(userProfileProvider.notifier).state = profile;

        final plan = await container.read(nutritionPlanRepoProvider).get();
        container.read(currentNutritionPlanProvider.notifier).state = plan;

        if (profile != null && profile.isOnboardingComplete) {
          return Routes.home.path();
        }

        return null;
      },
    ),
    Routes.onboarding.generateRoute(child: const OnboardingPage()),
    Routes.onboardingCompleteOverview.generateRoute(
      child: const OnboardingCompleteOverviewPage(),
    ),
    Routes.home.generateRoute(child: const HomePage()),
  ],
);
