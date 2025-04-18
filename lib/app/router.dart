import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/pages/add_meal_data/add_meal_data_page.dart';
import 'package:ema_cal_ai/pages/onboarding_entry/onboarding_entry_page.dart';
import 'package:ema_cal_ai/pages/home/home_page.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:ema_cal_ai/pages/splash_screen/splash_screen_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final router = GoRouter(
  routes: [
    Routes.splashScreen.generateRoute(child: const SplashScreenPage()),
    Routes.onboardingEntry.generateRoute(child: const OnboardingEntryPage()),
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
