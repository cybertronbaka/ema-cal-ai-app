import 'package:ema_cal_ai/extensions/time_of_day.dart';
import 'package:flutter/material.dart';

class MealTimeReminder {
  MealTimeReminder({required this.label, this.timeOfDay, required this.icon});

  factory MealTimeReminder.fromJson(Map<dynamic, dynamic> json) {
    return MealTimeReminder(
      label: json[_labelKey],
      icon: json[_iconKey],
      timeOfDay: TimeOfDayExt.parse(json[_timeOfDayKey]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _labelKey: label,
      _iconKey: icon,
      _timeOfDayKey: timeOfDay?.toHiveStr(),
    };
  }

  String label;
  static const _labelKey = 'label';

  TimeOfDay? timeOfDay;
  static const _timeOfDayKey = 'timeOfDay';

  String icon;
  static const _iconKey = 'icon';
}
