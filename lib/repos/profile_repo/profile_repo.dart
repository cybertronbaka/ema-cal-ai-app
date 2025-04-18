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

    final id = await database
        .into(database.dbUserProfiles)
        .insertOnConflictUpdate(
          DbUserProfilesCompanion(
            id: oldId.toDbValueOrAbsent(),
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
            updatedAt: now.toDbValue(),
            createdAt: createdAt.toDbValue(),
          ),
        );

    current = profile.toDB().copyWith(
      id: id.toBigInt(),
      createdAt: createdAt,
      updatedAt: now,
    );
    return UserProfile.fromDB(current!);
  }

  @override
  Future<void> clear() async {
    await database.managers.dbUserProfiles.delete();
  }
}
