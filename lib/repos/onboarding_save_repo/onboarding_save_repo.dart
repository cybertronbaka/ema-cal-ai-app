library;

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/meal_time_reminder.dart';
import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:ema_cal_ai/repos/meal_time_reminders_repo/meal_time_reminders_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingSaveRepoProvider = Provider<OnboardingSaveRepo>(
  (_) => throw UnimplementedError(),
);

abstract class OnboardingSaveRepo {
  Future<OnboardingData?> get();
  Future<OnboardingData> save(OnboardingData data);
  Future<void> clear();
}

class LocalOnboardingSaveRepo extends OnboardingSaveRepo {
  LocalOnboardingSaveRepo(this.ref);

  Ref ref;

  DbOnboardingData? current;

  @override
  Future<OnboardingData?> get() async {
    final data = await _getAndSaveCurrent();
    if (data == null) return null;

    final reminders = await ref
        .read(mealTimeRemindersRepoProvider)
        .get(onboardingDataId: data.id.toInt());

    print('got reminders: ${reminders.map((e) => e.toJson())}');

    return OnboardingData.fromDB(
      data,
    ).copyWith(mealTimeReminders: reminders.isEmpty ? null : reminders);
  }

  Future<DbOnboardingData?> _getAndSaveCurrent() async {
    final query = database.select(database.dbOnboardingDatas)..limit(1);
    final data = await query.getSingleOrNull();

    current = data;
    return data;
  }

  @override
  Future<OnboardingData> save(OnboardingData data) async {
    var record = current == null ? await _getAndSaveCurrent() : current!;

    BigInt? oldId = record?.id;

    int? id;
    List<MealTimeReminder>? reminders;
    data = data.copyWith(
      id: oldId?.toInt(),
      createdAt: oldId == null ? clock.now() : data.createdAt,
      updatedAt: clock.now(),
    );

    try {
      await database.transaction(() async {
        if (oldId == null) {
          print('inserting');
          id = await _insert(data);
        } else {
          print('updating');
          await _update(data);
          id = oldId.toInt();
        }

        if (data.mealTimeReminders == null) return;

        await ref.read(mealTimeRemindersRepoProvider).clear();
        print('cleared on $id && $oldId');

        current = data.toDB().copyWith(id: id.toBigInt());
        reminders = await ref
            .read(mealTimeRemindersRepoProvider)
            .saveAll(data.mealTimeReminders!, onboardingDataId: id);
        print('added reminders: ${reminders!.map((e) => e.toJson())}');
      });
    } catch (_) {
      current = record;
      rethrow;
    }

    return OnboardingData.fromDB(
      current!,
    ).copyWith(mealTimeReminders: reminders);
  }

  Future<int> _insert(OnboardingData data) {
    return database
        .into(database.dbOnboardingDatas)
        .insert(
          DbOnboardingDatasCompanion.insert(
            currentStep: data.currentStep,
            gender: data.gender.toDbNullableValue(),
            workoutFrequency: data.workoutFrequency.toDbNullableValue(),
            isMetric: data.isMetric.toDbNullableValue(),
            diet: data.diet.toDbNullableValue(),
            dob: data.dob.toDbNullableValue(),
            gptApiKey: data.gptApiKey.toDbNullableValue(),
            heightCm: data.height.cm.toDbNullableValue(),
            weightKg: data.weight.kg.toDbNullableValue(),
            weightGoalKg: (data.weightGoal?.kg).toDbNullableValue(),
            updatedAt: data.updatedAt,
            createdAt: data.createdAt,
          ),
        );
  }

  Future<void> _update(OnboardingData data) async {
    await database
        .update(database.dbOnboardingDatas)
        .replace(
          DbOnboardingDatasCompanion(
            id: data.id.toBigInt().toDbValue(),
            currentStep: data.currentStep.toDbValue(),
            gender: data.gender.toDbNullableValue(),
            workoutFrequency: data.workoutFrequency.toDbNullableValue(),
            isMetric: data.isMetric.toDbNullableValue(),
            diet: data.diet.toDbNullableValue(),
            dob: data.dob.toDbNullableValue(),
            gptApiKey: data.gptApiKey.toDbNullableValue(),
            heightCm: data.height.cm.toDbNullableValue(),
            weightKg: data.weight.kg.toDbNullableValue(),
            weightGoalKg: (data.weightGoal?.kg).toDbNullableValue(),
            updatedAt: data.updatedAt.toDbValue(),
            createdAt: data.createdAt.toDbValue(),
          ),
        );
  }

  @override
  Future<void> clear() async {
    await database.managers.dbOnboardingDatas.delete();
  }
}
