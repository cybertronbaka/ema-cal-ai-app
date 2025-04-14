import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetGenderView extends HookWidget {
  const SetGenderView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    this.initialValue,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final void Function(Gender value)? onBtnPressed;
  final Gender? initialValue;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final selected = useValueNotifier(initialValue);

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
                      child: OptionsList<Gender>(
                        options: Gender.values,
                        initialValue: selected.value,
                        onSelected: (value) => selected.value = value,
                        builder: (value) => Text(value.name),
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
            child: ListenableBuilder(
              listenable: selected,
              builder: (context, child) {
                return CustomFilledButton(
                  enabled: selected.value != null,
                  onPressed: () {
                    if (selected.value == null) return;

                    onBtnPressed?.call(selected.value!);
                  },
                  label: btnLabel,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
