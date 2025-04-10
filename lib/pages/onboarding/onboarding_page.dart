library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/controllers/onboarding_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/widgets/views/set_dob_view.dart';
import 'package:ema_cal_ai/widgets/views/set_height_and_weight_view/set_height_and_weight_view.dart';
import 'package:ema_cal_ai/widgets/views/set_weight_goal_view.dart';
import 'package:ema_cal_ai/widgets/views/set_workout_frequency_view.dart';
import 'package:ema_cal_ai/widgets/views/set_gender_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/step_views.dart';
part 'widgets/stepper_app_bar.dart';
part 'widgets/stepper_body.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching onboardingControllerProvider here to not let it auto dispose
    ref.watch(onboardingControllerProvider);

    return DefaultTabController(
      length: OnboardingStep.values.length,
      child: Scaffold(
        appBar: const _StepperAppBar(key: Key('stepper-app-bar')),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final step in OnboardingStep.values)
              _StepperBody(key: ValueKey(step), step: step),
          ],
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
