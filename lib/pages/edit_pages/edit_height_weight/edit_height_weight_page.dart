library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_height_and_weight_view/set_height_and_weight_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditHeightWeightPage extends HookConsumerWidget {
  const EditHeightWeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: const Text('Edit Height & Weight'),
      ),
      body: SetHeightAndWeightView(
        isMetric: profile.isMetric,
        btnLabel: 'Done',
        initialHeight: profile.height,
        initialWeight: profile.weight,
        onBtnPressed: (isMetric, height, weight) async {
          await controller.setHeightWeight(context, isMetric, height, weight);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
