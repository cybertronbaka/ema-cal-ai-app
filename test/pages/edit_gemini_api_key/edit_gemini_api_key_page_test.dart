import 'dart:async';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/edit_pages/edit_gemini_api_key/edit_gemini_api_key_page.dart';
import 'package:ema_cal_ai/pages/settings/settings_page.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../mocks/repositories.dart';
import '../../mocks/video_player_platform.dart';
import '../../utils/material_app.dart';
import '../../utils/mocktail.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;
  late MockProfileRepo profileRepo;
  late MockStreaksRepo streaksRepo;
  late MockMealDataRepo mealDataRepo;
  late MockNutritionPlanRepo nutritionPlanRepo;
  late MockMealTimeRemindersRepo mealTimeRemindersRepo;
  late MockGptApiKeyVerifyRepo gptApiKeyVerifyRepo;
  late PackageInfo packageInfo;

  final time = DateTime(2025, 04, 02, 10, 10);
  final profile = genFakeUserProfile(
    isOnboardingComplete: true,
    gptKey: 'jakfjsioajoidjaoijoij',
  );

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    profileRepo = MockProfileRepo();
    streaksRepo = MockStreaksRepo();
    mealDataRepo = MockMealDataRepo();
    nutritionPlanRepo = MockNutritionPlanRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    gptApiKeyVerifyRepo = MockGptApiKeyVerifyRepo();
    packageInfo = genFakePackageInfo();
    MockVideoPlayerPlatform().setup();

    registerFallbackValue(profile);

    when(() => profileRepo.get()).thenAnswerWithValue(profile);

    when(() => profileRepo.save(any())).thenAnswerWithValue(profile);

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

    when(
      () => gptApiKeyVerifyRepo.verify(any()),
    ).thenAnswerWithValue((true, null));
  });

  testAdaptiveWidgets('Edit Gemini API Key Page Golden', (
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
            gptApiKeyVerifyRepo: gptApiKeyVerifyRepo,
            extraOverrides: [userProfileProvider.overrideWith((_) => profile)],
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

      unawaited(element.pushNamed(Routes.editGeminiAPIKey.name));
      await tester.pumpAndSettle();
      await tester.expectGolden<EditGeminiApiKeyPage>(variant);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
    });
  });
}
