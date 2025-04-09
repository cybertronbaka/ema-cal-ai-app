library;

import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'widget/unit_switcher.dart';

const _cmRange = (60, 250);
const _kgRange = (20, 400);
const _feetRange = (1, 9);
const _inchesRange = (0, 11);
const _lbsRange = (40, 800);

class SetHeightAndWeightView extends HookWidget {
  const SetHeightAndWeightView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    required this.initialHeight,
    required this.initialWeight,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final UnitLength initialHeight;
  final UnitWeight initialWeight;

  final void Function(UnitLength height, UnitWeight weight)? onBtnPressed;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final height = useValueNotifier<UnitLength>(initialHeight);
    final weight = useValueNotifier<UnitWeight>(initialWeight);
    final isMetric = useValueNotifier<bool>(true);

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
                                        initialHeight: initialHeight,
                                        initialWeight: initialWeight,
                                      )
                                      : _ImperialHeightAndWeightPicker(
                                        key: const Key('imperial-pickers'),
                                        initialHeight: initialHeight,
                                        initialWeight: initialWeight,
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
            child: CustomFilledButton(
              onPressed: () {
                onBtnPressed?.call(height.value, weight.value);
              },
              label: btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricHeightAndWeightPicker extends StatelessWidget {
  const _MetricHeightAndWeightPicker({
    super.key,
    required this.initialHeight,
    required this.initialWeight,
  });

  final UnitLength initialHeight;
  final UnitWeight initialWeight;

  @override
  Widget build(BuildContext context) {
    final cmController = CustomIntWheelPickerController(
      min: _cmRange.$1,
      max: _cmRange.$2,
      initialValue: initialHeight.cm.toInt(),
    );

    final kgController = CustomIntWheelPickerController(
      min: _kgRange.$1,
      max: _kgRange.$2,
      initialValue: initialWeight.kg.toInt(),
    );

    return _PickersLayout(
      heightSide: CustomIntWheelPicker(
        controller: cmController,
        builder: (context, value) => Text('$value cm'),
      ),
      weightSide: CustomIntWheelPicker(
        controller: kgController,
        builder: (context, value) => Text('$value kg'),
      ),
    );
  }
}

class _ImperialHeightAndWeightPicker extends StatelessWidget {
  const _ImperialHeightAndWeightPicker({
    super.key,
    required this.initialHeight,
    required this.initialWeight,
  });

  final UnitLength initialHeight;
  final UnitWeight initialWeight;
  @override
  Widget build(BuildContext context) {
    final feetController = CustomIntWheelPickerController(
      min: _feetRange.$1,
      max: _feetRange.$2,
      initialValue: initialHeight.feet.toInt(),
    );

    final inchesController = CustomIntWheelPickerController(
      min: _inchesRange.$1,
      max: _inchesRange.$2,
      initialValue: initialHeight.inches.toInt(),
    );

    final lbsController = CustomIntWheelPickerController(
      min: _lbsRange.$1,
      max: _lbsRange.$2,
      initialValue: initialWeight.lbs.toInt(),
    );

    return _PickersLayout(
      heightSide: Row(
        children: [
          Expanded(
            child: CustomIntWheelPicker(
              controller: feetController,
              builder: (context, value) => Text('$value ft'),
            ),
          ),
          Expanded(
            child: CustomIntWheelPicker(
              controller: inchesController,
              builder: (context, value) => Text('$value in'),
            ),
          ),
        ],
      ),
      weightSide: CustomIntWheelPicker(
        controller: lbsController,
        builder: (context, value) => Text('$value lb'),
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
