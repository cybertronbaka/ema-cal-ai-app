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
      onBtnPressed: (height, weight) {
        controller.height = height;
        controller.weight = weight;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}
