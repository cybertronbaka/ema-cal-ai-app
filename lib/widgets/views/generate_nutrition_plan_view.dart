import 'package:confetti/confetti.dart';
import 'package:ema_cal_ai/controllers/nutrition_planner_controller.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/utils/hooks/confetti_controller.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerateNutritionPlanView extends HookConsumerWidget {
  const GenerateNutritionPlanView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    this.reminders,
    required this.profile,
    required this.gptApiKey,
    this.plan,
    this.onGenerationDone,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final void Function(NutritionPlan value)? onBtnPressed;
  final void Function(NutritionPlan value)? onGenerationDone;
  final UserProfile profile;
  final List<MealTimeReminder>? reminders;
  final String gptApiKey;
  final NutritionPlan? plan;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final controller = ref.watch(nutritionPlannerControllerProvider);
    final confettiController = useConfettiController(
      duration: const Duration(seconds: 3),
    );
    final isDone = useState(false);

    useInitHook(() {
      if (plan != null) {
        controller.nutritionPlan = AsyncData(plan!);
        isDone.value = true;
        return;
      }

      controller.generatePlan(profile, reminders ?? [], gptApiKey);
    }, [plan]);

    useEffect(() {
      final plan = controller.nutritionPlan;
      if (plan.hasValue) {
        confettiController.play();
        isDone.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onGenerationDone?.call(plan.value!);
        });
      }

      return null;
    }, [controller.nutritionPlan]);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight <= 0) {
                  return const SizedBox.shrink();
                }

                return SingleChildScrollView(
                  padding: _hPadding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null || description != null)
                                Padding(
                                  padding: _hPadding,
                                  child: Column(
                                    spacing: 8,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (title != null)
                                        Text(
                                          title!,
                                          style: textTheme.titleLarge,
                                        ),
                                      if (description != null && !isDone.value)
                                        Text(description!),
                                      if (isDone.value)
                                        const Text('We are done setting up.'),
                                    ],
                                  ),
                                ),
                              controller.nutritionPlan.when(
                                data: (data) {
                                  return const SizedBox.shrink();
                                },
                                error: (e, st) {
                                  return Padding(
                                    padding: _hPadding.copyWith(top: 24),
                                    child: Text(
                                      e.toString(),
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  );
                                },
                                loading: () {
                                  return Center(
                                    child: Padding(
                                      padding: _hPadding.copyWith(top: 24),
                                      child: const SizedBox.square(
                                        dimension: 30,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ConfettiWidget(
                              confettiController: confettiController,
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              emissionFrequency:
                                  0.05, // how often it should emit
                              numberOfParticles:
                                  30, // number of particles to emit
                              shouldLoop: false,
                              colors: const [
                                Colors.green,
                                Colors.blue,
                                Colors.pink,
                              ], // manually specify the colors to be used
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: _hPadding.copyWith(bottom: 16, top: 16),
            width: double.infinity,
            child: controller.nutritionPlan.when(
              loading: () => const SizedBox.shrink(),
              error: (e, st) {
                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: CustomFilledButton(
                    onPressed: () {
                      controller.generatePlan(
                        profile,
                        reminders ?? [],
                        gptApiKey,
                      );
                    },
                    label: 'Retry',
                  ),
                );
              },
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: CustomFilledButton(
                    onPressed: () {
                      if (controller.nutritionPlan.value == null) return;

                      onBtnPressed?.call(controller.nutritionPlan.value!);
                    },
                    label: btnLabel,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
