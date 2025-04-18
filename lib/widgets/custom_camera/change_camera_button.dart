part of 'custom_camera.dart';

class _ChangeCameraButton extends HookWidget {
  const _ChangeCameraButton({required this.size, required this.changeCamera});
  final double size;
  final Future<void> Function() changeCamera;
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.animateTo(1),
      onTapUp: (_) async {
        await animationController.animateBack(0);

        await changeCamera.call();
      },
      onTapCancel: () => animationController.animateBack(0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, _) {
          final rotationAngle = animationController.value * math.pi;

          return Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              shape: BoxShape.circle,
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Transform.rotate(
                angle: rotationAngle,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.repeat,
                    color: Colors.white,
                    size: size * 0.4,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
