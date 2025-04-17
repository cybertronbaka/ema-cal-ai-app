library;

import 'package:ema_cal_ai/controllers/add_meal_data_controller.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/edit_macro_nutrient_value_card.dart';
part 'widgets/image_section.dart';
part 'widgets/macro_nutrients_section.dart';
part 'widgets/title_and_portion_section.dart';
part 'widgets/water_intake_section.dart';

final addMealDataPageDataProvider = Provider<AddMealDataPageData>(
  (ref) => throw UnimplementedError(),
);

class AddMealDataPage extends ConsumerWidget {
  const AddMealDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(addMealDataPageDataProvider);
    final controller = ref.watch(addMealDataControllerProvider(pageData.data));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const _ImageSection(),
          Positioned(
            left: 16,
            top: MediaQuery.of(context).viewPadding.top,
            child: BackButton(
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.grey.withAlpha(100),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Expanded(flex: 2, child: SizedBox.expand()),
              Expanded(
                flex: 3,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(40, 20),
                      topRight: Radius.elliptical(40, 20),
                    ),
                    color: Colors.white,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Stack(
                      children: [
                        const Positioned.fill(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                _TitleAndPortionsSection(),
                                SizedBox(height: 20),
                                _MacroNutrientsSection(),
                                _WaterIntakeSection(),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 32,
                              children: [
                                FutureCustomFilledButton(
                                  onPressed: () => controller.save(context),
                                  label: 'Save',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
