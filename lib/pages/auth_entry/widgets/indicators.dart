part of '../auth_entry_page.dart';

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
