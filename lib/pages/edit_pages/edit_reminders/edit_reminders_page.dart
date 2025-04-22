library;

import 'package:ema_cal_ai/controllers/meal_time_reminders_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_meal_time_reminders_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditRemindersPage extends HookConsumerWidget {
  const EditRemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(mealTimeRemindersProvider);
    final controller = ref.watch(mealTimeRemindersControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: Text('Edit Reminders', style: TextTheme.of(context).titleMedium),
      ),
      body: SetMealTimeRemindersView(
        initialValue: reminders,
        btnLabel: 'Done',
        onBtnPressed: (reminders) async {
          await controller.setReminders(context, reminders);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
