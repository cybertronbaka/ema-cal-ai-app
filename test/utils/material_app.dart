import 'package:ema_cal_ai/app/router.dart' as app_router;
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget createTestMaterialApp({
  Widget? child,
  CustomRoute? initialRoute,
  GoRouter? router,
}) {
  if (initialRoute == null && router == null) {
    assert(
      child != null,
      'Child must exist if router and initialRouter are null',
    );
  }

  GoRouter? routerConfig;
  if (router != null) {
    routerConfig = router;
  } else if (initialRoute != null) {
    routerConfig = app_router.router(initialRoute: initialRoute);
  } else {
    routerConfig = GoRouter(
      routes: [
        CustomRoute(
          name: 'home',
          path: ([_]) => '/',
        ).generateRoute(child: child),
      ],
    );
  }

  return MaterialApp.router(
    theme: AppTheme.data,
    debugShowCheckedModeBanner: false,
    routerConfig: routerConfig,
  );
}
