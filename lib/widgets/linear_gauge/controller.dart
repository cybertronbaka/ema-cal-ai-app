part of '../widgets.dart';

class LinearGaugeController extends ChangeNotifier {
  LinearGaugeController({required double initialValue, this.debug = false})
    : _value = initialValue;

  late final ScrollController scrollController = ScrollController();
  final bool debug;

  _GaugeCache? _cache;

  void handleValue() {}

  double _value;
  double get value => _value;

  set value(double val) {
    if (value == val) return;
    _value = value;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToValue(double value) {
    scrollController.jumpTo(_computeOffsetFromValue(value));
  }

  double _computeOffsetFromValue(double value) {
    if (_cache == null) throw 'This is not expected';

    for (var i = 0; i < _cache!.majorValues.length - 1; i++) {
      final start = _cache!.majorValues[i];
      final end = _cache!.majorValues[i + 1];
      if (value >= start && value <= end) {
        final factor = (value - start) / (end - start);
        if (debug) debugPrint('factor: $factor');
        final normalOffset =
            (i * _cache!.rangeWidth) + (_cache!.rangeWidth * factor);
        if (debug) debugPrint('normalOffset: $normalOffset');

        return normalOffset;
      }
    }
    return 0.0;
  }
}

LinearGaugeController useLinerGaugeController({
  required double initialValue,
  String debugLabel = 'useLinerGaugeController',
  bool debug = false,
}) {
  final controller = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return LinearGaugeController(initialValue: initialValue);
  }, []);

  useEffect(() => controller.dispose, []);

  return controller;
}
