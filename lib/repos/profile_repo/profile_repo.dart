library;

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/app/globals.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileRepoProvider = Provider<ProfileRepo>(
  (_) => throw UnimplementedError(),
);

abstract class ProfileRepo {
  Future<UserProfile?> get();
  Future<UserProfile> save(UserProfile profile);
  Future<void> clear();
}

class LocalProfileRepo extends ProfileRepo {
  DbUserProfile? current;
  @override
  Future<UserProfile?> get() async {
    final data = await _getAndSaveCurrent();
    if (data == null) return null;

    return UserProfile.fromDB(data);
  }

  Future<DbUserProfile?> _getAndSaveCurrent() async {
    final query = database.select(database.dbUserProfiles)..limit(1);
    final data = await query.getSingleOrNull();

    current = data;
    return data;
  }

  @override
  Future<UserProfile> save(UserProfile profile) async {
    var record = current == null ? await _getAndSaveCurrent() : current!;

    BigInt? oldId = record?.id;

    profile = profile.copyWith(
      id: oldId?.toInt(),
      createdAt: oldId == null ? clock.now() : profile.createdAt,
      updatedAt: clock.now(),
    );

    int id;
    if (oldId == null) {
      id = await _insert(profile);
    } else {
      await _update(profile);
      id = oldId.toInt();
    }

    current = profile.toDB().copyWith(id: id.toBigInt());
    return UserProfile.fromDB(current!);
  }

  @override
  Future<void> clear() async {
    await database.managers.dbUserProfiles.delete();
  }

  Future<int> _insert(UserProfile profile) {
    return database
        .into(database.dbUserProfiles)
        .insert(
          DbUserProfilesCompanion.insert(
            gender: profile.gender,
            workoutFrequency: profile.workoutFrequency,
            isMetric: profile.isMetric,
            diet: profile.diet,
            isOnboardingComplete: profile.isOnboardingComplete,
            dob: profile.dob,
            gptApiKey: profile.gptApiKey,
            heightCm: profile.height.cm,
            weightKg: profile.weight.kg,
            weightGoalKg: profile.weightGoal.kg,
            updatedAt: profile.updatedAt,
            createdAt: profile.createdAt,
          ),
        );
  }

  Future<void> _update(UserProfile profile) async {
    await database
        .update(database.dbUserProfiles)
        .replace(
          DbUserProfilesCompanion(
            id: profile.id.toBigInt().toDbValueOrAbsent(),
            gender: profile.gender.toDbValue(),
            workoutFrequency: profile.workoutFrequency.toDbValue(),
            isMetric: profile.isMetric.toDbValue(),
            diet: profile.diet.toDbValue(),
            isOnboardingComplete: profile.isOnboardingComplete.toDbValue(),
            dob: profile.dob.toDbValue(),
            gptApiKey: profile.gptApiKey.toDbValue(),
            heightCm: profile.height.cm.toDbValue(),
            weightKg: profile.weight.kg.toDbValue(),
            weightGoalKg: profile.weightGoal.kg.toDbValue(),
            updatedAt: profile.updatedAt.toDbValue(),
            createdAt: profile.createdAt.toDbValue(),
          ),
        );
  }
}
