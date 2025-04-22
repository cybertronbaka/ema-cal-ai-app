/// Represents a measurable weight with metric/imperial conversion capabilities
abstract final class UnitWeight {
  static UnitWeight fromKg(double kg, bool isMetric) {
    if (isMetric) {
      return MetricWeight(kg);
    }
    return ImperialWeight.fromKg(kg);
  }

  double get kg;
  double get lbs;
  bool get isMetric;

  UnitWeight operator -(double other);

  Map<String, dynamic> toJson() {
    return {'isMetric': isMetric, 'kg': kg, 'lbs': lbs};
  }

  @override
  bool operator ==(Object other) {
    if (other is! UnitWeight) return false;

    return isMetric == other.isMetric && kg == other.kg && lbs == other.lbs;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

/// Imperial units implementation (pounds)
final class ImperialWeight extends UnitWeight {
  ImperialWeight(this.lbs) : assert(lbs >= 0, 'Weight must be non-negative');

  factory ImperialWeight.fromKg(double kg) {
    if (kg < 0) return ImperialWeight(0);

    final lbs = kg / 0.45359237;
    return ImperialWeight(lbs);
  }

  @override
  final double lbs;

  @override
  double get kg => lbs * 0.45359237;

  @override
  bool get isMetric => false;

  @override
  ImperialWeight operator -(double other) {
    return ImperialWeight(lbs - other);
  }

  @override
  String toString() => '${lbs.toInt()} lbs';
}

/// Metric units implementation (kilograms)
final class MetricWeight extends UnitWeight {
  MetricWeight(this.kg) : assert(kg >= 0, 'Weight must be non-negative');

  @override
  final double kg;

  @override
  double get lbs => kg * 2.20462262185;

  @override
  bool get isMetric => true;

  @override
  MetricWeight operator -(double other) {
    return MetricWeight(kg - other);
  }

  @override
  String toString() => '${kg.toInt()} kg';
}
