library;

import 'package:ema_cal_ai/config/app_config.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'widget/unit_switcher.dart';

class SetHeightAndWeightView extends HookWidget {
  const SetHeightAndWeightView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    required this.initialHeight,
    required this.initialWeight,
    required this.isMetric,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final UnitLength initialHeight;
  final UnitWeight initialWeight;
  final bool isMetric;

  final Future<void> Function(bool, UnitLength, UnitWeight)? onBtnPressed;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final height = useValueNotifier<UnitLength>(initialHeight);
    final weight = useValueNotifier<UnitWeight>(initialWeight);
    final isMetric = useValueNotifier<bool>(this.isMetric);

    return SafeArea(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || description != null)
            Padding(
              padding: _hPadding,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) Text(title!, style: textTheme.titleLarge),
                  if (description != null) Text(description!),
                ],
              ),
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight <= 0) return const SizedBox.shrink();
                return SingleChildScrollView(
                  padding: _hPadding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            _UnitSwitcher(isMetricNotifier: isMetric),
                            _PickersLayout(
                              heightSide: Center(
                                child: Text(
                                  'Height',
                                  style: textTheme.titleSmall,
                                ),
                              ),
                              weightSide: Center(
                                child: Text(
                                  'Weight',
                                  style: textTheme.titleSmall,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: ListenableBuilder(
                                listenable: isMetric,
                                builder: (_, _) {
                                  return isMetric.value
                                      ? _MetricHeightAndWeightPicker(
                                        key: const Key('metric-pickers'),
                                        initialHeight: height.value,
                                        initialWeight: weight.value,
                                        heightNotifier: height,
                                        weightNotifier: weight,
                                      )
                                      : _ImperialHeightAndWeightPicker(
                                        key: const Key('imperial-pickers'),
                                        initialHeight: initialHeight,
                                        initialWeight: initialWeight,
                                        heightNotifier: height,
                                        weightNotifier: weight,
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: _hPadding.copyWith(bottom: 16, top: 16),
            width: double.infinity,
            child: FutureCustomFilledButton(
              onPressed: () async {
                await onBtnPressed?.call(
                  isMetric.value,
                  height.value,
                  weight.value,
                );
              },
              label: btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricHeightAndWeightPicker extends HookWidget {
  const _MetricHeightAndWeightPicker({
    super.key,
    required this.initialHeight,
    required this.initialWeight,
    required this.heightNotifier,
    required this.weightNotifier,
  });

  final UnitLength initialHeight;
  final UnitWeight initialWeight;
  final ValueNotifier<UnitLength> heightNotifier;
  final ValueNotifier<UnitWeight> weightNotifier;

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();

    return _PickersLayout(
      heightSide: WheelPicker(
        min: appConfig.heightCmRange.start,
        max: appConfig.heightCmRange.end,
        initialValue: initialHeight.cm.toInt(),
        onValueChanged: (value) {
          heightNotifier.value = MetricLength(value.toDouble());
        },
        builder: (context, value) => Text('$value cm'),
      ),
      weightSide: WeightPicker(
        isMetric: true,
        initialWeight: initialWeight,
        onValueChanged: (value) {
          weightNotifier.value = value;
        },
      ),
    );
  }
}

class _ImperialHeightAndWeightPicker extends HookWidget {
  const _ImperialHeightAndWeightPicker({
    super.key,
    required this.initialHeight,
    required this.initialWeight,
    required this.heightNotifier,
    required this.weightNotifier,
  });

  final UnitLength initialHeight;
  final UnitWeight initialWeight;
  final ValueNotifier<UnitLength> heightNotifier;
  final ValueNotifier<UnitWeight> weightNotifier;

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig();
    final feetController = useWheelPickerController(
      min: appConfig.heightFeetRange.start,
      max: appConfig.heightFeetRange.end,
      initialValue: initialHeight.feet.toInt(),
    );

    final inchesController = useWheelPickerController(
      min: appConfig.heightInchesRange.start,
      max: appConfig.heightInchesRange.end,
      initialValue: initialHeight.inches.toInt(),
    );

    return _PickersLayout(
      heightSide: Row(
        children: [
          Expanded(
            child: WheelPicker(
              controller: feetController,
              builder: (context, value) => Text('$value ft'),
              onValueChanged: (value) {
                heightNotifier.value = ImperialLength(
                  value,
                  inchesController.value.toDouble(),
                );
              },
            ),
          ),
          Expanded(
            child: WheelPicker(
              controller: inchesController,
              onValueChanged: (value) {
                heightNotifier.value = ImperialLength(
                  feetController.value,
                  value.toDouble(),
                );
              },
              builder: (context, value) => Text('$value in'),
            ),
          ),
        ],
      ),
      weightSide: WeightPicker(
        initialWeight: initialWeight,
        isMetric: false,
        onValueChanged: (value) {
          weightNotifier.value = value;
        },
      ),
    );
  }
}

class _PickersLayout extends StatelessWidget {
  const _PickersLayout({required this.heightSide, required this.weightSide});

  final Widget heightSide;
  final Widget weightSide;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        const Expanded(child: SizedBox.shrink()),
        Expanded(flex: 2, child: heightSide),
        Expanded(flex: 2, child: weightSide),
        const Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}
