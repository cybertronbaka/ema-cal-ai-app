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
                child: Icon(
                  Icons.flip_camera_android_outlined,
                  size: size * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
