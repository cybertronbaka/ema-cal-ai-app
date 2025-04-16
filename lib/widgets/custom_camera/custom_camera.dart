import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomCamera extends StatefulWidget {
  const CustomCamera({super.key});

  @override
  CustomCameraState createState() => CustomCameraState();
}

class CustomCameraState extends State<CustomCamera>
    with SingleTickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription> _cameras = [];
  double _maxZoom = 1;
  double _minZoom = 1;
  late Future<void> _changeCameraFuture;
  List<double> _zoomLevels = [];
  double _currentZoom = 1;
  bool _isPreviewFullScreen = true;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initialize();
  }

  Future<void> _initialize() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _controller.initialize();
    _changeCameraFuture = _setZoomRange();
    await _changeCameraFuture;
    if (mounted) setState(() {});
  }

  Future<void> _setZoomRange() async {
    _maxZoom = await _controller.getMaxZoomLevel();
    _minZoom = await _controller.getMinZoomLevel();
    _zoomLevels = _getZoomLevels(_minZoom, _maxZoom);
    _currentZoom = 1;
    await _controller.setZoomLevel(_currentZoom);
    print('max zoom is ${_maxZoom}');
    print('_minZoom is ${_minZoom}');
    print('_zoomLevels is ${_zoomLevels}');
    print('_currentZoom is ${_currentZoom}');
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cameraBtnSize = screenSize.width * 0.2;
    final cameraBtnRadius = cameraBtnSize / 2;
    final switchCameraBtnSize = cameraBtnSize * 0.8;
    final switchCameraBtnRadius = switchCameraBtnSize / 2;
    final btnSizeDiff = cameraBtnSize - switchCameraBtnSize;
    final cameraBtnBottomY = screenSize.height * 0.1;
    final zoomSliderWidth = screenSize.width * 0.6;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: !_isPreviewFullScreen,
        bottom: !_isPreviewFullScreen,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var camera = _controller.value;
              final size = MediaQuery.of(context).size;
              var scale = size.aspectRatio * camera.aspectRatio;

              if (scale < 1) scale = 1 / scale;
              return Stack(
                children: [
                  SizedBox.fromSize(size: screenSize),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child:
                        _isPreviewFullScreen
                            ? Transform.scale(
                              scale: scale,
                              child: Center(child: CameraPreview(_controller)),
                            )
                            : Align(
                              alignment: Alignment.topCenter,
                              child: CameraPreview(_controller),
                            ),
                  ),

                  Positioned(
                    bottom: cameraBtnBottomY,
                    left: (screenSize.width / 2) - cameraBtnRadius,
                    child: FutureBuilder<void>(
                      future: _changeCameraFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SizedBox.shrink();
                        }

                        return _TakePhotoButton(
                          controller: _controller,
                          size: cameraBtnSize,
                        );
                      },
                    ),
                  ),

                  Positioned(
                    bottom: cameraBtnBottomY + (btnSizeDiff / 2),
                    right: (screenSize.width / 5) - switchCameraBtnRadius,
                    child: FutureBuilder<void>(
                      future: _changeCameraFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SizedBox.shrink();
                        }

                        return _ChangeCameraButton(
                          size: switchCameraBtnSize,
                          changeCamera: () async {
                            if (_cameras.length <= 1) return;

                            int currentIndex = _cameras.indexWhere(
                              (cam) => cam == _controller.description,
                            );
                            int nextIndex =
                                (currentIndex + 1) % _cameras.length;

                            _changeCameraFuture = Future(() async {
                              await _controller.setDescription(
                                _cameras[nextIndex],
                              );
                              await _setZoomRange();
                            });
                            if (mounted) setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: cameraBtnBottomY + (btnSizeDiff / 2),
                    left: (screenSize.width / 5) - switchCameraBtnRadius,
                    child: FutureBuilder<void>(
                      future: _changeCameraFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SizedBox.shrink();
                        }

                        return _SwitchPreviewModeButton(
                          size: switchCameraBtnSize,
                          isFullscreen: _isPreviewFullScreen,
                          switchMode: () {
                            setState(() {
                              _isPreviewFullScreen = !_isPreviewFullScreen;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: cameraBtnBottomY + (cameraBtnSize * 1.75),
                    left: (screenSize.width - zoomSliderWidth) / 2,
                    child: FutureBuilder<void>(
                      future: _changeCameraFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SizedBox.shrink();
                        }

                        if (_zoomLevels.length < 2) {
                          return const SizedBox.shrink();
                        }

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black.withAlpha(100),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: LinearGauge(
                            debug: true,
                            wrapperWidth: zoomSliderWidth,
                            majorValues: _zoomLevels,
                            initialValue: 1,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            majorLine: const GaugeLineConfig.major(
                              color: Colors.white,
                            ),
                            minorLine: const GaugeLineConfig.minor(
                              color: Colors.white,
                            ),
                            indicator: const GaugeLineConfig.indicator(
                              color: Colors.blue,
                            ),
                            onValueChangedDelay: const Duration(
                              milliseconds: 50,
                            ),
                            onValueChanged: (value) {
                              _controller.setZoomLevel(value);
                              if (_zoomLevels.contains(value)) {
                                HapticFeedback.heavyImpact();
                              } else {
                                HapticFeedback.heavyImpact();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class _TakePhotoButton extends HookWidget {
  const _TakePhotoButton({required this.size, required this.controller});
  final CameraController controller;
  final double size;
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.animateTo(1),
      onTapUp: (_) {
        animationController.animateBack(0);
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
                  size: size - 20,
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
    final isFullscreen = useState(this.isFullscreen);

    useEffect(() {
      if (animationController.isAnimating) return null;

      print('is animation');
      isFullscreen.value = this.isFullscreen;
      return null;
    }, [this.isFullscreen, animationController]);

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
                child: Icon(
                  isFullscreen.value
                      ? Icons.fullscreen_exit_rounded
                      : Icons.fullscreen_rounded,
                  size: size - 20,
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

List<double> _getZoomLevels(double min, double max) {
  // Base set of zoom levels
  final List<double> baseLevels = [0.5, 1, 2, 5, 10, 30, 100];

  // If min and max are the same, return null
  if (min == max) return [min];

  // Ensure min is less than max, swap if needed
  if (min > max) {
    final temp = min;
    min = max;
    max = temp;
  }

  // Filter base levels that fall within the min-max range
  var levels =
      baseLevels.where((level) => level >= min && level <= max).toList();

  // If the filtered list is not empty, return it
  if (levels.isNotEmpty) return levels;

  // For cases where min/max are not in base levels, generate smart levels
  levels = [];
  double current = min;

  // Determine the appropriate increment based on the max value
  double increment =
      max <= 1
          ? 0.5
          : max <= 5
          ? 1
          : max <= 10
          ? 2
          : max <= 30
          ? 5
          : max <= 100
          ? 10
          : 20;

  // Generate levels with appropriate increments
  while (current <= max) {
    levels.add(current);

    // For values less than 1, use 0.5 increments
    if (current < 1) {
      current += 0.5;
    }
    // For other values, use the determined increment
    else {
      // Round to nearest whole number for cleaner values
      current = (current + increment).roundToDouble();

      // Special cases to match the base pattern
      if (current > 2 && current < 5) current = 5;
      if (current > 5 && current < 10) current = 10;
      if (current > 10 && current < 30) current = 30;
      if (current > 30 && current < 100) current = 100;
    }

    // Ensure we don't exceed max
    if (current > max) {
      levels.add(max);
      break;
    }
  }

  return levels;
}
