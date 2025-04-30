import 'package:adaptive_test/adaptive_test.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/chart_data.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:ema_cal_ai/utils/root_provider_scope.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/material_app.dart';

final fixedTime = DateTime(2025, 12, 30);

class _TestCase {
  _TestCase({required this.title, required this.filter, required this.values});

  String title;
  HistoryFilter filter;
  List<(double, DateTime)> values;
}

void main() {
  setUpAll(() async {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory().interceptWith(LogInterceptor(logLevels: [])),
        closeStreamsSynchronously: true,
      ),
    );
  });

  final testCases = [
    _TestCase(title: 'with 0 data', filter: HistoryFilter.allTime, values: []),
    _TestCase(
      title: 'with 7 data',
      filter: HistoryFilter.allTime,
      values: [
        (83.0, DateTime(2023, 04, 30)), // 1
        (83.0, DateTime(2024, 04, 30)), // 2
        (80.0, DateTime(2025, 01, 2)), // 3
        (78, DateTime(2025, 02, 2)), // 4
        (76, DateTime(2025, 03, 2)), // 5
        (76, DateTime(2025, 04, 2)), // 6
        (76, DateTime(2025, 08, 2)), // 7
      ],
    ),
    _TestCase(
      title: 'with 7+ data and this month filter',
      filter: HistoryFilter.thisMonth,
      values: [
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 12, 01)), // 1
        (83.0, DateTime(2025, 12, 05)), // 2
        (83.0, DateTime(2025, 12, 09)), // 3
        (76.0, DateTime(2025, 12, 10)), // 4
        (76.0, DateTime(2025, 12, 15)), // 5
        (77.0, DateTime(2025, 12, 19)), // 6
        (77.0, DateTime(2025, 12, 20)), // 7
        (75.0, DateTime(2025, 12, 25)), // 8
        (75.0, DateTime(2025, 12, 29)), // 9
        (73.0, DateTime(2025, 12, 30)), // 10
      ],
    ),
    _TestCase(
      title: 'with 7+ data and 3 months filter',
      filter: HistoryFilter.last3Months,
      values: [
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 08, 02)), // 0
        (83.0, DateTime(2025, 10, 01)), // 1
        (83.0, DateTime(2025, 10, 03)), // 2
        (76.0, DateTime(2025, 10, 05)), // 3
        (76.0, DateTime(2025, 11, 05)), // 4
        (77.0, DateTime(2025, 11, 05)), // 5
        (77.0, DateTime(2025, 12, 05)), // 6
        (75.0, DateTime(2025, 12, 08)), // 7
        (75.0, DateTime(2025, 12, 09)), // 8
        (73.0, DateTime(2025, 12, 30)), // 9
      ],
    ),
    _TestCase(
      title: 'with 7+ data and 6 months filter',
      filter: HistoryFilter.last6Months,
      values: [
        (83.0, DateTime(2025, 05, 02)), // 0
        (83.0, DateTime(2025, 05, 03)), // 0
        (83.0, DateTime(2025, 06, 03)), // 0
        (84.0, DateTime(2025, 07, 01)), // 1
        (83.0, DateTime(2025, 08, 01)), // 2
        (83.0, DateTime(2025, 09, 01)), // 3
        (76.0, DateTime(2025, 10, 05)), // 4
        (76.0, DateTime(2025, 11, 05)), // 5
        (77.0, DateTime(2025, 11, 05)), // 6
        (77.0, DateTime(2025, 12, 05)), // 7
        (75.0, DateTime(2025, 12, 08)), // 8
        (75.0, DateTime(2025, 12, 09)), // 9
        (73.0, DateTime(2025, 12, 30)), // 10
      ],
    ),

    _TestCase(
      title: 'with 7+ data and 1 year filter',
      filter: HistoryFilter.last1Year,
      values: [
        (83.0, DateTime(2024, 04, 02)), // 0
        (83.0, DateTime(2024, 11, 03)), // 0
        (83.0, DateTime(2024, 12, 03)), // 0
        (84.0, DateTime(2024, 12, 30)), // 1
        (84.0, DateTime(2024, 12, 31)), // 1
        (83.0, DateTime(2025, 01, 01)), // 2
        (83.0, DateTime(2025, 02, 01)), // 3
        (76.0, DateTime(2025, 03, 01)), // 4
        (76.0, DateTime(2025, 04, 05)), // 5
        (77.0, DateTime(2025, 05, 05)), // 6
        (77.0, DateTime(2025, 06, 05)), // 7
        (75.0, DateTime(2025, 07, 08)), // 8
        (75.0, DateTime(2025, 08, 09)), // 9
        (73.0, DateTime(2025, 09, 30)), // 10
        (73.0, DateTime(2025, 10, 30)), // 10
        (73.0, DateTime(2025, 11, 30)), // 10
        (73.0, DateTime(2025, 12, 30)), // 10
      ],
    ),

    _TestCase(
      title: 'with 7+ data and all times filter',
      filter: HistoryFilter.allTime,
      values: [
        (83.0, DateTime(2024, 04, 02)), // 0
        (83.0, DateTime(2024, 11, 03)), // 0
        (83.0, DateTime(2024, 12, 03)), // 0
        (84.0, DateTime(2024, 12, 30)), // 1
        (84.0, DateTime(2024, 12, 31)), // 1
        (83.0, DateTime(2025, 01, 01)), // 2
        (83.0, DateTime(2025, 02, 01)), // 3
        (76.0, DateTime(2025, 03, 01)), // 4
        (76.0, DateTime(2025, 04, 05)), // 5
        (77.0, DateTime(2025, 05, 05)), // 6
        (77.0, DateTime(2025, 06, 05)), // 7
        (75.0, DateTime(2025, 07, 08)), // 8
        (75.0, DateTime(2025, 08, 09)), // 9
        (73.0, DateTime(2025, 09, 30)), // 10
        (73.0, DateTime(2025, 10, 30)), // 10
        (73.0, DateTime(2025, 11, 30)), // 10
        (73.0, DateTime(2025, 12, 30)), // 10
      ],
    ),
  ];

  for (var testCase in testCases) {
    group(testCase.title, () {
      if (testCase.values.isNotEmpty) {
        setUpAll(() async {
          await database.managers.dbHistories.bulkCreate((f) {
            return testCase.values.map((e) {
              return f(
                type: HistoryType.weight,
                createdAt: e.$2,
                updatedAt: e.$2,
                value: e.$1,
              );
            });
          });
        });

        tearDownAll(() async {
          await database.managers.dbHistories.delete();
        });
      }
      testAdaptiveWidgets('Date Chart Test(${testCase.title})', (
        tester,
        variant,
      ) async {
        await _testWidget(tester, variant, testCase.filter, testCase.title);
      });
    });
  }

  tearDownAll(() async {
    await database.close();
  });
}

Future<void> _testWidget(
  WidgetTester tester,
  WindowConfigData variant,
  HistoryFilter filter,
  String suffix,
) async {
  await withClock(Clock.fixed(fixedTime), () async {
    await tester.pumpWidget(
      AdaptiveWrapper(
        windowConfig: variant,
        tester: tester,
        child: createRootProviderScope(
          historyRepo: LocalHistoryRepo(),
          child: createTestMaterialApp(
            child: _WeightHistoryDateChart(filter: filter),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.expectGolden<_WeightHistoryDateChart>(variant, suffix: suffix);
  });
}

class _WeightHistoryDateChart extends HookConsumerWidget {
  const _WeightHistoryDateChart({required this.filter});

  final HistoryFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = useState<List<ChartData>>([]);

    useInitHook(() async {
      final data = await ref
          .read(historyRepoProvider)
          .getChartData(type: HistoryType.weight, filter: filter);
      values.value = data;
    }, []);

    return Scaffold(
      body: Center(
        child: SizedBox(height: 200, child: DateChart(items: values.value)),
      ),
    );
  }
}
