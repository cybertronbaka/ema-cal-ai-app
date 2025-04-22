library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_diet_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditDietPage extends HookConsumerWidget {
  const EditDietPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: Text('Edit Diet', style: TextTheme.of(context).titleMedium),
      ),
      body: SetDietView(
        initialValue: profile.diet,
        btnLabel: 'Done',
        onBtnPressed: (diet) async {
          await controller.setDiet(context, diet);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
