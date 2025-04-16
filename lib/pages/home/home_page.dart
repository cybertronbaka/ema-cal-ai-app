library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/controllers/home_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/states/meal_data.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/hooks/init_hook.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' as intl;

part 'widgets/calories_intake_card.dart';
part 'widgets/macro_nutrients_section.dart';
part 'widgets/macro_nutrient_card.dart';
part 'widgets/recently_eaten_section.dart';
part 'widgets/no_meal_data_card.dart';
part 'widgets/streak_week_section.dart';
part 'widgets/water_intake_section.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    useInitHook(() {
      controller.getTodaysMealData();
      controller.getThisWeekMealData();
    }, []);

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
                  // Todo: Collapse Calories, Macro Nutrients and Water intake into
                  // Todo: New design where all are Listed in small icons and text
                  // Todo: and linear progress bar when scrolled.
                  _DailyCaloriesIntakeCard(),
                  SizedBox(height: 16),
                  _MacroNutrientsSection(),
                  SizedBox(height: 16),
                  _WaterIntakeSection(),
                  SizedBox(height: 16),
                  _RecentlyEatenSection(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showImageSrcSelectionSheet(context);
        },
        child: const Icon(Icons.add_rounded, size: 32),
      ),
    );
  }
}
