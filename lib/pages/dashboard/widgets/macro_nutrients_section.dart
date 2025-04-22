part of '../dashboard_page.dart';

class _MacroNutrientsSection extends StatelessWidget {
  const _MacroNutrientsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children:
          [
            MacroNutrients.protein,
            MacroNutrients.carbs,
            MacroNutrients.fats,
          ].map((nutrient) {
            return _DailyMacroNutrientIntakeCard(type: nutrient);
          }).toList(),
    );
  }
}
