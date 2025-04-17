part of 'custom_camera.dart';

class _TakePhotoButton extends HookWidget {
  const _TakePhotoButton({
    required this.size,
    required this.controller,
    required this.afterCapture,
  });

  final CameraController controller;
  final double size;
  final Function(XFile) afterCapture;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.animateTo(1),
      onTapUp: (_) {
        animationController.animateBack(0);
        controller.takePicture().then((value) {
          afterCapture(value);
        });
      },
      onTapCancel: () => animationController.animateBack(0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, _) {
          final value = animationController.value;
          final padding = (1 - value) * 7;

          return Container(
            padding: EdgeInsets.all(padding),
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                color: value == 1 ? Colors.amber : Colors.white,
                width: 3,
              ),
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == 1 ? Colors.amber : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
