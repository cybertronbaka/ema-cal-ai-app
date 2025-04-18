library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/controllers/nutrition_planner_controller.dart';
import 'package:ema_cal_ai/controllers/onboarding_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/generate_nutrition_plan_view.dart';
import 'package:ema_cal_ai/widgets/views/set_diet_view.dart';
import 'package:ema_cal_ai/widgets/views/set_dob_view.dart';
import 'package:ema_cal_ai/widgets/views/set_gemini_api_key_view.dart';
import 'package:ema_cal_ai/widgets/views/set_height_and_weight_view/set_height_and_weight_view.dart';
import 'package:ema_cal_ai/widgets/views/set_meal_time_reminders_view.dart';
import 'package:ema_cal_ai/widgets/views/set_weight_goal_view.dart';
import 'package:ema_cal_ai/widgets/views/set_workout_frequency_view.dart';
import 'package:ema_cal_ai/widgets/views/set_gender_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/step_views.dart';
part 'widgets/stepper_app_bar.dart';
part 'widgets/stepper_body.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);
    final canMovePrevStep = ref.watch(nutritionPlannerCanGoBack);

    return DefaultTabController(
      length: OnboardingStep.values.length,
      initialIndex: controller.currentStep.index,
      child: Builder(
        builder:
            (context) => BackButtonListener(
              onBackButtonPressed: () async {
                if (!canMovePrevStep) return true;

                controller.moveToPrevStep(
                  context,
                  DefaultTabController.of(context),
                );
                return true;
              },
              child: Scaffold(
                appBar: const _StepperAppBar(key: Key('stepper-app-bar')),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final step in OnboardingStep.values)
                      _StepperBody(key: ValueKey(step), step: step),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
