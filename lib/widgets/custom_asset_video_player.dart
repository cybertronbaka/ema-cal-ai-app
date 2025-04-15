part of 'widgets.dart';

class CustomAssetVideoPlayer extends HookWidget {
  const CustomAssetVideoPlayer({
    super.key,
    this.height = 350,
    required this.source,
  });
  final double height;
  final String source;

  @override
  Widget build(BuildContext context) {
    final isInitialized = useState(false);
    final controller = useAssetVideoPlayerController(source: source);

    useInitHook(() {
      controller.initialize().then((_) {
        isInitialized.value = true;
      });
    }, []);

    if (!isInitialized.value) {
      return Stack(
        children: [
          Container(
            height: height,
            width: double.infinity,
            color: Colors.black87,
          ),
          const Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox.square(
                dimension: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          color: Colors.black87,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: height - 10,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controller),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.value.isPlaying) {
                          await controller.pause();
                          return;
                        }

                        await controller.play();
                      },
                      child: ListenableBuilder(
                        listenable: controller,
                        builder: (_, _) {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            color:
                                !controller.value.isPlaying
                                    ? AppColors.darkGrey
                                    : Colors.transparent,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: ListenableBuilder(
                        listenable: controller,
                        builder: (_, _) {
                          if (controller.value.isPlaying) {
                            return const SizedBox.shrink();
                          }

                          return const Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.white,
                            size: 60,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(playedColor: Colors.amber),
            ),
          ),
        ),
      ],
    );
  }
}
