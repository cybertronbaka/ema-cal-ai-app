import 'dart:io';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:camera/camera.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/pages/add_meal_data/add_meal_data_page.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../mocks/repositories.dart';
import '../../utils/fa_icon.dart';
import '../../utils/material_app.dart';
import '../../utils/mocktail.dart';
import '../../utils/tester.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;
  late MockMealDataRepo mealDataRepo;
  late MockHistoryRepo historyRepo;
  bool saveThrowsError = false;

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    registerFallbackValue(genFakeMealData());
    mealDataRepo = MockMealDataRepo();
    historyRepo = MockHistoryRepo();

    when(() => mealDataRepo.add(any<MealData>())).thenAnswer((_) async {
      if (saveThrowsError) {
        throw 'This is a test error';
      }
      return genFakeMealData();
    });

    when(
      () => historyRepo.addCalorie(any()),
    ).thenAnswerWithValue(genFakeHistory(type: HistoryType.calories));
  });

  testAdaptiveWidgets('Add Meal Data Page Goldens', (tester, variant) async {
    await tester.pumpWidget(
      AdaptiveWrapper(
        windowConfig: variant,
        tester: tester,
        child: createRootProviderScope(
          keyboardVisibilityController: keyboardVisibilityController,
          mealDataRepo: mealDataRepo,
          historyRepo: historyRepo,
          extraOverrides: [
            addMealDataPageDataProvider.overrideWithValue(
              AddMealDataPageData(
                image: XFile.fromData(
                  File('test/fixtures/food_image.jpg').readAsBytesSync(),
                ),
                data: genFakeMealData(),
              ),
            ),
          ],
          child: createTestMaterialApp(
            router: GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  name: 'bg',
                  builder:
                      (context, _) => Scaffold(
                        body: Center(
                          child: FilledButton(
                            onPressed: () {
                              context.pushNamed(Routes.addMealData.name);
                            },
                            child: const Text('Go to Add Meal Data Page'),
                          ),
                        ),
                      ),
                ),
                Routes.addMealData.generateRoute(
                  child: const AddMealDataPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    await tester.expectGolden<AddMealDataPage>(variant);

    await tester.tap(find.byFaIcon(FontAwesomeIcons.plus));
    await tester.pumpAndSettle();
    await tester.expectGolden<AddMealDataPage>(variant, suffix: '2 portions');
    await tester.tap(find.byFaIcon(FontAwesomeIcons.minus));
    await tester.pumpAndSettle();
    await tester.expectGolden<AddMealDataPage>(variant);

    await tester.tap(find.byKey(const Key('edit-title-btn')));
    await tester.pumpAndSettle();
    await tester.expectGolden<AddMealDataPage>(
      variant,
      suffix: 'edit meal name',
    );
    await tester.tap(find.byFaIcon(FontAwesomeIcons.xmark));
    await tester.pumpAndSettle();

    for (var nutrient in MacroNutrients.values) {
      if (nutrient == MacroNutrients.water) {
        final listFinder =
            find
                .byType(Scrollable)
                .first; // take last because the tab bar up top is also a Scrollable
        expect(listFinder, findsOneWidget);
        await tester.scrollUntilVisible(
          find.byType(WaterIntakeCard),
          100,
          scrollable: listFinder,
        );
        await tester.pumpAndSettle();
      }

      await tester.tap(find.byKey(Key('edit-${nutrient.name}-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<AddMealDataPage>(
        variant,
        suffix: 'edit ${nutrient.name}',
      );
      await tester.tap(find.byFaIcon(FontAwesomeIcons.xmark));
      await tester.pumpAndSettle();
    }

    saveThrowsError = true;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.expectGolden<AddMealDataPage>(
      variant,
      suffix: 'error with saving',
    );
    await tester.pumpNTimes(5);

    saveThrowsError = false;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.expectGolden<AddMealDataPage>(variant, suffix: 'Popped');
    verify(() => historyRepo.addCalorie(100.0)).called(1);
  });
}
