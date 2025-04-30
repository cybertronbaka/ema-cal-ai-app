import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/pages/add_meal_data/add_meal_data_page.dart';
import 'package:ema_cal_ai/pages/adjust_goals/adjust_goals_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_diet/edit_diet_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_dob/edit_dob_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_gemini_api_key/edit_gemini_api_key_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_gender/edit_gender_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_height_weight/edit_height_weight_page.dart';
import 'package:ema_cal_ai/pages/edit_personal_details/edit_personal_details_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_reminders/edit_reminders_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_weight_goal/edit_weight_goal_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_workout_frequency/edit_workout_frequency_page.dart';
import 'package:ema_cal_ai/pages/home/home_page.dart';
import 'package:ema_cal_ai/pages/log_weight/log_weight_page.dart';
import 'package:ema_cal_ai/pages/onboarding_entry/onboarding_entry_page.dart';
import 'package:ema_cal_ai/pages/dashboard/dashboard_page.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:ema_cal_ai/pages/overview/overview_page.dart';
import 'package:ema_cal_ai/pages/settings/settings_page.dart';
import 'package:ema_cal_ai/pages/splash_screen/splash_screen_page.dart';
import 'package:ema_cal_ai/utils/navigator_observer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GoRouter router({CustomRoute? initialRoute}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialRoute?.path(),
    observers: [rootNavigatorObserver],
    routes: [
      Routes.splashScreen.generateRoute(child: const SplashScreenPage()),
      Routes.onboardingEntry.generateRoute(child: const OnboardingEntryPage()),
      Routes.onboarding.generateRoute(child: const OnboardingPage()),
      Routes.onboardingCompleteOverview.generateRoute(
        child: const OnboardingCompleteOverviewPage(),
      ),
      StatefulShellRoute(
        branches: [
          StatefulShellBranch(
            navigatorKey: overviewNavigatorKey,
            observers: [overviewNavigatorObserver],
            preload: true,
            routes: [
              Routes.overview.generateRoute(child: const OverviewPage()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            observers: [homeNavigatorObserver],
            preload: true,
            routes: [Routes.home.generateRoute(child: const HomePage())],
          ),
          StatefulShellBranch(
            navigatorKey: settingsNavigatorKey,
            observers: [settingsNavigatorObserver],
            preload: true,
            routes: [
              Routes.settings.generateRoute(child: const SettingsPage()),
            ],
          ),
        ],
        builder: (context, state, navigationShell) {
          return navigationShell;
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return DashboardPage(
            navigationShell: navigationShell,
            children: children,
          );
        },
      ),
      Routes.editPersonalDetails.generateRoute(
        child: const EditPersonalDetailsPage(),
      ),

      Routes.editWeightGoalPage.generateRoute(
        child: const EditWeightGoalPage(),
      ),
      Routes.editHeightWeight.generateRoute(
        child: const EditHeightWeightPage(),
      ),
      Routes.editDob.generateRoute(child: const EditDobPage()),
      Routes.editGender.generateRoute(child: const EditGenderPage()),
      Routes.editMealTimeReminders.generateRoute(
        child: const EditRemindersPage(),
      ),
      Routes.editWorkoutFrequency.generateRoute(
        child: const EditWorkoutFrequencyPage(),
      ),
      Routes.editDiet.generateRoute(child: const EditDietPage()),
      Routes.editGeminiAPIKey.generateRoute(
        child: const EditGeminiApiKeyPage(),
      ),

      Routes.adjustGoals.generateRoute(child: const AdjustGoalsPage()),

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
      Routes.logWeight.generateRoute(child: const LogWeightPage()),
    ],
  );
}
