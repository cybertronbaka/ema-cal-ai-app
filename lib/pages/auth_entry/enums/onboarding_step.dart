part of '../auth_entry_page.dart';

enum _OnboardingStep {
  intro(
    'Calorie tracking made easy',
    "Just snap a quick photo of your meal and we'll do the rest",
  ),
  disclaimer(
    'Disclaimer',
    'Ema AI provides calorie and nutritional information for general guidance only.\n\n'
        'Consult a healthcare professional before making dietary changes.'
        'Information may not be accurate and is not medical advice.\n\n'
        'Results vary. Use responsibly.'
        'We are not liable for any health outcomes. AI estimates are not guaranteed.',
    TextAlign.left,
  );

  const _OnboardingStep(
    this.title,
    this.description, [
    this.descriptionAlign = TextAlign.center,
  ]);

  final String title;
  final String description;
  final TextAlign descriptionAlign;
}
