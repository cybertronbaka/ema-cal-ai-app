part of '../nutrition_planner_repo.dart';

String _buildPrompt(UserProfile profile) {
  return '''
Generate nutrition plan JSON for:
- Age: ${profile.dob.calculateAge()}
- Gender: ${profile.gender.name}
- Height: ${profile.height.cm} cm
- Current Weight: ${profile.weight.kg} kg
- Desired Weight: ${profile.weightGoal.kg} kg
- Rate of Loss/Gain: 0.8 kg/week
- Diet: ${profile.diet.name}
- Workout Frequency: ${profile.workoutFrequency.label}

**Requirements**:  
1. **Calories**:  
  - Calculate BMR (Mifflin-St Jeor equation) and maintenance calories (BMR × 1.2 for sedentary activity).  
  - Adjust calories for goal:  
    - Deficit = [rate_kg_per_week × 7700 kcal/kg] ÷ 7 days (for weight loss).  
    - Surplus = [rate_kg_per_week × 7700 kcal/kg] ÷ 7 days (for weight gain).  
  - Ensure deficit/surplus does NOT exceed ±1000 kcal/day (for safety).  

2. **Macro nutrients**:  
  - Protein: 1.6–2.2g/kg (use desired weight for muscle gain, current weight for fat loss).  
  - Fats: 25–30% of total calories.  
  - Carbs: Remaining calories.  

3. **Water**: 35ml/kg (current weight).  

4. **Timeframe**:  
  - Calculate weeks needed: |(current_weight - desired_weight)| ÷ rate_kg_per_week.  
  - If rate > 1 kg/week for loss or > 0.5 kg/week for gain, add safety warnings.  

Formulas:
- BMR: Mifflin-St Jeor (${profile.gender.name})
- Maintenance: BMR × 1.2
- Goal Calories: Maintenance ± (0.8 × 1100)
- Protein: ${profile.weightGoal} kg × 1.8g/kg
- Water: ${profile.weight} kg × 35ml

Return JSON without markdown:
{
  "goal": {"calories": number, ...},
  "timeframe_weeks": number,
  "bmi_index": number,
  "notes": {
    "gym_advice": "[Fitness tips: e.g., resistance training frequency, protein timing]",
    "medical_advice": "[Health precautions: e.g., monitor energy levels, consult a doctor]", 
    "warnings": "[If rate is unsafe or deficit/surplus exceeds ±1000 kcal]"
  }
}
''';
}
