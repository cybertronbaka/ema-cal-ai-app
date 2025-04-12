import 'dart:io';

import 'package:flutter/foundation.dart';

Map<String, dynamic> _envVars = {};
bool _loaded = false;

/// Loads Env from .env file if in debug mode otherwise, need to define using
/// --dart-define
void loadEnv() {
  if (_loaded) return;

  if (kDebugMode) {
    final envFile = File('.env');
    if (envFile.existsSync()) {
      final lines = envFile.readAsLinesSync();
      _envVars = {
        for (final line in lines)
          if (line.contains('=')) ...{
            line.split('=')[0].trim(): line.split('=')[1].trim(),
          },
      };
    }
  }
  _loaded = true;
}

T getEnv<T>(String key) {
  if (kDebugMode) {
    loadEnv();
    final value = _envVars[key];
    if (value == null) throw 'Environment Variable $key not found!';

    return value as T;
  }

  if (T == String) return String.fromEnvironment(key) as T;

  if (T == int) return int.fromEnvironment(key) as T;

  if (T == bool) return bool.fromEnvironment(key) as T;

  throw 'Environment Variable cannot be of type $T';
}
