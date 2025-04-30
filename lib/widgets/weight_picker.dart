part of 'widgets.dart';

class WeightPicker extends HookWidget {
  const WeightPicker({
    super.key,
    required this.initialWeight,
    required this.isMetric,
    this.controller,
    this.onValueChanged,
  });
  final UnitWeight initialWeight;
  final bool isMetric;
  final WheelPickerController? controller;
  final void Function(UnitWeight)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    final range = isMetric ? appConfig.weightKgRange : appConfig.weightLbsRange;
    final initialValue = isMetric ? initialWeight.kg : initialWeight.lbs;
    final controller =
        this.controller ??
        useWheelPickerController(
          min: range.start.toInt(),
          max: range.end.toInt(),
          initialValue: initialValue.toInt(),
          dependencies: [isMetric],
        );

    return WheelPicker(
      controller: controller,
      onValueChanged: (value) {
        onValueChanged?.call(
          isMetric
              ? MetricWeight(value.toDouble())
              : ImperialWeight(value.toDouble()),
        );
      },
      builder: (context, value) => Text(valueToString(value)),
    );
  }

  String valueToString(int value) {
    return isMetric ? '$value kg' : '$value lb';
  }
}
