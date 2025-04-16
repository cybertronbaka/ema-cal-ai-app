part of '../widgets.dart';

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
