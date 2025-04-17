part of '../nutrition_planner_repo.dart';

class GeminiNutritionPlannerRepo extends NutritionPlannerRepo {
  @override
  Future<NutritionPlan> plan(UserProfile profile, String gptApiKey) async {
    final response = await GenerativeModel(
      model: 'gemini-2.0-flash', // Todo: Make this selectable by UI
      apiKey: gptApiKey,
      systemInstruction: _systemInstruction,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: _responseSchema,
      ),
    ).generateContent([Content.text(_buildPrompt(profile))]);

    return NutritionPlan.fromJson(
      jsonDecode(
        response.text ?? (throw 'Could not get response from the Planner.'),
      ),
    );
  }
}
