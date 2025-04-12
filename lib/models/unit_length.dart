/// Represents a measurable length with imperial/metric conversion capabilities
abstract final class UnitLength {
  double get cm;
  int get feet;
  double get inches;
  bool get isMetric;
}

/// Imperial units implementation
final class ImperialLength extends UnitLength {
  ImperialLength(this.feet, [double inches = 0])
    : inches = inches.clamp(0, 11.99) {
    if (feet < 0) throw ArgumentError('Feet must be non-negative');
  }

  @override
  final int feet;
  @override
  final double inches;

  // 1 foot = 12 inches
  // 1 inch = 2.54 cm
  @override
  double get cm => (feet * 12 + inches) * 2.54;

  @override
  bool get isMetric => false;
}

/// Metric units implementation
final class MetricLength extends UnitLength {
  MetricLength(this.cm) {
    if (cm < 0) throw ArgumentError('Length must be non-negative');
  }

  @override
  final double cm;

  @override
  int get feet => (cm / 2.54 / 12).floor();

  @override
  double get inches => (cm / 2.54) % 12;

  @override
  bool get isMetric => true;
}
