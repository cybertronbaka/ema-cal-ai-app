import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/auth_entry/auth_entry_page.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    Routes.authEntry.generateRoute(child: const AuthEntryPage()),
    Routes.onboarding.generateRoute(child: const OnboardingPage()),
    Routes.onboardingCompleteOverview.generateRoute(
      child: const OnboardingCompleteOverviewPage(),
    ),
  ],
);
