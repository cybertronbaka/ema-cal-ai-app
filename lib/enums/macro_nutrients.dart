part of 'enums.dart';

enum MacroNutrients {
  calories('Calories', null, AppColors.primary),
  protein('Protein', 'g', Colors.amber),
  carbs('Carbs', 'g', Colors.pink),
  fats('Fats', 'g', Colors.blueAccent);

  const MacroNutrients(this.label, this.unit, this.color);

  factory MacroNutrients.parse(String value) {
    return switch (value) {
      'calories' => calories,
      'protein' => protein,
      'carbs' => carbs,
      'fats' => fats,
      _ => throw 'Could not parse $value as MacroNutrients',
    };
  }

  final String label;
  final String? unit;
  final Color color;
}
