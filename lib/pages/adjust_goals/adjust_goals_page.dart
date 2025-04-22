library;

import 'package:ema_cal_ai/controllers/adjust_goals_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdjustGoalsPage extends ConsumerWidget {
  const AdjustGoalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(currentNutritionPlanProvider)!;
    final textTheme = TextTheme.of(context);
    final controller = ref.watch(adjustGoalsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: Text('Adjust Goals', style: textTheme.titleMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              for (final type in MacroNutrients.values) ...[
                Row(
                  spacing: 16,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CircularProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey.withAlpha(100),
                              color: type.color,
                              strokeWidth: 5,
                            ),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: type.color.withAlpha(20),
                                ),
                                child: FaIcon(
                                  type.icon,
                                  size: 16,
                                  color: type.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(40),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${type.label} goal',
                              style: textTheme.bodySmall,
                            ),
                            Text('${plan.goal.fromNutrientType(type).toInt()}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
              const SizedBox(height: 20),
              FutureCustomFilledButton(
                onPressed: () async {
                  await controller.generateGoals(context);
                },
                label: 'Auto Generate Goals',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
