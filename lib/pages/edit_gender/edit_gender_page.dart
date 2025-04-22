library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_gender_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditGenderPage extends HookConsumerWidget {
  const EditGenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: const Text('Edit Gender'),
      ),
      body: SetGenderView(
        initialValue: profile.gender,
        btnLabel: 'Done',
        onBtnPressed: (dob) async {
          await controller.setGender(context, dob);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
