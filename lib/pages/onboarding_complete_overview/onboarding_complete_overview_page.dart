library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/models/macro_nutrient_value.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/states/nutrition_plan.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingCompleteOverviewPage extends ConsumerWidget {
  const OnboardingCompleteOverviewPage({super.key});

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final nutritionPlan = ref.watch(currentNutritionPlanProvider)!;
    final profile = ref.watch(userProfileProvider)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),

                          Align(
                            alignment: Alignment.center,

                            child: Text(
                              'Congratulations!!\nYour custom plan is ready!',
                              style: textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'You should achieve:',
                              textAlign: TextAlign.center,
                              style: textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Text(
                                '${profile.weightGoal} in ${nutritionPlan.timeframeInWeeks} weeks',
                                textAlign: TextAlign.center,
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _Card(
                            children: [
                              Text(
                                'Daily Recommendation',
                                style: textTheme.titleSmall,
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'You can edit this any time',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              _NutritionGrid(nutritionPlan: nutritionPlan),
                              const SizedBox(height: 8),
                              WaterIntakeCard(
                                max: nutritionPlan.goal.waterLiters,
                                value: nutritionPlan.goal.waterLiters / 2,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _Card(
                            bgColor: const Color(0xFFFAF5E5),
                            children: [
                              Text('Warnings ⚠️', style: textTheme.titleSmall),
                              const SizedBox(height: 8),
                              Text(
                                nutritionPlan.notes.warnings,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _Card(
                            children: [
                              Text(
                                'Gym Advice 💪',
                                style: textTheme.titleSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                nutritionPlan.notes.gymAdvice,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _Card(
                            bgColor: const Color(0xFFFFD6D6),
                            children: [
                              Text(
                                'Medical Advice 🏥',
                                style: textTheme.titleSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                nutritionPlan.notes.medicalAdvice,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: _hPadding.copyWith(bottom: 16, top: 16),
              width: double.infinity,
              child: CustomFilledButton(
                enabled: true,
                onPressed: () {},
                label: "Let's get started!",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children, this.bgColor = const Color(0xFFEFF6FF)});

  final List<Widget> children;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _NutritionGrid extends StatelessWidget {
  const _NutritionGrid({required this.nutritionPlan});

  final NutritionPlan nutritionPlan;
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 20,
      ),
      children: [
        NutritionProgressCard(
          value: MacroNutrientValue.calories(
            value: nutritionPlan.goal.calories / 2.0,
            maxValue: nutritionPlan.goal.calories.toDouble(),
          ),
        ),
        NutritionProgressCard(
          value: MacroNutrientValue.protein(
            value: nutritionPlan.goal.proteinG / 2.0,
            maxValue: nutritionPlan.goal.proteinG.toDouble(),
          ),
        ),
        NutritionProgressCard(
          value: MacroNutrientValue.carbs(
            value: nutritionPlan.goal.carbsG / 2.0,
            maxValue: nutritionPlan.goal.carbsG.toDouble(),
          ),
        ),
        NutritionProgressCard(
          value: MacroNutrientValue.fats(
            value: nutritionPlan.goal.fatsG / 2.0,
            maxValue: nutritionPlan.goal.fatsG.toDouble(),
          ),
        ),
      ],
    );
  }
}
