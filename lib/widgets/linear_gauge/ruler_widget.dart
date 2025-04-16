part of '../widgets.dart';

class RulerWidget extends LeafRenderObjectWidget {
  const RulerWidget({
    super.key,
    required this.majorValues,
    required this.divisions,
    required this.stepSpacing,
    required this.majorLine,
    required this.minorLine,
    required this.textStyle,
    required this.wrapperWidth,
  });

  final List<double> majorValues;
  final int divisions;
  final double stepSpacing;
  final GaugeLineConfig majorLine;
  final GaugeLineConfig minorLine;
  final TextStyle textStyle;
  final double wrapperWidth;

  @override
  RenderRuler createRenderObject(BuildContext context) {
    return RenderRuler(
      majorValues: majorValues,
      divisions: divisions,
      stepSpacing: stepSpacing,
      majorLine: majorLine,
      minorLine: minorLine,
      textStyle: textStyle,
      wrapperWidth: wrapperWidth,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderRuler renderObject,
  ) {
    renderObject
      ..majorValues = majorValues
      ..divisions = divisions
      ..stepSpacing = stepSpacing
      ..majorLine = majorLine
      ..minorLine = minorLine
      ..textStyle = textStyle
      ..wrapperWidth = wrapperWidth;
  }
}

/// The custom render object that draws the ruler.
class RenderRuler extends RenderBox {
  RenderRuler({
    required List<double> majorValues,
    required int divisions,
    required double stepSpacing,
    required GaugeLineConfig majorLine,
    required GaugeLineConfig minorLine,
    required TextStyle textStyle,
    required double wrapperWidth,
  }) : _majorValues = majorValues,
       _divisions = divisions,
       _stepSpacing = stepSpacing,
       _majorLine = majorLine,
       _minorLine = minorLine,
       _textStyle = textStyle,
       _wrapperWidth = wrapperWidth {
    _updateTextPainters();
  }

  // Properties and their setters
  double get wrapperWidth => _wrapperWidth;
  double _wrapperWidth;
  set wrapperWidth(double value) {
    if (_wrapperWidth != value) {
      _wrapperWidth = value;
      _updateTextPainters();
      markNeedsLayout();
      _clearCache();
    }
  }

  List<double> get majorValues => _majorValues;
  List<double> _majorValues;
  set majorValues(List<double> value) {
    if (_majorValues != value) {
      _majorValues = value;
      _updateTextPainters();
      markNeedsLayout();
      _clearCache();
    }
  }

  int get divisions => _divisions;
  int _divisions;
  set divisions(int value) {
    if (_divisions != value) {
      _divisions = value;
      markNeedsLayout();
      _clearCache();
    }
  }

  double get stepSpacing => _stepSpacing;
  double _stepSpacing;
  set stepSpacing(double value) {
    if (_stepSpacing != value) {
      _stepSpacing = value;
      markNeedsLayout();
      _clearCache();
    }
  }

  GaugeLineConfig get majorLine => _majorLine;
  GaugeLineConfig _majorLine;
  set majorLine(GaugeLineConfig value) {
    if (_majorLine != value) {
      _majorLine = value;
      markNeedsLayout();
      _clearCache();
    }
  }

  GaugeLineConfig get minorLine => _minorLine;
  GaugeLineConfig _minorLine;
  set minorLine(GaugeLineConfig value) {
    if (_minorLine != value) {
      _minorLine = value;
      markNeedsLayout();
      _clearCache();
    }
  }

  TextStyle get textStyle => _textStyle;
  TextStyle _textStyle;
  set textStyle(TextStyle value) {
    if (_textStyle != value) {
      _textStyle = value;
      _updateTextPainters();
      markNeedsLayout();
      _clearCache();
    }
  }

  static const double gap = 6.0; // Gap between tick and label.

  List<TextPainter> _majorTextPainters = [];

