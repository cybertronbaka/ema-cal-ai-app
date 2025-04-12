/// Steps are separate widgets (not builder functions) to prevent memory waste.
///
/// Builder functions would load all steps' logic at once, even inactive ones.
/// Widgets only build when active, saving memory at the cost of file separation.
part of '../onboarding_page.dart';

class _ChooseGenderStep extends ConsumerWidget {
  const _ChooseGenderStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetGenderView(
      title: 'Choose your Gender',
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialValue: controller.gender,
      onBtnPressed: (value) {
        controller.gender = value;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _ChooseWorkoutFrequencyStep extends ConsumerWidget {
  const _ChooseWorkoutFrequencyStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetWorkoutFrequencyView(
      title: 'What is your weekly exercise frequency?',
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialValue: controller.workoutFrequency,
      onBtnPressed: (value) {
        controller.workoutFrequency = value;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _SetHeightAndWeightStep extends ConsumerWidget {
  const _SetHeightAndWeightStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetHeightAndWeightView(
      title: 'Height & Weight',
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialHeight: controller.height,
      initialWeight: controller.weight,
      initialMeasurementSystem: controller.measurementSystem,
      onBtnPressed: (measurementSystem, height, weight) {
        controller.measurementSystem = measurementSystem;
        controller.height = height;
        controller.weight = weight;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _SetDobStep extends ConsumerWidget {
  const _SetDobStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetDobView(
      title: 'When were you born?',
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialValue: controller.dob,
      onBtnPressed: (dob) {
        controller.dob = dob;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _SetWeightGoalStep extends ConsumerWidget {
  const _SetWeightGoalStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetWeightGoalView(
      title: 'Set your weight goal',
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialValue: controller.weightGoal,
      measurementSystem: controller.measurementSystem,
      onBtnPressed: (weight) {
        controller.weightGoal = weight;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _ChooseDietStep extends ConsumerWidget {
  const _ChooseDietStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetDietView(
      title: "What's your diet preference?",
      description: 'Your personalized plan will be tailored based on this.',
      btnLabel: 'Next',
      initialValue: controller.diet,
      onBtnPressed: (value) {
        controller.diet = value;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _SetMealTimeRemindersStep extends ConsumerWidget {
  const _SetMealTimeRemindersStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetMealTimeRemindersView(
      title: 'Set Reminders to take a photo of your food.',
      description:
          'We will remind you to take a photo of your meal at the set times.\n\n'
          'You can skip this step by tapping "Next"',
      btnLabel: 'Next',
      initialValue: controller.mealTimeReminders,
      onBtnPressed: (reminders) {
        controller.mealTimeReminders = reminders;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}
