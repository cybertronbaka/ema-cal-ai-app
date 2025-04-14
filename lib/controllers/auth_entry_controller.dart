import 'package:ema_cal_ai/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authEntryControllerProvider = Provider.autoDispose(
  (ref) => AuthEntryController(ref),
);

class AuthEntryController {
  AuthEntryController(this.ref);

  Ref ref;

  void toOnboardingPage(BuildContext context) {
    context.pushReplacementNamed(Routes.onboarding.name);
  }
}
