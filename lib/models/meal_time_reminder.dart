import 'package:ema_cal_ai/extensions/time_of_day.dart';
import 'package:flutter/material.dart';

class MealTimeReminder {
  MealTimeReminder({required this.label, this.timeOfDay, required this.icon});

  factory MealTimeReminder.fromJson(Map<dynamic, dynamic> json) {
    return MealTimeReminder(
      label: json['label'],
      icon: json['icon'],
      timeOfDay: TimeOfDayExt.parse(json['time_of_day']),
    );
  }

  String label;
  TimeOfDay? timeOfDay;
  String icon;

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'icon': icon,
      'time_of_day': timeOfDay?.toHiveStr(),
    };
  }
}

extension ListMealTimeReminderExt on List<MealTimeReminder> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }
}
