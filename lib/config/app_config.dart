// Todo: bring database config (Which is database placement) here
import 'package:ema_cal_ai/models/range.dart';
import 'package:flutter/material.dart';

class AppConfig {
  factory AppConfig() => instance;

  AppConfig._internal({
    required this.heightCmRange,
    required this.heightFeetRange,
    required this.heightInchesRange,
    required this.weightKgRange,
    required this.weightLbsRange,
    required this.hPadding,
  });
  static AppConfig instance = AppConfig._internal(
    heightCmRange: const Range<int>(60, 250),
    heightFeetRange: const Range<int>(1, 9),
    heightInchesRange: const Range<int>(0, 11),
    weightKgRange: const Range<int>(20, 400),
    weightLbsRange: const Range<int>(40, 800),
    hPadding: const EdgeInsets.symmetric(horizontal: 16),
  );

  final Range<int> heightCmRange;
  final Range<int> heightFeetRange;
  final Range<int> heightInchesRange;
  final Range<int> weightKgRange;
  final Range<int> weightLbsRange;
  final EdgeInsets hPadding;
}
