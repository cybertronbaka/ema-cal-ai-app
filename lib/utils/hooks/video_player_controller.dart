import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController useAssetVideoPlayerController({
  required String source,
  String? package,
  Future<ClosedCaptionFile>? closedCaptionFile,
  VideoPlayerOptions? videoPlayerOptions,
  String debugLabel = 'useAssetVideoPlayerController',
  bool debug = false,
}) {
  final controller = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return VideoPlayerController.asset(
      source,
      package: package,
      closedCaptionFile: closedCaptionFile,
      videoPlayerOptions: videoPlayerOptions,
    );
  }, [source, package, closedCaptionFile, videoPlayerOptions]);

  useEffect(() => controller.dispose, []);

  return controller;
}
