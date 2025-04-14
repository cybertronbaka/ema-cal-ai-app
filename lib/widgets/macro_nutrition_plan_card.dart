part of 'widgets.dart';

class MacroNutritionPlanCard extends StatelessWidget {
  const MacroNutritionPlanCard({
    super.key,
    required this.type,
    required this.value,
  });

  final MacroNutrients type;
  final double value;

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
          Text(type.label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey.withAlpha(100),
                  color: type.color,
                  strokeWidth: 5,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.toInt().toString()),
                      if (type.unit != null) Text(' ${type.unit}'),
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
