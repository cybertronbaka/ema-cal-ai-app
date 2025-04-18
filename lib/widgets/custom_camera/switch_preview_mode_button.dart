part of 'custom_camera.dart';

class _SwitchPreviewModeButton extends HookWidget {
  const _SwitchPreviewModeButton({
    required this.size,
    required this.switchMode,
    required this.isFullscreen,
  });
  final double size;
  final void Function() switchMode;
  final bool isFullscreen;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.animateTo(1),
      onTapUp: (_) async {
        await animationController.animateBack(0);

        switchMode.call();
      },
      onTapCancel: () => animationController.animateBack(0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, _) {
          final scale = 1 + animationController.value * 0.5;

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
              child: Transform.scale(
                scale: scale,
                child: Center(
                  child: FaIcon(
                    isFullscreen
                        ? FontAwesomeIcons.compress
                        : FontAwesomeIcons.expand,
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
