part of 'widgets.dart';

class CustomIntWheelPickerController extends WheelPickerController {
  /// The initialValue is clamped between min and max
  factory CustomIntWheelPickerController({
    required int max,
    required int min,
    int initialValue = 0,
  }) {
    return CustomIntWheelPickerController._(
      itemCount: max - min + 1,
      max: max,
      min: min,
      initialIndex: initialValue.clamp(min, max) - min,
    );
  }

  CustomIntWheelPickerController._({
    required this.max,
    required this.min,
    required super.itemCount,
    super.initialIndex,
  }) : _value = initialIndex + min;

  final int min;
  final int max;
  int _value;

  // ignore: unnecessary_getters_setters
  int get value => _value;

  set value(int val) => _value = val;
}

class CustomIntWheelPicker extends StatelessWidget {
  const CustomIntWheelPicker({
    super.key,
    required this.controller,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    this.looping = false,
    this.onValueChanged,
    this.style,
    this.builder,
  });

  final CustomIntWheelPickerController controller;
  final TextStyle textStyle;
  final bool looping;
  final void Function(int value)? onValueChanged;
  final WheelPickerStyle? style;
  final Widget Function(BuildContext context, int value)? builder;

  @override
  Widget build(BuildContext context) {
    return WheelPicker(
      builder: (context, index) {
        if (builder != null) {
          return DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.merge(textStyle),
            child: builder!.call(context, controller.min + index),
          );
        }
        return Text('$index', style: textStyle);
      },
      controller: controller,
      looping: looping,
      onIndexChanged: (index, _) {
        final value = controller.min + index;
        controller._value = value;
        onValueChanged?.call(value);
      },
      style:
          style ??
          WheelPickerStyle(
            itemExtent: textStyle.fontSize! * textStyle.height!,
            squeeze: 1,
            diameterRatio: 1,
            surroundingOpacity: .25,
            magnification: 1.25,
            shiftAnimationStyle: const WheelShiftAnimationStyle(
              duration: Duration(milliseconds: 300),
              curve: Curves.decelerate,
            ),
          ),
    );
  }
}
