class ChartData {
  const ChartData({required this.interval, required this.value});
  final String interval;
  final double value;

  @override
  String toString() {
    return '{\n  interval: "$interval",\n  value: $value\n}';
  }
}
