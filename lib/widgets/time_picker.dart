part of 'widgets.dart';

class CustomTimePicker extends HookWidget {
  const CustomTimePicker({super.key, required this.initialValue});

  final TimeOfDay? initialValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final now = TimeOfDay.now();

    final hourController = useWheelPickerController(
      min: 1,
      max: 12,
      initialValue: initialValue?.hourOfPeriod ?? now.hourOfPeriod,
    );

    final minController = useWheelPickerController(
      min: 1,
      max: 59,
      initialValue: initialValue?.minute ?? now.minute,
    );

    final periodController = useWheelPickerController(
      min: 0,
      max: 1,
      initialValue: initialValue?.period.index ?? now.period.index,
    );

    return CustomDialog(
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Set Time', style: textTheme.titleMedium),
          SizedBox(
            height: 250,
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: WheelPicker(
                    controller: hourController,
                    builder: (context, value) {
                      return Text(value.toString().padLeft(2, '0'));
                    },
                  ),
                ),
                Expanded(
                  child: WheelPicker(
                    controller: minController,
                    builder: (context, value) {
                      return Text(value.toString().padLeft(2, '0'));
                    },
                  ),
                ),
                Expanded(
                  child: WheelPicker(
                    controller: periodController,
                    builder: (context, value) {
                      return Text(DayPeriod.values[value].name.toUpperCase());
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: CustomSmallOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Cancel',
                ),
              ),
              Expanded(
                child: CustomSmallFilledButton(
                  onPressed: () {
                    final term = periodController.value == 0 ? 0 : 12;

                    Navigator.of(context).pop(
                      TimeOfDay(
                        hour: hourController.value + term,
                        minute: minController.value,
                      ),
                    );
                  },
                  label: 'Apply',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  TimeOfDay? initialValue,
}) {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      return CustomTimePicker(initialValue: initialValue);
    },
  );
}
