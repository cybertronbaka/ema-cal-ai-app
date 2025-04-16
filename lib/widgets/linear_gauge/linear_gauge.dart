part of '../widgets.dart';

class LinearGauge extends HookWidget {
  const LinearGauge({
    super.key,

    /// List of major tick values (for example: [0.5, 1, 2, 5, 10, 30]).
    required this.majorValues,

    /// The initial value that the gauge should show. Must be in the range
    /// from majorValues.first to majorValues.last.
    required this.initialValue,
    this.onValueChanged,
    this.indicator = const GaugeLineConfig.indicator(),
    this.majorLine = const GaugeLineConfig.major(),
    this.minorLine = const GaugeLineConfig.minor(),

    /// The width of the gauge (not the scrollable widget(This width is calculated automatically))
    required this.wrapperWidth,

    /// The horizontal pixel spacing for each minor division.
    this.stepSpacing = 12,

    /// The number of equal subdivisions between consecutive major ticks.
    this.divisions = 5,
    this.textStyle = const TextStyle(color: Colors.black87, fontSize: 10),
    this.debug = false,
    this.onValueChangedDelay = const Duration(milliseconds: 100),
    this.controller,
  });

  final List<double> majorValues;
  final double initialValue;
  final ValueChanged<double>? onValueChanged;
  final GaugeLineConfig indicator;
  final GaugeLineConfig majorLine;
  final GaugeLineConfig minorLine;
  final double stepSpacing;
  final int divisions;
  final TextStyle textStyle;
  final double wrapperWidth;
  final bool debug;
  final Duration onValueChangedDelay;
  final LinearGaugeController? controller;

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ?? useLinerGaugeController(initialValue: initialValue);
    final cache = _useGaugeCache(
      majorValues: majorValues,
      divisions: divisions,
      indicator: indicator,
      major: majorLine,
      minor: minorLine,
      stepSpacing: stepSpacing,
    );
    controller._cache = cache;
    final timer = useValueNotifier<Timer?>(null);
    final calledForValue = useValueNotifier<double?>(null);

    return SizedBox(
      width: wrapperWidth,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification ||
                  notification is ScrollEndNotification ||
                  notification is UserScrollNotification) {
                _handleScroll(
                  notification.metrics.pixels,
                  controller,
                  cache,
                  timer,
                  calledForValue,
                );
              }
              return true;
            },
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                scrollbars: false,
                overscroll: false,
              ),
              child: SingleChildScrollView(
                controller: controller.scrollController,
                scrollDirection: Axis.horizontal,
                physics: SlowScrollPhysics(
                  parent: const AlwaysScrollableScrollPhysics(),
                  maxFlingVelocity: cache.rangeWidth,
                ),
                child: Container(
                  width: wrapperWidth + cache.totalWidth,
                  margin: EdgeInsets.only(
                    top:
                        cache.tallestLineHeight -
                        math.max(majorLine.height, minorLine.height),
                    // left: _totalWidth / 2,
                  ),
                  child: RulerWidget(
                    wrapperWidth: wrapperWidth,
                    majorValues: cache.majorValues,
                    divisions: divisions,
                    stepSpacing: stepSpacing,
                    majorLine: majorLine,
                    minorLine: minorLine,
                    textStyle: textStyle,
                  ),
                ),
              ),
            ),
          ),
          // The fixed center indicator line.
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: indicator.width,
                height: indicator.height,
                color: indicator.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callOnValueChanged(
    double value,
    LinearGaugeController controller,
    ValueNotifier<Timer?> timer,
    ValueNotifier<double?> calledForValue,
  ) {
    value = double.parse(value.toStringAsFixed(1));
    if (calledForValue.value == value) {
      if (debug) {
        debugPrint(
          'already called for value $value, so not gonna even attempt',
        );
      }
      return;
    }

    if (debug) debugPrint('-----------value: $value');
    timer.value?.cancel();
    calledForValue.value = null;
    timer.value = Timer(onValueChangedDelay, () {
      if (debug) debugPrint('----------timer finished so jumping to $value');
      calledForValue.value = value;
      controller.scrollToValue(value);
      timer.value?.cancel();
      timer.value = null;
      controller.value = value;
      onValueChanged?.call(value);
    });
  }

  /// Converts the current scroll offset to the corresponding gauge value.
  void _handleScroll(
    double offset,
    LinearGaugeController controller,
    _GaugeCache cache,
    ValueNotifier<Timer?> timer,
    ValueNotifier<double?> calledForValue,
  ) {
    // todo: Handle snapping and haptics

    final rangeIndex = offset ~/ cache.rangeWidth;

    if (offset <= 0) {
      _callOnValueChanged(
        cache.majorValues.first,
        controller,
        timer,
        calledForValue,
      );
      return;
    }

    if (offset >= cache.totalWidth) {
      _callOnValueChanged(
        cache.majorValues.last,
        controller,
        timer,
        calledForValue,
      );
      return;
    }

    final start = cache.majorValues[rangeIndex];
    final end = cache.majorValues[rangeIndex + 1];
    final startOffset = rangeIndex * cache.rangeWidth;
    final delta = (offset - startOffset) / cache.rangeWidth;
    final valueRange = end - start;
    final value = start + (valueRange * delta);
    if (debug) {
      debugPrint('rangeIndex: $rangeIndex');
      debugPrint('offset: $offset');
      debugPrint('start: $start');
      debugPrint('end: $end');
      debugPrint('startOffset: $startOffset');
      debugPrint('delta: $delta');
    }

    _callOnValueChanged(value, controller, timer, calledForValue);
  }
}

class _GaugeCache {
  _GaugeCache({
    required this.majorValues,
    required this.totalDivisions,
    required this.divisions,
    required this.rangeWidth,
    required this.totalWidth,
    required this.tallestLineHeight,
  });
  final List<double> majorValues;
  final int totalDivisions;
  final int divisions;
  final double rangeWidth;
  final double totalWidth;
  final double tallestLineHeight;
}

_GaugeCache _useGaugeCache({
  required List<double> majorValues,
  required int divisions,
  required GaugeLineConfig indicator,
  required GaugeLineConfig major,
  required GaugeLineConfig minor,
  required double stepSpacing,
}) {
  // Sort and memoize major values
  final sortedValues = useMemoized(() => [...majorValues]..sort(), [
    majorValues,
  ]);

  // Calculate derived values
  final totalDivisions = useMemoized(
    () => (sortedValues.length - 1) * divisions,
    [sortedValues, divisions],
  );

  final rangeWidth = useMemoized(() => stepSpacing * divisions, [
    stepSpacing,
    divisions,
  ]);

  final totalWidth = useMemoized(() => totalDivisions * stepSpacing, [
    totalDivisions,
    stepSpacing,
  ]);

  final tallestLineHeight = useMemoized(
    () => [indicator.height, major.height, minor.height].reduce(math.max),
    [indicator.height, major.height, minor.height],
  );

  // Return the cached values
  return useMemoized(
    () => _GaugeCache(
      majorValues: sortedValues,
      totalDivisions: totalDivisions,
      divisions: divisions,
      rangeWidth: rangeWidth,
      totalWidth: totalWidth,
      tallestLineHeight: tallestLineHeight,
    ),
    [
      sortedValues,
      totalDivisions,
      divisions,
      rangeWidth,
      totalWidth,
      tallestLineHeight,
    ],
  );
}
