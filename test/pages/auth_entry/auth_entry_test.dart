import 'package:adaptive_test/adaptive_test.dart';
import 'package:ema_cal_ai/pages/auth_entry/auth_entry_page.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/keyboard_visibility_controller.dart';
import '../../utils/material_app.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
  });

  testAdaptiveWidgets('Auth Entry Page Goldens', (tester, variant) async {
    await tester.pumpWidget(
      AdaptiveWrapper(
        windowConfig: variant,
        tester: tester,
        child: createRootProviderScope(
          keyboardVisibilityController: keyboardVisibilityController,
          child: createTestMaterialApp(const AuthEntryPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.expectGolden<AuthEntryPage>(variant);
  });
}
