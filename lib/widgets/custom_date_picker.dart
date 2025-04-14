part of 'widgets.dart';

class CustomDatePicker extends HookWidget {
  const CustomDatePicker({super.key, required this.lastDate, this.controller});

  final DateTime lastDate;
  final CustomDatePickerController? controller;

  @override
  Widget build(BuildContext context) {
    final effectiveController = useState(
      controller ?? CustomDatePickerController(),
    );

    final daysInMonth = useState(effectiveController.value.value.daysInMonth);
    final monthsCount = useState(12);
    final yearController = useWheelPickerController(
      min: 1900,
      max: lastDate.year,
      initialValue: effectiveController.value.value.year,
      debugLabel: 'yearController',
    );

    final monthController = useWheelPickerController(
      min: 1,
      max: monthsCount.value,
      initialValue: effectiveController.value.value.month,
      debugLabel: 'monthController',
    );

    final daysController = useWheelPickerController(
      min: 1,
      max: daysInMonth.value,
      initialValue: effectiveController.value.value.day,
      debugLabel: 'daysController',
    );

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
                effectiveController.value.value = DateTime(
                  yearController.value,
                  monthController.value,
                  daysController.value,
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
              onValueChanged: (value) {
                effectiveController.value.value = DateTime(
                  yearController.value,
                  monthController.value,
                  daysController.value,
                );
              },
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
                effectiveController.value.value = DateTime(
                  yearController.value,
                  monthController.value,
                  daysController.value,
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
    final year = yearController.value;
    final month = monthController.value;

    if (year == lastDate.year && month == lastDate.month) {
      if (daysInMonth.value != lastDate.day) {
        daysInMonth.value = lastDate.day;
      }
    } else {
      final newDaysInMonth = DateTime(year, month, 1).daysInMonth;
      if (daysInMonth.value != newDaysInMonth) {
        daysInMonth.value = newDaysInMonth;
      }
    }

    var newMonthsCount =
        yearController.value == lastDate.year ? lastDate.month : 12;

    if (newMonthsCount != monthsCount.value) {
      monthsCount.value = newMonthsCount;
    }
  }
}

extension _DateExt on DateTime {
  int get daysInMonth {
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

class CustomDatePickerController {
  CustomDatePickerController({DateTime? initialValue})
    : value = initialValue ?? DateTime(1900, 1, 1);

  DateTime value;
}

CustomDatePickerController useCustomDatePickerController({
  DateTime? initialValue,
  String debugLabel = 'useCustomDatePickerController',
  bool debug = false,
}) {
  final controller = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return CustomDatePickerController(initialValue: initialValue);
  }, []);

  return controller;
}