  // Rebuilds the list of TextPainters for the major tick labels.
  void _updateTextPainters() {
    _majorTextPainters = List.generate(_majorValues.length, (index) {
      final double value = _majorValues[index];
      final String label = value.toStringAsFixed(value % 1 == 0 ? 0 : 1);
      final textSpan = TextSpan(text: label, style: _textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      tp.layout();
      return tp;
    });
  }

  // Picture cache (to avoid redoing drawing commands every frame).
  Picture? _cachedPicture;
  Size? _cacheSize;

  void _clearCache() {
    _cachedPicture = null;
    _cacheSize = null;
  }

  @override
  void performLayout() {
    // Compute total number of subdivisions.
    final int totalDivisions = (_majorValues.length - 1) * _divisions;
    // Use total tick count * stepSpacing for width.
    final double desiredWidth = totalDivisions * _stepSpacing;

    // Compute the tick area height (we use the major tick height).
    final double tickAreaHeight = _majorLine.height;
    // Determine label height (use the maximum height among all major tick labels).
    double labelHeight = 0;
    if (_majorTextPainters.isNotEmpty) {
      labelHeight = _majorTextPainters
          .map((tp) => tp.height)
          .fold(0.0, (prev, h) => h > prev ? h : prev);
    } else {
      final tp = TextPainter(
        text: TextSpan(text: '0', style: _textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      labelHeight = tp.height;
    }
    // Total height reserves room for ticks, a gap, and the labels.
    final double desiredHeight = tickAreaHeight + gap + labelHeight;
    size = constraints.constrain(Size(desiredWidth, desiredHeight));
  }

  // Draws the ticks and labels (this is the same drawing logic as your CustomPainter).
  void _drawRuler(Canvas canvas, Size size) {
    final Paint majorPaint =
        Paint()
          ..color = _majorLine.color
          ..strokeWidth = _majorLine.width;
    final Paint minorPaint =
        Paint()
          ..color = _minorLine.color
          ..strokeWidth = _minorLine.width;

    final int totalDivisions = (_majorValues.length - 1) * _divisions;
    // The bottom of the tick area is defined by the major tick's full height.
    final double tickAreaHeight = _majorLine.height;
    for (int i = 0; i <= totalDivisions; i++) {
      // Center of the SizedWidget the scrollable widget
      final center = wrapperWidth / 2;
      // Offset from center because it is easier
      // This way I don't need to normalize in scroll events and stuff
      final double x = center + (i * _stepSpacing);
      final bool isMajor = i % _divisions == 0;
      final double tickHeight = isMajor ? _majorLine.height : _minorLine.height;
      final double startY = tickAreaHeight - tickHeight;
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, tickAreaHeight),
        isMajor ? majorPaint : minorPaint,
      );

      if (isMajor) {
        final int sectionIndex = i ~/ _divisions;
        if (sectionIndex < _majorTextPainters.length) {
          final tp = _majorTextPainters[sectionIndex];
          final Offset labelOffset = Offset(
            x - tp.width / 2,
            tickAreaHeight + gap,
          );
          tp.paint(canvas, labelOffset);
        }
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // (Re)generate the cached picture only if our size (or properties) have changed.
    if (_cachedPicture == null || _cacheSize != size) {
      final PictureRecorder recorder = PictureRecorder();
      final Canvas offscreenCanvas = Canvas(recorder);
      _drawRuler(offscreenCanvas, size);
      _cachedPicture = recorder.endRecording();
      _cacheSize = size;
    }
    canvas.drawPicture(_cachedPicture!);

    canvas.restore();
  }

  @override
  bool hitTestSelf(Offset position) => false;
}

class SlowScrollPhysics extends ScrollPhysics {
  const SlowScrollPhysics({super.parent, required this.maxFlingVelocity});
  @override
  final double maxFlingVelocity;

  @override
  SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowScrollPhysics(
      parent: buildParent(ancestor),
      maxFlingVelocity: maxFlingVelocity,
    );
  }

  // This method scales the user scroll offset.
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Multiply the offset by a factor (0.3 in this case) to slow down the scrolling.
    return offset * 0.3;
  }

  // Define a maximum allowed fling velocity

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final tolerance = toleranceFor(position);
    // If the velocity is nearly zero, no ballistic simulation is needed.
    if (velocity.abs() < tolerance.velocity) return null;

    // Clamp the fling velocity to your maximum desired value.
    final double clampedVelocity = velocity.clamp(
      -maxFlingVelocity,
      maxFlingVelocity,
    );

    // Optionally, if the content is over scrolled (at the limits), defer to the parent's implementation.
    if ((position.pixels <= position.minScrollExtent && clampedVelocity < 0) ||
        (position.pixels >= position.maxScrollExtent && clampedVelocity > 0)) {
      return super.createBallisticSimulation(position, clampedVelocity);
    }

    // Create a simulation that uses the clamped velocity.
    // The ClampingScrollSimulation is useful for non-bouncing (Android-style) scroll behaviors.
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: clampedVelocity,
      tolerance: tolerance,
    );
  }
}
