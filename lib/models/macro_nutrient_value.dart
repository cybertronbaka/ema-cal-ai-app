import 'package:ema_cal_ai/enums/enums.dart';

class MacroNutrientValue {
  const MacroNutrientValue({
    required this.type,
    required this.value,
    required this.maxValue,
  });

  factory MacroNutrientValue.fromJson(Map<String, dynamic> json) {
    return MacroNutrientValue(
      type: MacroNutrients.parse(json['type']),
      value: (json['value'] as num).toDouble(),
      maxValue: (json['maxValue'] as num).toDouble(),
    );
  }

  const MacroNutrientValue.calories({
    required this.value,
    required this.maxValue,
  }) : type = MacroNutrients.calories;

  const MacroNutrientValue.carbs({required this.value, required this.maxValue})
    : type = MacroNutrients.carbs;

  const MacroNutrientValue.protein({
    required this.value,
    required this.maxValue,
  }) : type = MacroNutrients.protein;

  const MacroNutrientValue.fats({required this.value, required this.maxValue})
    : type = MacroNutrients.fats;

  final MacroNutrients type;
  final double value;
  final double maxValue;

  Map<String, dynamic> toJson() {
    return {'type': type.name, 'value': value, 'maxValue': maxValue};
  }
}
