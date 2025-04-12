library;

import 'package:ema_cal_ai/models/user_profile.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileRepoProvider = Provider<ProfileRepo>(
  (_) => throw UnimplementedError(),
);

abstract class ProfileRepo {
  Future<UserProfile?> get();
  Future<void> save(UserProfile profile);
}

class LocalProfileRepo extends ProfileRepo {
  static const boxName = 'profile';

  @override
  Future<UserProfile?> get() async {
    final box = await _openBox();
    if (box.isEmpty) return null;

    return UserProfile.fromHive(box);
  }

  @override
  Future<void> save(UserProfile profile) async {
    final box = await _openBox();
    await box.putAll(profile.toJson());
  }

  Future<Box> _openBox() => Hive.openBox(boxName);
}
