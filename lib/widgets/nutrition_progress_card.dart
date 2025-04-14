part of 'widgets.dart';

class NutritionProgressCard extends StatelessWidget {
  const NutritionProgressCard({super.key, required this.value});

  final MacroNutrientValue value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withAlpha(50)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.type.label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: value.value / value.maxValue,
                  backgroundColor: Colors.grey.withAlpha(100),
                  color: value.type.color,
                  strokeWidth: 5,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.maxValue.toInt().toString()),
                      if (value.type.unit != null) Text(' ${value.type.unit}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
