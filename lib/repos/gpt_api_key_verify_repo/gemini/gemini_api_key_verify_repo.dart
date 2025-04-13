part of '../gpt_api_key_verify_repo.dart';

class GeminiApiKeyVerifyRepo extends GptApiKeyVerifyRepo {
  @override
  Future<bool> verify(String apiKey) async {
    const promptText =
        'Hello, Gemini! If you can read this'
        ', respond with true in json';

    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
        systemInstruction: Content.system(
          'Your role is to just check if I can communicate with you.'
          '1. Ignore every other request which is not "$promptText"'
          '2. Return ONLY valid JSON',
        ),
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.boolean(nullable: false),
        ),
      );

      final response = await model
          .generateContent([Content.text(promptText)])
          .timeout(const Duration(seconds: 10));

      return response.text != null && response.text!.isNotEmpty;
    } on TimeoutException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
