import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:ema_cal_ai/repos/profile_repo/profile_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileControllerProvider = Provider.autoDispose(
  (ref) => ProfileController(ref),
);

class ProfileController {
  ProfileController(this.ref);

  Ref ref;

  Future<void> setWeightGoal(
    BuildContext context,
    UnitWeight weightGoal,
  ) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(weightGoal: weightGoal));
  }

  Future<void> setHeightWeight(
    BuildContext context,
    bool isMetric,
    UnitLength height,
    UnitWeight weight,
  ) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(
      context,
      profile.copyWith(weight: weight, height: height, isMetric: isMetric),
    );
  }

  Future<void> setDob(BuildContext context, DateTime dob) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(dob: dob));
  }

  Future<void> setGender(BuildContext context, Gender gender) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(gender: gender));
  }

  Future<void> setWorkoutFrequency(
    BuildContext context,
    WorkoutFrequency frequency,
  ) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(workoutFrequency: frequency));
  }

  Future<void> setDiet(BuildContext context, Diet diet) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(diet: diet));
  }

  Future<void> setGptApiKey(BuildContext context, String apiKey) async {
    final profile = ref.read(userProfileProvider)!;
    await _setProfile(context, profile.copyWith(gptApiKey: apiKey));
  }

  Future<void> _setProfile(BuildContext context, UserProfile newProfile) async {
    final runner = FutureRunner(context: context, showOverlay: false);

    await runner.run(() async {
      final response = await ref.read(profileRepoProvider).save(newProfile);

      ref.read(userProfileProvider.notifier).state = response;
    });
  }
}
