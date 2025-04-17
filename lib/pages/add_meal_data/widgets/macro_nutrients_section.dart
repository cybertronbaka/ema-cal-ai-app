part of '../add_meal_data_page.dart';

class _MacroNutrientsSection extends StatelessWidget {
  const _MacroNutrientsSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 8,
      children: [
        Row(
          spacing: 8,
          children: [
            _EditMacroNutrientValueCard(type: MacroNutrients.calories),
            _EditMacroNutrientValueCard(type: MacroNutrients.protein),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            _EditMacroNutrientValueCard(type: MacroNutrients.carbs),
            _EditMacroNutrientValueCard(type: MacroNutrients.fats),
          ],
        ),
      ],
    );
  }
}
