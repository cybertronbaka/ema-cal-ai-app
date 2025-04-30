part of '../gpt_api_key_verify_repo.dart';

class GeminiApiKeyVerifyRepo extends GptApiKeyVerifyRepo {
  @override
  Future<(bool, String?)> verify(String apiKey) async {
    const promptText =
        'Hello, Gemini! If you can read this'
        ', respond with true in json';

    GenerateContentResponse? response;
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

      response = await model
          .generateContent([Content.text(promptText)])
          .timeout(const Duration(seconds: 10));

      return (response.text != null && response.text!.isNotEmpty, null);
    } on TimeoutException {
      return (false, 'Request Timed out');
    } on GenerativeAIException catch (e) {
      try {
        var message = e.message.replaceFirst(RegExp(r'^.*{'), '');
        message = '{$message';
        final json = jsonDecode(message);
        // ignore: avoid_dynamic_calls
        return (false, json['error']['message']! as String);
      } catch (_) {
        return (false, e.message);
      }
    } catch (e) {
      return (false, e.toString());
    }
  }
}
