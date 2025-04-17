part of '../widgets.dart';

class GaugeLineConfig {
  const GaugeLineConfig({
    this.height = 10,
    this.width = 2,
    this.color = Colors.black,
  });

  const GaugeLineConfig.indicator({
    this.height = 25,
    this.width = 2,
    this.color = Colors.red,
  });

  const GaugeLineConfig.major({
    this.height = 20,
    this.width = 2,
    this.color = Colors.black,
  });

  const GaugeLineConfig.minor({
    this.height = 10,
    this.width = 2,
    this.color = Colors.black,
  });

  final double height;
  final double width;
  final Color color;
}
