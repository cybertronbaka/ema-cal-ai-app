part of 'custom_camera.dart';

class _ConfirmImageButton extends HookWidget {
  const _ConfirmImageButton({
    required this.size,
    required this.controller,
    required this.afterConfirm,
  });

  final CameraController controller;
  final double size;
  final Function() afterConfirm;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.animateTo(1),
      onTapUp: (_) {
        animationController.animateBack(0);
        afterConfirm();
      },
      onTapCancel: () => animationController.animateBack(0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, _) {
          final value = animationController.value;
          final padding = (1 - value) * 7;
          final iconSize = lerpDouble(size * 0.4, size * 0.6, value);
          final iconColor = Color.lerp(Colors.black, Colors.white, value);

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
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == 1 ? Colors.amber : Colors.white,
              ),
              child: Icon(
                Icons.check_rounded,
                size: iconSize,
                color: iconColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
