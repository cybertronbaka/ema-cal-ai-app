import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {
  static const _delimiter = ':';

  String toHiveStr() {
    return '$hour$_delimiter$minute';
  }

  static TimeOfDay? parse(String? value) {
    if (value == null || value.isEmpty) return null;

    final split = value.split(_delimiter);

    if (split.length != 2) {
      throw 'TimeOfDay cannot be parsed from "$value"';
    }

    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }
}
