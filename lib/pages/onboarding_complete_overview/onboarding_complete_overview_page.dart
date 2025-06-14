library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
                          for (final noteType in NutritionNoteType.values)
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: _Card(
                                bgColor: noteType.bgColor,
                                children: [
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Text(
                                        noteType.label,
                                        style: textTheme.titleSmall,
                                      ),
                                      FaIcon(
                                        noteType.icon,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    nutritionPlan.notes.fromNoteType(noteType),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
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
                onPressed: () {
                  context.pushReplacementNamed(Routes.home.name);
                },
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

  static const _types = [
    MacroNutrients.calories,
    MacroNutrients.protein,
    MacroNutrients.carbs,
    MacroNutrients.fats,
  ];
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      children: [
        for (final type in _types)
          MacroNutritionPlanCard(
            value: nutritionPlan.goal.fromNutrientType(type),
            type: type,
          ),
      ],
    );
  }
}
