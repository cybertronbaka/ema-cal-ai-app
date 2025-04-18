import 'package:clock/clock.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/time_of_day.dart';
import 'package:flutter/material.dart';

class MealTimeReminder {
  MealTimeReminder({
    this.id,
    required this.label,
    this.timeOfDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? clock.now(),
       updatedAt = updatedAt ?? clock.now();

  factory MealTimeReminder.fromJson(Map<dynamic, dynamic> json) {
    return MealTimeReminder(
      label: json['label'],
      timeOfDay: TimeOfDayExt.parse(json['time_of_day']),
    );
  }

  factory MealTimeReminder.fromDB(DbReminder data) {
    TimeOfDay? timeOfDay;
    if (data.hour != null && data.minute != null) {
      timeOfDay = TimeOfDay(hour: data.hour!, minute: data.minute!);
    }
    return MealTimeReminder(
      id: data.id.toInt(),
      label: data.label,
      timeOfDay: timeOfDay,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  int? id;
  String label;
  TimeOfDay? timeOfDay;
  DateTime updatedAt;
  DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {'label': label, 'time_of_day': timeOfDay?.toHiveStr()};
  }

  MealTimeReminder copyWith({int? id}) {
    return MealTimeReminder(
      id: id ?? this.id,
      label: label,
      timeOfDay: timeOfDay,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ListMealTimeReminderExt on List<MealTimeReminder> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }
}
