library;

import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kgRange = (20, 400);
const _lbsRange = (40, 800);

class SetWeightGoalView extends HookWidget {
  const SetWeightGoalView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    required this.initialValue,
    required this.measurementSystem,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final UnitWeight initialValue;
  final MeasurementSystem measurementSystem;

  final void Function(UnitWeight)? onBtnPressed;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final goal = useValueNotifier<UnitWeight>(initialValue);
    final isMetric = measurementSystem == MeasurementSystem.metric;
    final range = isMetric ? _kgRange : _lbsRange;
    final initValue = (isMetric ? initialValue.kg : initialValue.lbs).toInt();
    final unit = isMetric ? 'kg' : 'lb';

    final wheelController = useWheelPickerController(
      min: range.$1,
      max: range.$2,
      initialValue: initValue,
    );

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
                        child: WheelPicker(
                          controller: wheelController,
                          builder: (context, value) => Text('$value $unit'),
                          onValueChanged: (value) {
                            goal.value =
                                isMetric
                                    ? MetricWeight(value.toDouble())
                                    : ImperialWeight(value.toDouble());
                          },
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
            child: CustomFilledButton(
              onPressed: () {
                onBtnPressed?.call(goal.value);
              },
              label: btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}
