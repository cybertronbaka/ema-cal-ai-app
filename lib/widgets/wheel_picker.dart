part of 'widgets.dart';

class WheelPicker extends HookWidget {
  const WheelPicker({
    super.key,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    this.onValueChanged,
    this.builder,
    this.controller,
    // Only required if controller is null
    this.initialValue,
    this.min,
    this.max,
  });

  final TextStyle textStyle;
  final void Function(int value)? onValueChanged;
  final Widget Function(BuildContext context, int value)? builder;
  final WheelPickerController? controller;
  final int? min;
  final int? max;
  final int? initialValue;

  static const _magnification = 1.5;

  @override
  Widget build(BuildContext context) {
    // Use controller values if available, otherwise use widget parameters

    final effectiveController =
        controller ??
        useWheelPickerController(
          min: min!,
          max: max!,
          initialValue: initialValue,
        );

    // Effect to handle changes in controller values
    useEffect(() {
      effectiveController.adjustValue();

      return null;
    }, [controller?.min, controller?.max, min, max, initialValue]);

    final itemExtent = textStyle.fontSize! * textStyle.height!;
    final magnifierHeight = itemExtent * _magnification;
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              height: magnifierHeight * 1.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(magnifierHeight * 0.2),
              ),
            ),
          ),
        ),
        ListWheelScrollView.useDelegate(
          controller: effectiveController._scrollController,
          itemExtent: itemExtent,
          diameterRatio: 1,
          overAndUnderCenterOpacity: 0.25,
          magnification: _magnification,
          squeeze: 0.8,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            final value = effectiveController.min + index;
            effectiveController.value = value;
            onValueChanged?.call(value);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: effectiveController.itemCount,
            builder: (context, index) {
              final value = effectiveController.min + index;

              if (builder != null) {
                return DefaultTextStyle(
                  style: DefaultTextStyle.of(context).style.merge(textStyle),
                  child: builder!.call(context, value),
                );
              }

              return Text(value.toString(), style: textStyle);
            },
          ),
        ),
      ],
    );
  }
}

class WheelPickerController {
  WheelPickerController({
    required this.min,
    required this.max,
    this.initialValue,
    this.debug = false,
    this.debugLabel = 'WheelPickerController',
  }) {
    if (debug) debugPrint('$debugLabel: Initializing');
    _calculateCountAndIndex();

    value = (initialValue ?? min).clamp(min, max);
    if (debug) debugPrint('$debugLabel: Set value to $value');
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  void _calculateCountAndIndex() {
    itemCount = max - min + 1;
    initialIndex = (initialValue ?? min).clamp(min, max) - min;
  }

  int min;
  int max;
  int? initialValue;

  late int itemCount;
  late int value;
  late int initialIndex;

  late final FixedExtentScrollController _scrollController;
  String debugLabel;
  bool debug;

  void dispose() {
    _scrollController.dispose();
  }

  void jumpToValue(int value) {
    final index = value.clamp(min, max) - min;
    _scrollController.jumpToItem(index);
  }

  void adjustValue() {
    if (!_scrollController.hasClients) return;

    final currentIndex = _scrollController.selectedItem;
    final expectedIndex = _scrollController.selectedItem.clamp(0, itemCount);
    if (currentIndex != expectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateToItem(
          expectedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void animateToValue(
    int value, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
  }) {
    final index = value.clamp(min, max) - min;
    _scrollController.animateToItem(index, duration: duration, curve: curve);
  }
}

WheelPickerController useWheelPickerController({
  required int min,
  required int max,
  int? initialValue,
  String debugLabel = 'useWheelPickerController',
  bool debug = false,
}) {
  final controller = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return WheelPickerController(
      min: min,
      max: max,
      initialValue: initialValue,
      debugLabel: debugLabel,
    );
  }, []);

  // Update controller when dependencies change
  useEffect(() {
    final minAdjusted = controller.min != min;
    final maxAdjusted = controller.max != max;
    final initialValueAdjusted = controller.initialValue != initialValue;

    if (minAdjusted) controller.min = min;
    if (maxAdjusted) controller.max = max;
    if (initialValueAdjusted) controller.initialValue = initialValue;
    if (minAdjusted || maxAdjusted || initialValueAdjusted) {
      if (debug) {
        debugPrint('$debugLabel: Constraints were adjusted so updating');
      }
      controller._calculateCountAndIndex();
      controller.adjustValue();
    }
    return null;
  }, [min, max, initialValue]);

  // Dispose controller when hook is disposed
  useEffect(() => controller.dispose, []);

  return controller;
}
