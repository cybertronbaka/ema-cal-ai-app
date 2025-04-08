import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/shared_pref_proxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

ProviderScope createRootProviderScope({
  SharedPrefProxy? sharedPrefProxy,
  KeyboardVisibilityController? keyboardVisibilityController,
  required Widget child,
}) {
  return ProviderScope(
    overrides: [
      if (sharedPrefProxy != null)
        sharedPrefProvider.overrideWithValue(sharedPrefProxy),
      if (keyboardVisibilityController != null)
        keyboardVisibilityControllerProvider.overrideWithValue(
          keyboardVisibilityController,
        ),
    ],
    child: child,
  );
}
