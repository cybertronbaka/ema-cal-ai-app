library;

import 'dart:async';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'gemini/gemini_api_key_verify_repo.dart';

final gptApiKeyVerifyRepoProvider = Provider<GptApiKeyVerifyRepo>(
  (_) => throw UnimplementedError(),
);

abstract class GptApiKeyVerifyRepo {
  Future<bool> verify(String apiKey);
}
