import 'package:flutter/material.dart';

abstract class TimeUtils {
  static String formatTimeOfDay(TimeOfDay time) {
    return '${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.period.name.toUpperCase()}';
  }
}
