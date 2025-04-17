import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addMealDataControllerProvider = Provider.autoDispose
    .family<AddMealDataController, MealData>(
      (ref, data) => AddMealDataController(ref, data),
    );

class AddMealDataController {
  AddMealDataController(this.ref, MealData data) : _data = data {
    ref.onDispose(dispose);
  }

  Ref ref;
  final MealData _data;

  late ValueNotifier<MealData> data = ValueNotifier(_data);
  ValueNotifier<int> portions = ValueNotifier(1);

  void reducePortion() {
    if (portions.value <= 1) return;

    portions.value = portions.value - 1;
    data.value = _data * portions.value;
  }

  void addPortion() {
    portions.value = portions.value + 1;
    data.value = _data * portions.value;
  }

  Future<void> save(BuildContext context) async {
    await FutureRunner(
      context: context,
      onDone: (_) {
        if (context.mounted) context.pop();
      },
    ).run(
      Future(() async {
        await ref.read(mealDataRepoProvider).add(data.value);
        return null;
      }),
    );
  }

  void dispose() {
    data.dispose();
  }
}
