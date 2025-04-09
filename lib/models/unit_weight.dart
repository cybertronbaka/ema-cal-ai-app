/// Represents a measurable weight with metric/imperial conversion capabilities
abstract final class UnitWeight {
  /// The weight in kilograms
  double get kg;

  /// The weight in pounds
  double get lbs;
}

/// Imperial units implementation (pounds)
final class ImperialWeight extends UnitWeight {
  ImperialWeight(this.lbs) {
    if (lbs < 0) throw ArgumentError('Weight must be non-negative');
  }

  @override
  final double lbs;

  @override
  double get kg => lbs * 0.45359237;
}

/// Metric units implementation (kilograms)
final class MetricWeight extends UnitWeight {
  MetricWeight(this.kg) {
    if (kg < 0) throw ArgumentError('Weight must be non-negative');
  }

  @override
  final double kg;

  @override
  double get lbs => kg * 2.20462262185;
}
