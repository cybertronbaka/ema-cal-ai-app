import 'dart:io';

bool get kIsTest => Platform.environment.containsKey('FLUTTER_TEST');
