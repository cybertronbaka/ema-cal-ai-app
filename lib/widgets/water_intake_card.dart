part of 'widgets.dart';

enum WaterIntakeValueTextType { fraction, onlyValue }

class WaterIntakeCard extends StatelessWidget {
  const WaterIntakeCard({
    super.key,
    required this.max,
    required this.value,
    this.description = 'Water Intake',
    this.valueTextType = WaterIntakeValueTextType.fraction,
    this.isEditable = false,
    this.onEdit,
  });

  const WaterIntakeCard.onlyValue({
    super.key,
    required this.value,
    this.description = 'Water Intake',
    this.isEditable = false,
    this.onEdit,
  }) : valueTextType = WaterIntakeValueTextType.onlyValue,
       max = value;

  final double max;
  final double value;
  final String description;
  final WaterIntakeValueTextType valueTextType;
  final bool isEditable;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withAlpha(50)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 16,
        children: [
          FaIcon(
            MacroNutrients.water.icon,
            size: 20,
            color: MacroNutrients.water.color,
          ),
          Expanded(
            child: Column(
              spacing: 4,
              children: [
                Row(
                  children: [
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isEditable) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onEdit,
                        child: const FaIcon(FontAwesomeIcons.pencil, size: 16),
                      ),
                    ],
                    const Spacer(),
                    if (valueTextType == WaterIntakeValueTextType.fraction)
                      Text(
                        '${value.toStringAsFixed(1)}/${max.toStringAsFixed(1)} L',
                        style: const TextStyle(fontSize: 12),
                      ),

                    if (valueTextType == WaterIntakeValueTextType.onlyValue)
                      Text(
                        '${value.toStringAsFixed(1)} L',
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                ),
                LinearProgressIndicator(
                  value: (value / max).clamp(0.0, 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue,
                  minHeight: 8,
                  backgroundColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
