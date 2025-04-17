part of 'widgets.dart';

enum WaterIntakeValueTextType { fraction, onlyValue }

class WaterIntakeCard extends StatelessWidget {
  const WaterIntakeCard({
    super.key,
    required this.max,
    required this.value,
    this.description = 'Water Intake',
    this.valueTextType = WaterIntakeValueTextType.fraction,
  });

  const WaterIntakeCard.onlyValue({
    super.key,
    required this.value,
    this.description = 'Water Intake',
  }) : valueTextType = WaterIntakeValueTextType.onlyValue,
       max = value;

  final double max;
  final double value;
  final String description;
  final WaterIntakeValueTextType valueTextType;

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
        spacing: 8,
        children: [
          const Text('💧', style: TextStyle(fontSize: 22)),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                Stack(
                  children: [
                    Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),

                    FractionallySizedBox(
                      widthFactor: (value / max).clamp(0.0, 1.0),
                      child: Container(
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
