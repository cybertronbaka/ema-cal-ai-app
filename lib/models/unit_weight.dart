/// Represents a measurable weight with metric/imperial conversion capabilities
abstract final class UnitWeight {
  static UnitWeight fromJson(Map<String, dynamic> json) {
    if (json[_isMetricKey] == null) {
      throw 'Cannot determine measurement system for unit weight';
    }

    if (json[_isMetricKey]) {
      return MetricWeight(json[_kgKey]);
    }

    return ImperialWeight(json[_lbsKey]);
  }

  double get kg;
  static const _kgKey = 'kg';
  double get lbs;
  static const _lbsKey = 'lbs';
  bool get isMetric;
  static const _isMetricKey = 'isMetric';

  UnitWeight operator -(double other);

  Map<String, dynamic> toJson() {
    return {_isMetricKey: isMetric, _kgKey: kg, _lbsKey: lbs};
  }

  @override
  bool operator ==(covariant UnitWeight other) {
    return isMetric == other.isMetric && kg == other.kg && lbs == other.lbs;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
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

  @override
  bool get isMetric => false;

  @override
  ImperialWeight operator -(double other) {
    return ImperialWeight(lbs - other);
  }

  @override
  Map<String, dynamic> toJson() {
    return {UnitWeight._isMetricKey: isMetric, UnitWeight._lbsKey: lbs};
  }

  @override
  String toString() => '$kg lbs';
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

  @override
  bool get isMetric => true;

  @override
  MetricWeight operator -(double other) {
    return MetricWeight(kg - other);
  }

  @override
  Map<String, dynamic> toJson() {
    return {UnitWeight._isMetricKey: isMetric, UnitWeight._kgKey: kg};
  }

  @override
  String toString() => '$kg kg';
}
