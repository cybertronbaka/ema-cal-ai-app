part of 'enums.dart';

enum MeasurementSystem {
  metric,
  imperial;

  bool get isMetric => this == metric;
}
