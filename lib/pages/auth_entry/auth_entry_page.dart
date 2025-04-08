import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class AuthEntryPage extends HookConsumerWidget {
  const AuthEntryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final isAttached = useValueNotifier(false);
    final pageController = usePageController(
      onAttach: (position) => isAttached.value = true,
      onDetach: (position) => isAttached.value = false,
    );

    return Scaffold(
      body: Stack(
        children: [
          const _ImageSection(),
          Column(
            children: [
              const Expanded(flex: 2, child: SizedBox.expand()),
              Expanded(
                flex: 3,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: Colors.white,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: pageController,
                          itemCount: _OnboardingStep.values.length,
                          itemBuilder: (context, index) {
                            final step = _OnboardingStep.values[index];

                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                spacing: 16,
                                children: [
                                  const SizedBox.shrink(),
                                  Text(
                                    step.title,
                                    textAlign: TextAlign.center,
                                    style: textTheme.titleLarge,
                                  ),
                                  Text(
                                    step.description,
                                    textAlign: step.descriptionAlign,
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 32,
                              children: [
                                _Indicators(
                                  pageController: pageController,
                                  isAttached: isAttached,
                                ),
                                FilledButton(
                                  onPressed: () {},
                                  child: const Text('Next'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Indicators extends StatelessWidget {
  const _Indicators({required this.pageController, required this.isAttached});

  final PageController pageController;
  final ValueNotifier<bool> isAttached;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_OnboardingStep.values.length, (i) {
        return ListenableBuilder(
          listenable: Listenable.merge([pageController, isAttached]),
          builder: (context, _) {
            final page = isAttached.value ? pageController.page ?? 0 : 0.0;
            final isActive = page > i - 0.5 && page < i + 0.5;

            return Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.black : Colors.grey,
              ),
            );
          },
        );
      }),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/cuisine.jpg', // Todo: Need a better image
                  fit: BoxFit.cover,
                ),
              ),
              const Column(
                children: [
                  Expanded(flex: 1, child: SizedBox.expand()),
                  Expanded(flex: 5, child: ScannerOverlayBox()),
                  Expanded(flex: 2, child: SizedBox.expand()),
                ],
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox.expand()),
      ],
    );
  }
}
