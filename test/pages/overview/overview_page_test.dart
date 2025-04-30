import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/pages/dashboard/dashboard_page.dart';
import 'package:ema_cal_ai/pages/overview/overview_page.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
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
  late MockHistoryRepo historyRepo;
  late PackageInfo packageInfo;
  final time = DateTime(2025, 04, 02);

  setUpAll(() {
    keyboardVisibilityController = MockKeyboardVisibilityController();
    profileRepo = MockProfileRepo();
    streaksRepo = MockStreaksRepo();
    mealDataRepo = MockMealDataRepo();
    nutritionPlanRepo = MockNutritionPlanRepo();
    mealTimeRemindersRepo = MockMealTimeRemindersRepo();
    historyRepo = MockHistoryRepo();
    packageInfo = genFakePackageInfo();

    registerFallbackValue(HistoryFilter.allTime);
    registerFallbackValue(HistoryType.weight);
    registerFallbackValue(AggregateType.avg);

    final profile = genFakeUserProfile(isOnboardingComplete: true);
    when(() => profileRepo.get()).thenAnswerWithValue(profile);
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
      () => historyRepo.getChartData(
        type: any(named: 'type'),
        filter: any(named: 'filter'),
        aggregateType: any(named: 'aggregateType'),
      ),
    ).thenAnswer((inv) async {
      final filter = inv.namedArguments[#filter] as HistoryFilter;
      return genChartData(10, filter);
    });

    when(
      () => historyRepo.getLatestWeight(),
    ).thenAnswerWithValue(genFakeHistory(value: profile.weight.kg));
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
            historyRepo: historyRepo,
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

      final listFinder =
          find
              .byType(Scrollable)
              .last; // take last because the tab bar up top is also a Scrollable
      expect(listFinder, findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Weight over time').first,
        300,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle();
      await tester.expectGolden<OverviewPage>(
        variant,
        suffix: 'weight over time',
      );

      await tester.scrollUntilVisible(
        find.text('Calories intake over time').first,
        300,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle();
      await tester.expectGolden<OverviewPage>(
        variant,
        suffix: 'calories intake over time',
      );
    });
  });
}
