import 'dart:async';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:flutter_test/flutter_test.dart';

final defaultDeviceConfigs = {iPhone16, pixel9, iPhone8};

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  AdaptiveTestConfiguration.instance.setDeviceVariants(defaultDeviceConfigs);
  await loadFonts();
  setupFileComparatorWithThreshold(0.01);
  await testMain();
}
