part of 'enums.dart';

enum BMICategory {
  underweight('Underweight', Colors.blue, Colors.white, (0.0, 18.5)),
  healthy('Healthy', Colors.green, Colors.black, (18.5, 25.0)),
  overweight('Overweight', Colors.yellow, Colors.black, (25.0, 30.0)),
  obese('Obese', Colors.red, Colors.white, (30.0, double.infinity));

  const BMICategory(this.label, this.color, this.fgColor, this.range);
  final String label;
  final Color color;
  final Color fgColor;
  final (double, double) range;

  static BMICategory fromBMI(double bmi) {
    for (var cat in values) {
      if (cat.index == 0 && bmi < cat.range.$1) return cat;

      if (bmi >= cat.range.$1 && bmi < cat.range.$2) return cat;
    }

    return values.last;
  }
}
