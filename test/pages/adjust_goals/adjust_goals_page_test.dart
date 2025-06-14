import 'dart:async';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/adjust_goals/adjust_goals_page.dart';
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
import '../../utils/material_app.dart';
import '../../utils/mocktail.dart';

void main() {
  late MockKeyboardVisibilityController keyboardVisibilityController;
  late MockProfileRepo profileRepo;
  late MockStreaksRepo streaksRepo;
  late MockMealDataRepo mealDataRepo;
  late MockNutritionPlanRepo nutritionPlanRepo;
  late MockMealTimeRemindersRepo mealTimeRemindersRepo;
  late MockGptNutritionPlannerRepo gptNutritionPlannerRepo;
  late MockHistoryRepo historyRepo;

  late PackageInfo packageInfo;
  final time = DateTime(2025, 04, 02, 10, 10);
  final reminders = genFakeMealTimeReminders();
  final nutritionPlan = genFakeNutritionPlan();
  final newNutritionPlan = genFakeNutritionPlan(
    calories: 1500,
    proteinG: 40.0,
    carbsG: 25.0,
    fatsG: 15.0,
    waterLiters: 3.0,
  );
  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    profileRepo = MockProfileRepo();
    streaksRepo = MockStreaksRepo();
    mealDataRepo = MockMealDataRepo();
    nutritionPlanRepo = MockNutritionPlanRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    gptNutritionPlannerRepo = MockGptNutritionPlannerRepo();
    historyRepo = MockHistoryRepo();
    packageInfo = genFakePackageInfo();

    final profile = genFakeUserProfile(isOnboardingComplete: true);

    registerFallbackValue(profile);
    registerFallbackValue(reminders);
    registerFallbackValue(genFakeNutritionPlan());

    when(() => profileRepo.get()).thenAnswerWithValue(profile);

    when(() => nutritionPlanRepo.get()).thenAnswerWithValue(nutritionPlan);
    when(
      () => nutritionPlanRepo.save(any()),
    ).thenAnswerWithValue(newNutritionPlan);

    when(
      () => gptNutritionPlannerRepo.plan(any(), any()),
    ).thenAnswerWithValue(newNutritionPlan);

    when(() => mealTimeRemindersRepo.get()).thenAnswerWithValue(reminders);
    when(() => mealTimeRemindersRepo.clear()).thenAnswerWithVoid();
    when(
      () => mealTimeRemindersRepo.saveAll(any()),
    ).thenAnswerWithValue(reminders);

    when(() => streaksRepo.get()).thenAnswerWithValue(0);
    when(() => streaksRepo.validateAndReset()).thenAnswerWithVoid();
    when(() => mealDataRepo.today()).thenAnswerWithValue([]);
    when(() => mealDataRepo.thisWeek()).thenAnswerWithValue([]);
    when(() => mealDataRepo.lastNData(any())).thenAnswerWithValue([]);
    when(
      () => historyRepo.getLatestWeight(),
    ).thenAnswerWithValue(genFakeHistory(value: profile.weight.kg));
  });

  testAdaptiveWidgets('Adjust Goals Page Golden', (tester, variant) async {
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
            gptNutritionPlannerRepo: gptNutritionPlannerRepo,
            historyRepo: historyRepo,
            packageInfo: packageInfo,
            extraOverrides: [
              userProfileProvider.overrideWith((_) => genFakeUserProfile()),
              mealTimeRemindersProvider.overrideWith((_) => reminders),
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

      unawaited(element.pushNamed(Routes.adjustGoals.name));
      await tester.pumpAndSettle();
      await tester.expectGolden<AdjustGoalsPage>(variant, suffix: 'before');

      await tester.tap(find.text('Auto Generate Goals'));
      await tester.pumpAndSettle();
      await tester.expectGolden<AdjustGoalsPage>(variant, suffix: 'after');
    });
  });
}
