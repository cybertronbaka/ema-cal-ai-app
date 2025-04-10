import 'package:flutter/material.dart';

class MealTimeReminder {
  MealTimeReminder({required this.label, this.timeOfDay, required this.icon});

  String label;
  TimeOfDay? timeOfDay;
  String icon;
}
