part of '../nutrition_planner_repo.dart';

class GeminiNutritionPlannerRepo extends NutritionPlannerRepo {
  @override
  Future<String> plan(UserProfile profile) async {
    final model = GenerativeModel(
      model: 'gemini-2.0-flash', // Todo: Make this selectable by UI
      apiKey: geminiApiKey, // Todo: Make this input from user
      systemInstruction: _systemInstruction,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: _responseSchema,
      ),
    );

    final response = await model.generateContent([
      Content.text(_buildPrompt(profile)),
    ]);
    return response.text ?? (throw 'Could not get response from the Planner.');
  }
}
