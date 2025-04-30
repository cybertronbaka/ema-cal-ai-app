library;

import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/controllers/overview_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/bmi_card.dart';
part 'widgets/log_weight_section.dart';
part 'widgets/weight_goal_section.dart';
part 'widgets/weight_progress_section.dart';

class OverviewPage extends ConsumerWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overview')),
      body: const SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            _WeightGoalSection(),
            _LogWeightSection(),
            _BMICard(),
            _WeightProgressSection(),
            // Todo: Need to Add graphs (Weight Graphs)
            // For weight graphs. (Need to add by day.(Get one by day and save that.
            // If updated on the same day, just update the history of that day. Otherwise, add))
            // Filters include (90 days, 6 months, 1 year, All time)

            // Todo: Add Calories Graph (Daily Avg., Graph,  Total Calories by filter)
            // Filters include, (This week, Last Week, This month, This year)
          ],
        ),
      ),
    );
  }
}
