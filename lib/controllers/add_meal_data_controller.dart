import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/repos/history_repo/history_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:ema_cal_ai/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
        if (context.mounted) context.pop(true);
      },
    ).run(() async {
      await ref.read(mealDataRepoProvider).add(data.value);
      await ref.read(historyRepoProvider).addCalorie(data.value.calories);
      return null;
    });
  }

  void editTitle(BuildContext context) async {
    final value = await showEditFieldDialog<String>(
      context,
      hintText: 'Meal name',
      initialValue: data.value.mealName,
      title: 'Edit the name of your meal',
      validators: [Validators.required],
    );

    if (value == null) return;

    data.value = data.value.copyWith(mealName: value);
  }

  void editNutritionValue(BuildContext context, MacroNutrients type) async {
    final value = await showEditFieldDialog<double>(
      context,
      hintText: type.label,
      initialValue: data.value.fromNutrientType(type),
      title: 'Edit the value for ${type.label}',
      keyboardType: TextInputType.number,
      validators: [Validators.required],
    );

    if (value == null) return;

    data.value = data.value.copyNutrientValue(value, type);
  }

  void dispose() {
    data.dispose();
  }
}
