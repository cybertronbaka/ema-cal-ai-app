library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/controllers/home_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/nutrition_plan.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' as intl;

part 'widgets/calories_intake_card.dart';
part 'widgets/macro_nutrients_section.dart';
part 'widgets/macro_nutrient_card.dart';
part 'widgets/recently_eaten_section.dart';
part 'widgets/no_meal_data_card.dart';
part 'widgets/streak_week_section.dart';
part 'widgets/water_intake_section.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);
    final streaks = ref.watch(streaksCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ema Cal AI'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              spacing: 4,
              children: [
                const FaIcon(
                  FontAwesomeIcons.fire,
                  color: Colors.orange,
                  size: 18,
                ),
                Text(
                  streaks.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showImageSrcSelectionSheet(context);
        },
        child: const Center(child: FaIcon(FontAwesomeIcons.plus, size: 20)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartSimple, size: 18),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 18),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear, size: 18),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
