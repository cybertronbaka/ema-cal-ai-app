part of 'widgets.dart';

class BMIIndicator extends StatelessWidget {
  const BMIIndicator({
    super.key,
    required this.bmi,
    required this.minBmi,
    required this.maxBmi,
  });
  final double maxBmi;
  final double minBmi;
  final double bmi;

  static const _gradientHeight = 15.0;
  static const _indicatorHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    final t = ((bmi - minBmi) / (maxBmi - minBmi)).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: math.max(_indicatorHeight, _gradientHeight),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: _gradientHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      gradient: LinearGradient(
                        colors: BMICategory.values.map((e) => e.color).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (t * width) - 1,
                child: Container(
                  height: _indicatorHeight,
                  width: 2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
