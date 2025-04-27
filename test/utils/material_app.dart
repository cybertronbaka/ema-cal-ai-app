import 'package:ema_cal_ai/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget createTestMaterialApp({Widget? child, GoRouter? router}) {
  if (router == null) {
    assert(child != null, 'Child must exist if router is null');
  }

  return MaterialApp.router(
    theme: AppTheme.data,
    debugShowCheckedModeBanner: false,
    routerConfig:
        router ??
        GoRouter(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, route) => child!,
            ),
          ],
        ),
  );
}
