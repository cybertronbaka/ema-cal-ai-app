import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/utils/time_utils.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SetMealTimeRemindersView extends HookWidget {
  const SetMealTimeRemindersView({
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
  final Future<void> Function(List<MealTimeReminder> value)? onBtnPressed;
  final List<MealTimeReminder>? initialValue;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final reminders = initialValue ?? [];

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
                    child: Column(
                      spacing: 16,
                      children: List.generate(reminders.length, (i) {
                        return _MealTimeReminderCard(
                          key: ValueKey(reminders[i]),
                          reminder: reminders[i],
                        );
                      }),
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
                await onBtnPressed?.call(reminders);
              },
              label: btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealTimeReminderCard extends HookWidget {
  const _MealTimeReminderCard({super.key, required this.reminder});

  final MealTimeReminder reminder;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final time = useState(reminder.timeOfDay);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        spacing: 16,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: FaIcon(FontAwesomeIcons.bowlFood, size: 30),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.label, style: textTheme.titleSmall),
                if (time.value != null)
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        TimeUtils.formatTimeOfDay(time.value!),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      if (time.value != null)
                        GestureDetector(
                          onTap: () {
                            time.value = null;
                            reminder.timeOfDay = null;
                          },
                          child: const FaIcon(FontAwesomeIcons.trash, size: 14),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: () async {
              if (!context.mounted) return;

              final result = await showCustomTimePicker(
                context: context,
                initialValue: time.value,
              );
              if (result == null) return;

              time.value = result;
              reminder.timeOfDay = result;
            },
            icon:
                time.value == null
                    ? const FaIcon(FontAwesomeIcons.plus, size: 18)
                    : const FaIcon(FontAwesomeIcons.pencil, size: 18),
          ),
        ],
      ),
    );
  }
}
