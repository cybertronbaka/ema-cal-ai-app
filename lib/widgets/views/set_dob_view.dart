import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

enum Months {
  jan('January'),
  feb('February'),
  mar('March'),
  apr('April'),
  may('May'),
  jun('June'),
  jul('July'),
  aug('August'),
  sep('September'),
  oct('October'),
  nov('November'),
  dec('December');

  const Months(this.fullName);
  final String fullName;
}

class SetDobView extends HookWidget {
  const SetDobView({
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
  final void Function(DateTime value)? onBtnPressed;
  final DateTime? initialValue;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final now = DateTime.now();
    final daysInMonth = useState(initialValue?.daysInMonth ?? 31);
    final monthsCount = useState(12);
    final yearController = useWheelPickerController(
      min: 1900,
      max: now.year,
      initialValue: initialValue?.year ?? now.year - 18,
      debugLabel: 'yearController',
    );

    final monthController = useWheelPickerController(
      min: 1,
      max: monthsCount.value,
      initialValue: initialValue?.month ?? 1,
      debugLabel: 'monthController',
    );

    final daysController = useWheelPickerController(
      min: 1,
      max: daysInMonth.value,
      initialValue: initialValue?.day ?? 1,
      debugLabel: 'daysController',
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
                      child: _buildPickers(
                        monthController,
                        yearController,
                        daysInMonth,
                        monthsCount,
                        daysController,
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
              enabled: true,
              onPressed: () {
                onBtnPressed?.call(
                  DateTime(
                    yearController.value,
                    monthController.value,
                    daysController.value,
                  ),
                );
              },
              label: btnLabel,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildPickers(
    WheelPickerController monthController,
    WheelPickerController yearController,
    ValueNotifier<int> daysInMonth,
    ValueNotifier<int> monthsCount,
    WheelPickerController daysController,
  ) {
    return SizedBox(
      height: 250,
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: WheelPicker(
              controller: monthController,
              onValueChanged: (value) {
                _adjustLimits(
                  yearController,
                  monthController,
                  daysInMonth,
                  monthsCount,
                );
              },
              builder: (context, value) {
                return Text(DateFormat('MMMM').format(DateTime(1900, value)));
              },
            ),
          ),
          Expanded(
            child: WheelPicker(
              controller: daysController,
              builder: (context, value) {
                return Text(DateFormat('DD').format(DateTime(1900, 1, value)));
              },
            ),
          ),
          Expanded(
            child: WheelPicker(
              controller: yearController,
              onValueChanged: (value) {
                _adjustLimits(
                  yearController,
                  monthController,
                  daysInMonth,
                  monthsCount,
                );
              },
              builder: (context, value) {
                return Text(DateFormat('yyy').format(DateTime(value)));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _adjustLimits(
    WheelPickerController yearController,
    WheelPickerController monthController,
    ValueNotifier<int> daysInMonth,
    ValueNotifier<int> monthsCount,
  ) {
    final now = DateTime.now();
    final year = yearController.value;
    final month = monthController.value;

    if (year == now.year && month == now.month) {
      if (daysInMonth.value != now.day) {
        daysInMonth.value = now.day;
      }
    } else {
      final newDaysInMonth = DateTime(year, month, 1).daysInMonth;
      if (daysInMonth.value != newDaysInMonth) {
        daysInMonth.value = newDaysInMonth;
      }
    }

    final newMonthsCount = yearController.value == now.year ? now.month : 12;

    if (newMonthsCount != monthsCount.value) {
      monthsCount.value = newMonthsCount;
    }
  }
}

extension _DateExt on DateTime {
  int get daysInMonth {
    final now = DateTime.now();
    if (month == now.month && year == now.year) {
      return now.day;
    }

    // Handle February separately to account for leap years
    if (month == 2) {
      // Leap year calculation:
      // 1. If year is divisible by 400 => leap year
      // 2. Else if year is divisible by 100 => not leap year
      // 3. Else if year is divisible by 4 => leap year
      // 4. Else => not leap year
      return ((year % 400 == 0) || (year % 100 != 0 && year % 4 == 0))
          ? 29
          : 28;
    }
    // For all other months, use the standard approach
    return DateTime(year, month + 1, 0).day;
  }
}
