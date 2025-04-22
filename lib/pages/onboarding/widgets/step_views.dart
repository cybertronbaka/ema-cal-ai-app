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
      onBtnPressed: (value) async {
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
      isMetric: controller.isMetric,
      onBtnPressed: (isMetric, height, weight) async {
        controller.isMetric = isMetric;
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
      onBtnPressed: (dob) async {
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
      isMetric: controller.isMetric,
      onBtnPressed: (weight) async {
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

class _SetGeminiApiKeyStep extends ConsumerWidget {
  const _SetGeminiApiKeyStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return SetGeminiApiKeyView(
      title: 'Enter Your Gemini API Key',
      description:
          'Your API key is stored locally for your convenience.\n\n'
          "Since our service is currently free, we're unable to support external API keys at this time.\n"
          'Please continue using the provided key for seamless access.',
      btnLabel: 'Next',
      initialValue: controller.gptApiKey,
      onBtnPressed: (value) {
        controller.gptApiKey = value;
        controller.moveToNextStep(context, DefaultTabController.of(context));
      },
    );
  }
}

class _GenerateNutritionPlanStep extends ConsumerWidget {
  const _GenerateNutritionPlanStep({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);

    return GenerateNutritionPlanView(
      title: "We're setting everything up for you",
      description: 'Customizing your nutrition plan',
      btnLabel: 'Next',
      profile: controller.profile,
      reminders: controller.mealTimeReminders,
      plan: controller.nutritionPlan,
      onGenerationDone: (plan) {
        controller.nutritionPlan = plan;
        controller.saveData();
      },
      onBtnPressed: (nutritionPlan) {
        controller.nutritionPlan = nutritionPlan;
        controller.onboardingDone(context);
      },
    );
  }
}
