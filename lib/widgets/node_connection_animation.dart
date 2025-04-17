part of 'widgets.dart';

class NodeConnectionAnimation extends HookWidget {
  const NodeConnectionAnimation({
    super.key,
    this.nodeCount = 10,
    this.connectionMaxDistance = 100,
    this.connectionMinDistance = 50,
    this.nodeRadius = 10,
    this.connectionColor = Colors.white,
    this.nodeColor = Colors.white,
    this.connectionWidth = 4,
    this.size = const Size(400, 400),
  });

  final int nodeCount;
  final double connectionMaxDistance;
  final double connectionMinDistance;
  final double nodeRadius;
  final Color nodeColor;
  final Color connectionColor;
  final double connectionWidth;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 16),
    )..repeat();

    final nodes = useState<List<_Node>>(_initializeNodes());
    final connections = useState<List<_Connection>>([]);
    final random = useMemoized(() => math.Random());

    useEffect(() {
      void updateAnimation() {
        _updateNodePositions(nodes.value);
        _updateConnections(nodes.value, connections.value, random);
        nodes.value = [...nodes.value]; // Trigger state update
        connections.value = [...connections.value];
      }

      animationController.addListener(updateAnimation);
      return () => animationController.removeListener(updateAnimation);
    }, []);

    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: _NodeConnectionPainter(
          nodes: nodes.value,
          connections: connections.value,
          nodeRadius: nodeRadius,
          connectionColor: connectionColor,
          connectionWidth: connectionWidth,
          nodeColor: nodeColor,
        ),
      ),
    );
  }

  List<_Node> _initializeNodes() {
    final random = math.Random();
    return List.generate(
      nodeCount,
      (index) => _Node(
        position: Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        velocity: Offset(
          (random.nextDouble() - 0.5) * 2,
          (random.nextDouble() - 0.5) * 2,
        ),
      ),
    );
  }

  void _updateNodePositions(List<_Node> nodes) {
    for (final node in nodes) {
      if (node.position.dx < 0 || node.position.dx > size.width) {
        node.velocity = Offset(-node.velocity.dx, node.velocity.dy);
      }
      if (node.position.dy < 0 || node.position.dy > size.height) {
        node.velocity = Offset(node.velocity.dx, -node.velocity.dy);
      }
      node.position += node.velocity;
    }
  }

  void _updateConnections(
    List<_Node> nodes,
    List<_Connection> connections,
    math.Random random,
  ) {
    // Fade existing connections
    for (var c in connections) {
      c.strength *= 0.95;
    }

    // Find new connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i].position - nodes[j].position).distance;
        if (distance < connectionMaxDistance &&
            distance > connectionMinDistance) {
          final existing = connections.firstWhere(
            (c) =>
                (c.a == nodes[i] && c.b == nodes[j]) ||
                (c.a == nodes[j] && c.b == nodes[i]),
            orElse: () => _Connection(nodes[i], nodes[j], 0),
          );

          if (existing.strength < 1.0) {
            existing.strength = (1.0 -
                    (distance - connectionMinDistance) /
                        (connectionMaxDistance - connectionMinDistance))
                .clamp(0.0, 1.0);
          }

          if (!connections.contains(existing)) {
            connections.add(existing);
          }
        }
      }
    }

    // Remove weak connections
    connections.removeWhere((c) => c.strength < 0.1);
  }
}

class _NodeConnectionPainter extends CustomPainter {
  _NodeConnectionPainter({
    required this.nodes,
    required this.connections,
    required this.nodeRadius,
    this.nodeColor = Colors.white,
    this.connectionColor = Colors.white,
    this.connectionWidth = 8,
  });
  final List<_Node> nodes;
  final List<_Connection> connections;
  final double nodeRadius;
  final Color nodeColor;
  final Color connectionColor;
  final double connectionWidth;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections with smooth transitions
    for (final connection in connections) {
      final paint =
          Paint()
            ..color = connectionColor
            ..strokeWidth = connectionWidth * connection.strength
            ..strokeCap = StrokeCap.round;

      canvas.drawLine(connection.a.position, connection.b.position, paint);
    }

    // Draw nodes
    final nodePaint =
        Paint()
          ..color = nodeColor
          ..style = PaintingStyle.fill;

    for (final node in nodes) {
      canvas.drawCircle(node.position, nodeRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Node {
  _Node({required this.position, required this.velocity});

  Offset position;
  Offset velocity;
}

class _Connection {
  _Connection(this.a, this.b, this.strength);

  final _Node a;
  final _Node b;
  double strength;
}
