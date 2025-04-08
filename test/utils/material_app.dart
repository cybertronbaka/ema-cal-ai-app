import 'package:ema_cal_ai/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget createTestMaterialApp(Widget child) {
  return MaterialApp.router(
    theme: AppTheme.data,
    debugShowCheckedModeBanner: false,
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', name: 'home', builder: (context, route) => child),
      ],
    ),
  );
}
