import 'package:ema_cal_ai/app/app.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();
  final packageInfo = await PackageInfo.fromPlatform();

  debugPrint('Database is at: ${await getApplicationSupportDirectory()}');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EmaCalAIApp(
      keyboardVisibilityController: KeyboardVisibilityController(),
      packageInfo: packageInfo,
    ),
  );
}
