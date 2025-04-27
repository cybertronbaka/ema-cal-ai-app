import 'package:adaptive_test/adaptive_test.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/pages/onboarding_complete_overview/onboarding_complete_overview_page.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../utils/material_app.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
  });

  testAdaptiveWidgets('Onboarding Complete Overview Page Goldens', (
    tester,
    variant,
  ) async {
    await tester.pumpWidget(
      AdaptiveWrapper(
        windowConfig: variant,
        tester: tester,
        child: ProviderScope(
          overrides: [
            currentNutritionPlanProvider.overrideWith(
              (_) => genFakeNutritionPlan(),
            ),
            userProfileProvider.overrideWith((_) => genFakeUserProfile()),
          ],
          child: createRootProviderScope(
            keyboardVisibilityController: keyboardVisibilityController,
            child: createTestMaterialApp(
              child: const OnboardingCompleteOverviewPage(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.expectGolden<OnboardingPage>(variant);

    final listFinder =
        find
            .byType(Scrollable)
            .last; // take last because the tab bar up top is also a Scrollable
    expect(listFinder, findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('This is test Warnings').first,
      16,
      scrollable: listFinder,
    );
    await tester.pumpAndSettle();
    await tester.expectGolden<OnboardingPage>(variant, suffix: 'scrolled');
  });
}
