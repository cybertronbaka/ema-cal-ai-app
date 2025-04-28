import 'dart:async';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_diet/edit_diet_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_dob/edit_dob_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_gender/edit_gender_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_height_weight/edit_height_weight_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_weight_goal/edit_weight_goal_page.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_workout_frequency/edit_workout_frequency_page.dart';
import 'package:ema_cal_ai/pages/edit_personal_details/edit_personal_details_page.dart';
import 'package:ema_cal_ai/pages/settings/settings_page.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../mocks/repositories.dart';
import '../../utils/material_app.dart';
import '../../utils/mocktail.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;
  late MockProfileRepo profileRepo;
  late MockStreaksRepo streaksRepo;
  late MockMealDataRepo mealDataRepo;
  late MockNutritionPlanRepo nutritionPlanRepo;
  late MockMealTimeRemindersRepo mealTimeRemindersRepo;
  late PackageInfo packageInfo;
  final time = DateTime(2025, 04, 02, 10, 10);

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    profileRepo = MockProfileRepo();
    streaksRepo = MockStreaksRepo();
    mealDataRepo = MockMealDataRepo();
    nutritionPlanRepo = MockNutritionPlanRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    packageInfo = genFakePackageInfo();

    registerFallbackValue(genFakeUserProfile());

    when(
      () => profileRepo.get(),
    ).thenAnswerWithValue(genFakeUserProfile(isOnboardingComplete: true));

    when(
      () => profileRepo.save(any()),
    ).thenAnswerWithValue(genFakeUserProfile(isOnboardingComplete: true));

    when(
      () => nutritionPlanRepo.get(),
    ).thenAnswerWithValue(genFakeNutritionPlan());

    when(
      () => mealTimeRemindersRepo.get(),
    ).thenAnswerWithValue(genFakeMealTimeReminders());

    when(() => streaksRepo.get()).thenAnswerWithValue(0);
    when(() => streaksRepo.validateAndReset()).thenAnswerWithVoid();
    when(() => mealDataRepo.today()).thenAnswerWithValue([]);
    when(() => mealDataRepo.thisWeek()).thenAnswerWithValue([]);
    when(() => mealDataRepo.lastNData(any())).thenAnswerWithValue([]);
  });

  testAdaptiveWidgets('Edit Personal Details Page Golden', (
    tester,
    variant,
  ) async {
    await withClock(Clock.fixed(time), () async {
      await tester.pumpWidget(
        AdaptiveWrapper(
          windowConfig: variant,
          tester: tester,
          child: createRootProviderScope(
            keyboardVisibilityController: keyboardVisibilityController,
            mealDataRepo: mealDataRepo,
            streaksRepo: streaksRepo,
            profileRepo: profileRepo,
            nutritionPlanRepo: nutritionPlanRepo,
            mealTimeRemindersRepo: mealTimeRemindersRepo,
            packageInfo: packageInfo,
            extraOverrides: [
              userProfileProvider.overrideWith((_) => genFakeUserProfile()),
            ],
            child: createTestMaterialApp(initialRoute: Routes.settings),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final element = tester.element(find.byType(SettingsPage));
      final container = ProviderScope.containerOf(element);
      await tester.runAsync(() async {
        await AppInitializer(container).init();
      });
      await tester.pumpAndSettle();

      unawaited(element.pushNamed(Routes.editPersonalDetails.name));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditPersonalDetailsPage>(variant);

      await tester.tap(find.text('Change Goal'));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditWeightGoalPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      // await tester.expectGolden<MaterialApp>(variant);

      await tester.tap(find.byKey(const Key('edit-current-weight-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditHeightWeightPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-height-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditHeightWeightPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-dob-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditDobPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-gender-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditGenderPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-diet-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditDietPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-workout-rate-btn')));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditWorkoutFrequencyPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
    });
  });
}
