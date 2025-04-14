part of '../onboarding_page.dart';

class _StepperAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _StepperAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider);
    final tabController = DefaultTabController.of(context);
    final canMovePrevStep = ref.watch(nutritionPlannerCanGoBack);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            BackButton(
              onPressed: () {
                if (!canMovePrevStep) return;

                controller.moveToPrevStep(context, tabController);
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),

                  AnimatedBuilder(
                    animation: tabController,
                    builder: (context, child) {
                      final animationValue = tabController.animation!.value;
                      final progress =
                          (animationValue + 1) / tabController.length;

                      return FractionallySizedBox(
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: child,
                      );
                    },
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
