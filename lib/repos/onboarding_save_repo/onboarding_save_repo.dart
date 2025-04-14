library;

import 'package:ema_cal_ai/models/onboarding_data.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingSaveRepoProvider = Provider<OnboardingSaveRepo>(
  (_) => throw UnimplementedError(),
);

abstract class OnboardingSaveRepo {
  Future<OnboardingData?> get();
  Future<void> save(OnboardingData data);
  Future<void> clear();
}

class LocalOnboardingSaveRepo extends OnboardingSaveRepo {
  static const boxName = 'onboarding_save';

  @override
  Future<OnboardingData?> get() async {
    final box = await _openBox();
    if (box.isEmpty) return null;

    return OnboardingData.fromHive(box);
  }

  @override
  Future<void> save(OnboardingData plan) async {
    final box = await _openBox();
    await box.putAll(plan.toJson());
  }

  Future<Box> _openBox() => Hive.openBox(boxName);

  @override
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
