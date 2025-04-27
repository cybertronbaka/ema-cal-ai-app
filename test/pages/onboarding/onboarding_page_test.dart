import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/controllers/onboarding_controller.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/pages/onboarding/onboarding_page.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recase/recase.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../mocks/repositories.dart';
import '../../mocks/video_player_platform.dart';
import '../../utils/fa_icon.dart';
import '../../utils/material_app.dart';
import '../../utils/tester.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;
  late MockMealTimeRemindersRepo mealTimeRemindersRepo;
  late MockProfileRepo profileRepo;
  late MockGptApiKeyVerifyRepo gptApiKeyVerifyRepo;
  late MockGptNutritionPlannerRepo gptNutritionPlannerRepo;
  late MockOnboardingSaveRepo onboardingSaveRepo;
  bool verifiedApiKey = false;

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    MockVideoPlayerPlatform().setup();
    gptApiKeyVerifyRepo = MockGptApiKeyVerifyRepo();
    gptNutritionPlannerRepo = MockGptNutritionPlannerRepo();
    profileRepo = MockProfileRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    onboardingSaveRepo = MockOnboardingSaveRepo();

    registerFallbackValue(genFakeUserProfile());
    registerFallbackValue(genFakeMealTimeReminders());
    registerFallbackValue(genFakeOnboardingData());

    when(
      () => gptApiKeyVerifyRepo.verify(any()),
    ).thenAnswer((_) => Future.value(verifiedApiKey));

    when(
      () => profileRepo.save(any()),
    ).thenAnswer((_) => Future.value(genFakeUserProfile()));
    when(
      () => profileRepo.get(),
    ).thenAnswer((_) => Future.value(genFakeUserProfile()));

    when(
      () => mealTimeRemindersRepo.get(),
    ).thenAnswer((_) => Future.value(genFakeMealTimeReminders()));

    when(
      () => mealTimeRemindersRepo.saveAll(any()),
    ).thenAnswer((_) => Future.value(genFakeMealTimeReminders()));

    when<Future<NutritionPlan>>(
      () => gptNutritionPlannerRepo.plan(
        any<UserProfile>(that: isA<UserProfile>()),
        any<String>(that: isA<String>()),
      ),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));

      return genFakeNutritionPlan();
    });

    when(
      () => onboardingSaveRepo.save(any()),
    ).thenAnswer((_) => Future.value(genFakeOnboardingData()));
    when(() => onboardingSaveRepo.clear()).thenAnswer((_) async {});
  });

  testAdaptiveWidgets('Onboarding Page Goldens', (tester, variant) async {
    await withClock(Clock.fixed(DateTime(2025, 4, 1)), () async {
      await tester.pumpWidget(
        AdaptiveWrapper(
          windowConfig: variant,
          tester: tester,
          child: createRootProviderScope(
            keyboardVisibilityController: keyboardVisibilityController,
            gptApiKeyVerifyRepo: gptApiKeyVerifyRepo,
            profileRepo: profileRepo,
            mealTimeRemindersRepo: mealTimeRemindersRepo,
            gptNutritionPlannerRepo: gptNutritionPlannerRepo,
            onboardingSaveRepo: (ref) => onboardingSaveRepo,
            child: createTestMaterialApp(const OnboardingPage()),
          ),
        ),
      );

      final element = tester.element(find.byType(OnboardingPage));
      final container = ProviderScope.containerOf(element);

      // Step 1
      await tester.pumpAndSettle();
      final prefix = 'preview/${variant.name.snakeCase}/onboarding_page';

      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_1.png',
      );
      await tester.tap(find.text('Male'));
      await tester.tap(find.text('Next'));

      // step 2
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_2.png',
      );
      await tester.tap(find.text('None'));
      await tester.tap(find.text('Next'));

      // step 3
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_3.png',
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_3_imperial.png',
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));

      // step 4
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_4.png',
      );
      await tester.tap(find.text('Next'));

      // step 5
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_5.png',
      );

      container.read(onboardingControllerProvider).isMetric = false;
      await tester.tap(find.byType(CustomBackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_5_imperial.png',
      );
      container.read(onboardingControllerProvider).isMetric = true;
      await tester.tap(find.text('Next'));

      // step 6
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_6.png',
      );

      await tester.tap(find.text('Standard'));
      await tester.tap(find.text('Next'));

      // Step 7
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_7.png',
      );

      await tester.tap(find.byFaIcon(FontAwesomeIcons.plus).first);
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_7_time_picker.png',
      );

      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_7_picked_time.png',
      );

      await tester.tap(find.byFaIcon(FontAwesomeIcons.pencil).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      await tester.tap(find.byFaIcon(FontAwesomeIcons.trash).first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));

      // step 8
      await tester.pumpAndSettle();
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_8.png',
      );

      await tester.enterText(find.byType(SensitiveField), 'test_api_key');
      await tester.pumpAndSettle();

      verifiedApiKey = false;
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_8_api_key_error.png',
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      verifiedApiKey = true;
      await tester.tap(find.text('Next'));
      await tester.pumpNTimes(4);
      await tester.expectGolden<OnboardingPage>(
        variant,
        path: '${prefix}_step_9.png',
      );
    });
  });
}
