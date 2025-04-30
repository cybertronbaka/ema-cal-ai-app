import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:ema_cal_ai/pages/dashboard/dashboard_page.dart';
import 'package:ema_cal_ai/pages/home/home_page.dart';
import 'package:ema_cal_ai/utils/app_initializer.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../fake_data/fakes.dart';
import '../../mocks/keyboard_visibility_controller.dart';
import '../../mocks/repositories.dart';
import '../../utils/fa_icon.dart';
import '../../utils/material_app.dart';
import '../../utils/mocktail.dart';
import '../../utils/permission.dart';

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
    packageInfo = PackageInfo(
      appName: 'Ema Cal AI',
      packageName: 'com.emacalai',
      version: '1.0.0',
      buildNumber: '',
    );

    final profile = genFakeUserProfile(isOnboardingComplete: true);

    when(() => profileRepo.get()).thenAnswerWithValue(profile);
    when(
      () => nutritionPlanRepo.get(),
    ).thenAnswerWithValue(genFakeNutritionPlan());
    when(
      () => mealTimeRemindersRepo.get(),
    ).thenAnswerWithValue(genFakeMealTimeReminders());
    when(
      () => historyRepo.getLatestWeight(),
    ).thenAnswerWithValue(genFakeHistory(value: profile.weight.kg));
  });

  group('Without MealData', () {
    setUp(() {
      when(() => streaksRepo.get()).thenAnswerWithValue(0);
      when(() => streaksRepo.validateAndReset()).thenAnswerWithVoid();
      when(() => mealDataRepo.today()).thenAnswerWithValue([]);
      when(() => mealDataRepo.thisWeek()).thenAnswerWithValue([]);
      when(() => mealDataRepo.lastNData(any())).thenAnswerWithValue([]);
      setupPermissions({
        Permission.camera.value: PermissionStatus.permanentlyDenied.index,
        Permission.storage.value: PermissionStatus.permanentlyDenied.index,
        Permission.photos.value: PermissionStatus.permanentlyDenied.index,
      });
    });

    testAdaptiveWidgets('Home Page Golden', (tester, variant) async {
      await _testHome(
        tester: tester,
        variant: variant,
        time: time,
        keyboardVisibilityController: keyboardVisibilityController,
        mealDataRepo: mealDataRepo,
        streaksRepo: streaksRepo,
        profileRepo: profileRepo,
        nutritionPlanRepo: nutritionPlanRepo,
        mealTimeRemindersRepo: mealTimeRemindersRepo,
        historyRepo: historyRepo,
        packageInfo: packageInfo,
      );
      await tester.tap(find.byFaIcon(FontAwesomeIcons.plus));
      await tester.pumpAndSettle();
      await tester.expectGolden<HomePage>(
        variant,
        suffix: 'add meal data popup',
      );

      await tester.tap(find.text('Take photo'));
      await tester.pumpAndSettle();
      await tester.expectGolden<HomePage>(
        variant,
        suffix: 'camera permissions denied',
      );

      await tester.tap(find.byFaIcon(FontAwesomeIcons.xmark));
      await tester.pumpAndSettle();

      await tester.tap(find.byFaIcon(FontAwesomeIcons.plus));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Select from Gallery'));
      await tester.pumpAndSettle();
      await tester.expectGolden<HomePage>(
        variant,
        suffix: 'gallery permissions denied',
      );
    });
  });

  group('Without 2 MealData', () {
    setUp(() {
      final todayData = [genFakeMealData(createdAt: time)];
      final thisWeekData = [
        ...todayData,
        genFakeMealData(
          mealName: 'Test Meal Data 2',
          createdAt: time.subtract(const Duration(days: 1)),
        ),
      ];
      when(() => streaksRepo.get()).thenAnswerWithValue(2);
      when(() => streaksRepo.validateAndReset()).thenAnswerWithVoid();
      when(() => mealDataRepo.today()).thenAnswerWithValue(todayData);
      when(() => mealDataRepo.thisWeek()).thenAnswerWithValue(thisWeekData);
      when(
        () => mealDataRepo.lastNData(any()),
      ).thenAnswerWithValue(thisWeekData);
    });

    testAdaptiveWidgets('Home Page Golden', (tester, variant) async {
      const suffix = 'with 2 meal data';
      await _testHome(
        tester: tester,
        variant: variant,
        time: time,
        keyboardVisibilityController: keyboardVisibilityController,
        mealDataRepo: mealDataRepo,
        streaksRepo: streaksRepo,
        profileRepo: profileRepo,
        nutritionPlanRepo: nutritionPlanRepo,
        mealTimeRemindersRepo: mealTimeRemindersRepo,
        packageInfo: packageInfo,
        historyRepo: historyRepo,
        suffix: suffix,
      );

      final listFinder =
          find
              .byType(Scrollable)
              .last; // take last because the tab bar up top is also a Scrollable
      expect(listFinder, findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Test Meal Data 2').first,
        50,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle();
      await tester.expectGolden<HomePage>(variant, suffix: '$suffix scrolled');
    });
  });
}

Future<void> _testHome({
  required WidgetTester tester,
  required WindowConfigData variant,
  required DateTime time,
  required KeyboardVisibilityController keyboardVisibilityController,
  required MockMealDataRepo mealDataRepo,
  required MockStreaksRepo streaksRepo,
  required MockProfileRepo profileRepo,
  required MockNutritionPlanRepo nutritionPlanRepo,
  required MockMealTimeRemindersRepo mealTimeRemindersRepo,
  required MockHistoryRepo historyRepo,
  required PackageInfo packageInfo,
  String? suffix,
}) async {
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
          child: createTestMaterialApp(
            child: DashboardScaffold(
              currentIndex: 1,
              setCurrentIndex: (_) {},
              children: [Container(), const HomePage(), Container()],
            ),
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
    await tester.expectGolden<HomePage>(variant, suffix: suffix);
  });
}
