library;

import 'package:ema_cal_ai/controllers/auth_entry_controller.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'enums/onboarding_step.dart';
part 'widgets/image_section.dart';
part 'widgets/indicators.dart';

class OnboardingEntryPage extends HookConsumerWidget {
  const OnboardingEntryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authEntryControllerProvider);

    final textTheme = TextTheme.of(context);
    final isAttached = useValueNotifier(false);
    final pageController = usePageController(
      onAttach: (position) => isAttached.value = true,
      onDetach: (position) => isAttached.value = false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                  onPressed:
                                      () =>
                                          controller.toOnboardingPage(context),
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
