library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_dob_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditDobPage extends HookConsumerWidget {
  const EditDobPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: Text(
          'Edit Date of Birth',
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: SetDobView(
        initialValue: profile.dob,
        btnLabel: 'Done',
        onBtnPressed: (dob) async {
          await controller.setDob(context, dob);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
