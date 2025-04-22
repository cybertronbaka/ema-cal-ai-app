/// Represents a measurable length with imperial/metric conversion capabilities
abstract final class UnitLength {
  static UnitLength fromCm(double cm, bool isMetric) {
    if (isMetric) {
      return MetricLength(cm);
    }
    return ImperialLength.fromCm(cm);
  }

  double get cm;
  int get feet;
  double get inches;
  bool get isMetric;

  Map<String, dynamic> toJson() {
    return {'isMetric': isMetric, 'cm': cm, 'feet': feet, 'inches': inches};
  }

  @override
  bool operator ==(Object other) {
    if (other is! UnitLength) return false;

    return isMetric == other.isMetric &&
        cm == other.cm &&
        feet == other.feet &&
        inches == other.inches;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

/// Imperial units implementation
final class ImperialLength extends UnitLength {
  ImperialLength(this.feet, [double inches = 0])
    : assert(feet >= 0, 'Feet must be non-negative'),
      // Clamping here
      inches = inches < 0 ? 0 : (inches > 11.99 ? 11.99 : inches);

  factory ImperialLength.fromCm(double cm) {
    if (cm < 0) return ImperialLength(0, 0);

    final totalInches = cm / 2.54;
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;

    return ImperialLength(feet, inches);
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

  @override
  String toString() {
    return '${feet.toInt()} ft, ${inches.toInt()} in';
  }
}

/// Metric units implementation
final class MetricLength extends UnitLength {
  MetricLength(this.cm) : assert(cm >= 0, 'CM must be non-negative');

  @override
  final double cm;

  @override
  int get feet => (cm / 2.54 / 12).floor();

  @override
  double get inches => (cm / 2.54) % 12;

  @override
  bool get isMetric => true;

  @override
  String toString() {
    return '${cm.toInt()} cm';
  }
}
