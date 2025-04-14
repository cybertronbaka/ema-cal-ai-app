import 'package:flutter_test/flutter_test.dart';

extension TesterExt on WidgetTester {
  Future<void> pumpNTimes(
    int n, [
    Duration duration = const Duration(seconds: 1),
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) async {
    for (int i = 0; i < n; i++) {
      await pump(duration, phase);
    }
  }
}
