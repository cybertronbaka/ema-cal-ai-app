part of 'custom_camera.dart';

class _ZoomControl extends StatelessWidget {
  const _ZoomControl({
    required this.zoomSliderWidth,
    required this.zoomLevels,
    required this.controller,
    required this.gaugeController,
  });

  final LinearGaugeController gaugeController;
  final double zoomSliderWidth;
  final List<double> zoomLevels;
  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    if (zoomLevels.length < 2) {
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
        controller: gaugeController,
        debug: true,
        wrapperWidth: zoomSliderWidth,
        majorValues: zoomLevels,
        initialValue: 1,
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        majorLine: const GaugeLineConfig.major(color: Colors.white),
        minorLine: const GaugeLineConfig.minor(color: Colors.white),
        indicator: const GaugeLineConfig.indicator(color: Colors.blue),
        onValueChangedDelay: const Duration(milliseconds: 50),
        onValueChanged: (value) {
          controller.setZoomLevel(value);
        },
      ),
    );
  }
}
