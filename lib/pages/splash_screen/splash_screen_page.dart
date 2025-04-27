library;

import 'dart:ui';

import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreenPage extends HookConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useInitHook(() {
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (context.mounted) {
          animationController.forward();
        }
      });
    }, []);

    useInitHook(() {
      AppInitializer(ProviderScope.containerOf(context)).init(
        afterInitializingUserData: () {
          if (context.mounted) {
            context.replaceNamed(Routes.home.name);
          }
        },
        onNoUser: () {
          if (context.mounted) {
            context.replaceNamed(Routes.onboardingEntry.name);
          }
        },
      );
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final scale = lerpDouble(1.0, 1.5, animationController.value);

              return Transform.scale(scale: scale, child: child);
            },
            child: const Text(
              'Ema Cal AI',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
