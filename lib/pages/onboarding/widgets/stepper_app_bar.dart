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
            CustomBackButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                if (!canMovePrevStep) return;

                controller.moveToPrevStep(context, tabController);
              },
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: tabController,
                builder: (context, child) {
                  final animationValue = tabController.animation!.value;
                  final progress = (animationValue + 1) / tabController.length;

                  return LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                    backgroundColor: AppColors.secondary,
                    color: AppColors.primary,
                  );
                },
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
