import 'package:ema_cal_ai/app/app.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EmaCalAIApp(keyboardVisibilityController: KeyboardVisibilityController()),
  );
}
