part of 'widgets.dart';

class DottedCircleBorder extends StatelessWidget {
  const DottedCircleBorder({
    super.key,
    required this.radius,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.child,
  });

  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedCirclePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  _DottedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw dashed circle
    double angle = 0;
    while (angle < 2 * 3.141592653589793) {
      final x1 = center.dx + radius * math.cos(angle);
      final y1 = center.dy + radius * math.sin(angle);
      angle += dashWidth / radius;
      final x2 = center.dx + radius * math.cos(angle);
      final y2 = center.dy + radius * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
      angle += dashSpace / radius;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
