import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingControllerProvider = Provider.autoDispose(
  (ref) => OnboardingController(ref),
);

class OnboardingController {
  OnboardingController(this.ref);

  Ref ref;

  OnboardingStep currentStep = OnboardingStep.gender;

  Gender? gender;

  WorkoutFrequency? workoutFrequency;

  MeasurementSystem measurementSystem = MeasurementSystem.metric;
  UnitLength height = MetricLength(163);
  UnitWeight weight = MetricWeight(50);

  DateTime? dob;

  UnitWeight? _weightGoal;
  UnitWeight get weightGoal => _weightGoal ?? weight;
  set weightGoal(UnitWeight value) => _weightGoal = value;

  Diet? diet;

  void moveToPrevStep(BuildContext context, TabController tabController) {
    if (currentStep == OnboardingStep.gender) return context.pop();

    currentStep = OnboardingStep.values[currentStep.index - 1];
    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void moveToNextStep(BuildContext context, TabController tabController) {
    if (currentStep.index == OnboardingStep.values.last.index) {
      // Todo: Move to home page
      return;
    }
    currentStep = OnboardingStep.values[currentStep.index + 1];
    tabController.animateTo(
      currentStep.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
