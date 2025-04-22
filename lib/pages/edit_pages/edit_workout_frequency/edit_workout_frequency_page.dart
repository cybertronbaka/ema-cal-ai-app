library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_workout_frequency_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditWorkoutFrequencyPage extends HookConsumerWidget {
  const EditWorkoutFrequencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: const Text('Edit Workout Frequency'),
      ),
      body: SetWorkoutFrequencyView(
        initialValue: profile.workoutFrequency,
        btnLabel: 'Done',
        onBtnPressed: (frequency) async {
          await controller.setWorkoutFrequency(context, frequency);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
