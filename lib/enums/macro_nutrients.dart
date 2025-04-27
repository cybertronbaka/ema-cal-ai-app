part of 'enums.dart';

enum MacroNutrients {
  calories('Calories', null, AppColors.primary, FontAwesomeIcons.bolt),
  protein('Protein', 'g', Colors.amber, FontAwesomeIcons.egg),
  carbs('Carbs', 'g', Colors.pink, FontAwesomeIcons.wheatAwn),
  water('Water', 'L', Colors.blue, FontAwesomeIcons.droplet),
  fats('Fats', 'g', Colors.blueAccent, FontAwesomeIcons.bacon);

  const MacroNutrients(this.label, this.unit, this.color, this.icon);

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
  final IconData icon;
}
