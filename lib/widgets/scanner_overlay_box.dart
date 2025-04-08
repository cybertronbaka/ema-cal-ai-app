part of 'widgets.dart';

class ScannerOverlayBox extends HookWidget {
  const ScannerOverlayBox({
    super.key,
    this.borderColor = Colors.white,
    this.borderWidth = 5.0,
    this.edgeLength = 40.0,
    this.dimension = 200,
    this.isAnimated = false,
  });

  final Color borderColor;
  final double borderWidth;
  final double edgeLength;
  final double dimension;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      initialValue: 0.5,
      duration: const Duration(seconds: 4),
    );
    useEffect(() {
      if (isAnimated) animationController.repeat(reverse: true);

      return null;
    }, [isAnimated]);

    return Center(
      child: Stack(
        children: [
          SizedBox(width: dimension, height: dimension),

          for (var pos in _CornerPosition.values)
            Positioned(
              top: pos.top,
              left: pos.left,
              right: pos.right,
              bottom: pos.bottom,
              child: _Corner(
                borderWidth: borderWidth,
                edgeLength: edgeLength,
                borderColor: borderColor,
                position: pos,
              ),
            ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              final borderWidthX2 = borderWidth * 2;
              final height = (dimension - dimension / 8) - borderWidthX2;
              return Positioned(
                top: (animationController.value * height) + borderWidth,
                left: borderWidth,
                child: Container(
                  height: dimension / 8,
                  width: dimension - borderWidthX2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xD0FFFFFF), Colors.transparent],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

enum _CornerPosition {
  topLeft((0, null, null, 0)),
  topRight((0, 0, null, null)),
  bottomLeft((null, null, 0, 0)),
  bottomRight((null, 0, 0, null));

  const _CornerPosition(this._position);

  /// position is given as follows (top, right, bottom, left);
  final (double?, double?, double?, double?) _position;

  double? get top => _position.$1;
  double? get right => _position.$2;
  double? get bottom => _position.$3;
  double? get left => _position.$4;
}

class _Corner extends StatelessWidget {
  const _Corner({
    required this.borderWidth,
    required this.edgeLength,
    required this.borderColor,
    required this.position,
  });

  final double borderWidth;
  final double edgeLength;
  final Color borderColor;
  final _CornerPosition position;

  @override
  Widget build(BuildContext context) {
    final dimension = edgeLength - borderWidth;

    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        border: Border(
          top:
              position.top != null
                  ? BorderSide(width: borderWidth, color: borderColor)
                  : BorderSide.none,
          bottom:
              position.bottom != null
                  ? BorderSide(width: borderWidth, color: borderColor)
                  : BorderSide.none,
          left:
              position.left != null
                  ? BorderSide(width: borderWidth, color: borderColor)
                  : BorderSide.none,
          right:
              position.right != null
                  ? BorderSide(width: borderWidth, color: borderColor)
                  : BorderSide.none,
        ),
      ),
    );
  }
}
