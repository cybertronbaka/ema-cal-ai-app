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
    required Widget child,
  }) {
    return GoRoute(
      name: name,
      path: path(), // Todo: Solve a way to resolve path here or do I need to?
      pageBuilder:
          pageBuilder ??
          (transition != null
              ? (context, state) =>
                  transition!(key: state.pageKey, child: child)
              : null),
      builder:
          builder ??
          (pageBuilder == null && transition == null
              ? (context, state) => child
              : null),
    );
  }
}

abstract class Routes {
  static final CustomRoute authEntry = CustomRoute(
    name: 'authEntry',
    path: ([args]) => '/',
  );

  static final CustomRoute onboarding = CustomRoute(
    name: 'onboarding',
    path: ([args]) => '/onboarding',
  );
}
