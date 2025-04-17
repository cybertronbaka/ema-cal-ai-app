library;

import 'dart:math' as math;
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'change_camera_button.dart';
part 'confirm_image_button.dart';
part 'reset_image_button.dart';
part 'switch_preview_mode_button.dart';
part 'take_photo_button.dart';
part 'utils.dart';
part 'zoom_control.dart';

class CustomCamera extends StatefulWidget {
  const CustomCamera({super.key, this.afterImageSelected});

  /// if the function returns true, it means we will use the image
  final Future<bool> Function(BuildContext context, XFile)? afterImageSelected;

  @override
  CustomCameraState createState() => CustomCameraState();
}

class CustomCameraState extends State<CustomCamera>
    with SingleTickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late final LinearGaugeController _gaugeController;

  List<CameraDescription> _cameras = [];

  double _maxZoom = 1;
  double _minZoom = 1;

  late Future<void> _changeCameraFuture;

  List<double> _zoomLevels = [];
  double _currentZoom = 1;

  bool _isFullscreen = true;
  static const _animationDuration = Duration(milliseconds: 500);

  double _currentScale = 1.0;
  double _baseScale = 1.0;

  bool _imageCaptured = false;
  XFile? _image;

  late Size screenSize;
  late double cameraBtnSize;
  late double otherBtnsSize;
  late double zoomSliderWidth;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

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
    _gaugeController = LinearGaugeController(initialValue: _currentZoom);
    if (mounted) setState(() {});
  }

  Future<void> _setZoomRange() async {
    _maxZoom = await _controller.getMaxZoomLevel();
    _minZoom = await _controller.getMinZoomLevel();
    _zoomLevels = _getZoomLevels(_minZoom, _maxZoom);
    _currentZoom = 1;
    await _controller.setZoomLevel(_currentZoom);
    _baseScale = 1.0;
    _currentScale = 1.0;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _gaugeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    screenSize = MediaQuery.of(context).size;
    cameraBtnSize = screenSize.width * 0.2;
    otherBtnsSize = cameraBtnSize * 0.8;
    zoomSliderWidth = screenSize.width * 0.6;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: AnimatedPadding(
          duration: _animationDuration,
          padding: EdgeInsets.only(top: _isFullscreen ? 0 : viewPadding.top),
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var camera = _controller.value;
                final size = MediaQuery.of(context).size;
                var fsScale = size.aspectRatio * camera.aspectRatio;

                if (fsScale < 1) fsScale = 1 / fsScale;
                return Stack(
                  children: [
                    SizedBox.fromSize(size: screenSize),
                    Listener(
                      onPointerDown: (_) => _pointers++,
                      onPointerUp: (_) => _pointers--,
                      child: AnimatedScale(
                        scale: _isFullscreen ? fsScale : 1,
                        duration: _animationDuration,
                        child: AnimatedAlign(
                          alignment:
                              _isFullscreen
                                  ? Alignment.center
                                  : Alignment.topCenter,
                          duration: _animationDuration,
                          child:
                              _imageCaptured
                                  ? FutureBuilder(
                                    future: _image!.readAsBytes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.done) {
                                        return const SizedBox.shrink();
                                      }

                                      return AspectRatio(
                                        aspectRatio:
                                            1 / _controller.value.aspectRatio,
                                        child: Image.memory(
                                          snapshot.requireData,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  )
                                  : CameraPreview(
                                    _controller,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onScaleStart: _handleScaleStart,
                                          onScaleUpdate: _handleScaleUpdate,
                                          // onTapDown:
                                          //     (TapDownDetails details) =>
                                          //         onViewFinderTap(details, constraints),
                                        );
                                      },
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: 16,
                      top: _isFullscreen ? viewPadding.top : 0,
                      duration: _animationDuration,
                      child: BackButton(
                        color: Colors.white,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.grey.withAlpha(100),
                          ),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FutureBuilder<void>(
                          future: _changeCameraFuture,
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedSwitcher(
                                  duration: _animationDuration,
                                  child:
                                      _imageCaptured
                                          ? null
                                          : _ZoomControl(
                                            gaugeController: _gaugeController,
                                            zoomSliderWidth: zoomSliderWidth,
                                            zoomLevels: _zoomLevels,
                                            controller: _controller,
                                          ),
                                ),
                                AnimatedContainer(
                                  duration: _animationDuration,
                                  padding: const EdgeInsets.only(
                                    top: 60,
                                    bottom: 100,
                                    left: 16,
                                    right: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isFullscreen ? null : Colors.black,
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: _animationDuration,
                                    child:
                                        _imageCaptured
                                            ? _buildConfirmImageButton()
                                            : _buildImageCaptureControls(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
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
      ),
    );
  }

  Widget _buildConfirmImageButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ResetImageButton(
          size: otherBtnsSize,
          onResume: () {
            setState(() {
              _imageCaptured = false;
              _image = null;
            });
          },
        ),
        _ConfirmImageButton(
          controller: _controller,
          size: cameraBtnSize,
          afterConfirm: () async {
            if (!mounted) return;

            final confirmed = await widget.afterImageSelected?.call(
              context,
              _image!,
            );
            if (confirmed != null && !confirmed) return;

            if (mounted) Navigator.of(context).pop(_image);
          },
        ),
        SizedBox(width: otherBtnsSize),
      ],
    );
  }

  Widget _buildImageCaptureControls() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SwitchPreviewModeButton(
          size: otherBtnsSize,
          isFullscreen: _isFullscreen,
          switchMode: _toggleFullScreen,
        ),
        _TakePhotoButton(
          controller: _controller,
          size: cameraBtnSize,
          afterCapture: (image) {
            setState(() {
              _imageCaptured = true;
              _image = image;
            });
          },
        ),
        _ChangeCameraButton(
          size: otherBtnsSize,
          changeCamera: () async {
            if (_cameras.length <= 1) return;

            int currentIndex = _cameras.indexWhere(
              (cam) => cam == _controller.description,
            );
            int nextIndex = (currentIndex + 1) % _cameras.length;

            _changeCameraFuture = Future(() async {
              await _controller.setZoomLevel(_minZoom);
              await _controller.setDescription(_cameras[nextIndex]);
              await _setZoomRange();
            });
            if (mounted) setState(() {});
          },
        ),
      ],
    );
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale).clamp(_minZoom, _maxZoom);

    await _controller.setZoomLevel(_currentScale);
    _gaugeController.value = _currentScale;
    _gaugeController.scrollToValue(_currentScale);
  }
}
