part of '../onboarding_page.dart';

class _StepperBody extends ConsumerWidget {
  const _StepperBody({super.key, required this.step});

  final OnboardingStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Steps are separate widgets (not builder functions) to prevent memory waste.
    ///
    /// Builder functions would load all steps' logic at once, even inactive ones.
    /// Widgets only build when active, saving memory at the cost of file separation.
    return switch (step) {
      OnboardingStep.gender => const _ChooseGenderStep(
        key: ValueKey(OnboardingStep.gender),
      ),
      OnboardingStep.workoutFrequency => const _ChooseWorkoutFrequencyStep(
        key: ValueKey(OnboardingStep.workoutFrequency),
      ),
      OnboardingStep.heightAndWeight => const _SetHeightAndWeightStep(
        key: ValueKey(OnboardingStep.heightAndWeight),
      ),
    };
  }
}
