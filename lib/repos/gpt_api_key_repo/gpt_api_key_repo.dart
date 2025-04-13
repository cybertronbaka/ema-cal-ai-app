library;

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gptApiKeyRepoProvider = Provider<GptApiKeyRepo>(
  (_) => throw UnimplementedError(),
);

abstract class GptApiKeyRepo {
  Future<String?> get();
  Future<void> save(String apiKey);
}

class LocalGptApiKeyRepo extends GptApiKeyRepo {
  static const boxName = 'gpt_key';

  @override
  Future<String?> get() async {
    final box = await _openBox();
    if (box.isEmpty) return null;

    return box.get('api_key');
  }

  @override
  Future<void> save(String apiKey) async {
    final box = await _openBox();
    await box.put('api_key', apiKey);
  }

  Future<Box> _openBox() => Hive.openBox(boxName);
}
