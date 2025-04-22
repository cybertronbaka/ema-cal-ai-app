import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef PageBuilder = Page<dynamic> Function(BuildContext, GoRouterState);
typedef TransitionBuilder<T> =
    CustomTransitionPage<T> Function({
      required LocalKey key,
      required Widget child,
    });

TransitionBuilder<void> getNoTransitionBuilder() {
  NoTransitionPage<void> builder({
    required LocalKey key,
    required Widget child,
  }) {
    return NoTransitionPage<void>(key: key, child: child);
  }

  return builder;
}

class CustomRoute {
  const CustomRoute({required this.name, required this.path, this.transition});

  final String Function([Map<String, String>? args]) path;
  final String name;
  final TransitionBuilder? transition;

  GoRoute generateRoute({
    PageBuilder? pageBuilder,
    Widget Function(BuildContext, GoRouterState)? builder,
    FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
    Widget? child,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      name: name,
      path: path(), // Todo: Solve a way to resolve path here or do I need to?
      redirect: redirect,
      pageBuilder:
          pageBuilder ??
          (transition != null && child != null
              ? (context, state) =>
                  transition!(key: state.pageKey, child: child)
              : null),
      builder:
          builder ??
          (pageBuilder == null && transition == null && child != null
              ? (context, state) => child
              : null),
      routes: routes,
    );
  }
}

abstract class Routes {
  static final CustomRoute splashScreen = CustomRoute(
    name: 'splashScreen',
    path: ([args]) => '/',
  );

  static final CustomRoute onboardingEntry = CustomRoute(
    name: 'onboardingEntry',
    path: ([args]) => '/onboardingEntry',
  );

  static final CustomRoute onboarding = CustomRoute(
    name: 'onboarding',
    path: ([args]) => '/onboarding',
  );

  static final CustomRoute onboardingCompleteOverview = CustomRoute(
    name: 'onboardingCompleteOverview',
    path: ([args]) => '/onboardingCompleteOverview',
  );

  static final CustomRoute addMealData = CustomRoute(
    name: 'addMealData',
    path: ([args]) => '/addMealData',
  );

  static final CustomRoute home = CustomRoute(
    name: 'home',
    path: ([args]) => '/home',
  );

  static final CustomRoute settings = CustomRoute(
    name: 'settings',
    path: ([args]) => '/settings',
  );

  static final CustomRoute editPersonalDetails = CustomRoute(
    name: 'editPersonalDetails',
    path: ([args]) => '/settings/editPersonalDetails',
  );

  static final CustomRoute editWeightGoalPage = CustomRoute(
    name: 'editGoalPage',
    path: ([args]) => '/settings/editPersonalDetails/editGoalPage',
  );

  static final CustomRoute editHeightWeight = CustomRoute(
    name: 'editHeightWeight',
    path: ([args]) => '/settings/editPersonalDetails/editHeightWeight',
  );

  static final CustomRoute editDob = CustomRoute(
    name: 'editDob',
    path: ([args]) => '/settings/editPersonalDetails/editDob',
  );

  static final CustomRoute editGender = CustomRoute(
    name: 'editGender',
    path: ([args]) => '/settings/editPersonalDetails/editGender',
  );

  static final CustomRoute editMealTimeReminders = CustomRoute(
    name: 'editMealTimeReminders',
    path: ([args]) => '/settings/editPersonalDetails/editMealTimeReminders',
  );

  static final CustomRoute overview = CustomRoute(
    name: 'overview',
    path: ([args]) => '/overview',
  );
}
