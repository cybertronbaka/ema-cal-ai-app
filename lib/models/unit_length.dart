/// Represents a measurable length with imperial/metric conversion capabilities
abstract final class UnitLength {
  static UnitLength fromJson(Map<dynamic, dynamic> json) {
    if (json[_isMetricKey] == null) {
      throw 'Cannot determine measurement system for unit length';
    }

    if (json[_isMetricKey]) {
      return MetricLength(json[_cmKey]);
    }

    return ImperialLength(json[_feetKey], json[_inchesKey]);
  }

  double get cm;
  static const _cmKey = 'cm';
  int get feet;
  static const _feetKey = 'feet';
  double get inches;
  static const _inchesKey = 'inches';
  bool get isMetric;
  static const _isMetricKey = 'isMetric';

  Map<String, dynamic> toJson() {
    return {
      _isMetricKey: isMetric,
      _cmKey: cm,
      _feetKey: feet,
      _inchesKey: inches,
    };
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

  @override
  Map<String, dynamic> toJson() {
    return {
      UnitLength._isMetricKey: isMetric,
      UnitLength._feetKey: feet,
      UnitLength._inchesKey: inches,
    };
  }
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

  @override
  Map<String, dynamic> toJson() {
    return {UnitLength._isMetricKey: isMetric, UnitLength._cmKey: cm};
  }
}
