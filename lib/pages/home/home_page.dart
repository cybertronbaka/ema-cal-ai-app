library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/stream_entry.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

part 'widgets/calories_intake_card.dart';
part 'widgets/macro_nutrients_section.dart';
part 'widgets/macro_nutrient_card.dart';
part 'widgets/recently_eaten_section.dart';
part 'widgets/no_meal_data_card.dart';
part 'widgets/streak_week_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ema Cal AI')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  _StreaksWeekSection(),
                  SizedBox(height: 24),
                  _DailyCaloriesIntakeCard(),
                  SizedBox(height: 16),
                  _MacroNutrientsSection(),
                  SizedBox(height: 16),
                  _RecentlyEatenSection(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
