import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/pages/dashboard/dashboard_page.dart';
import 'package:ema_cal_ai/pages/overview/overview_page.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final time = DateTime(2025, 04, 02);

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    profileRepo = MockProfileRepo();
    streaksRepo = MockStreaksRepo();
    mealDataRepo = MockMealDataRepo();
    nutritionPlanRepo = MockNutritionPlanRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    packageInfo = genFakePackageInfo();

    when(
      () => profileRepo.get(),
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

  testAdaptiveWidgets('Overview Page Golden', (tester, variant) async {
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
            child: ProviderScope(
              overrides: [
                userProfileProvider.overrideWith((_) => genFakeUserProfile()),
              ],
              child: createTestMaterialApp(initialRoute: Routes.overview),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final element = tester.element(find.byType(DashboardScaffold));
      final container = ProviderScope.containerOf(element);
      await tester.runAsync(() async {
        await AppInitializer(container).init();
      });
      await tester.pump();
      await tester.expectGolden<OverviewPage>(variant);
    });
  });
}
