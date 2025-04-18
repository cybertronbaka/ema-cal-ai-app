import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';

// Todo: Simply use DbUserProfile instead of this.
// Todo: Will need to adapt the ui to and rest of the logic.
// So once the db setup is done, we will do that
class UserProfile {
  const UserProfile({
    this.id,
    required this.dob,
    required this.gender,
    required this.workoutFrequency,
    required this.height,
    required this.weight,
    required this.isMetric,
    required this.weightGoal,
    required this.diet,
    required this.isOnboardingComplete,
    required this.gptApiKey,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromDB(DbUserProfile profile) {
    return UserProfile(
      id: profile.id.toInt(),
      dob: profile.dob,
      gender: profile.gender,
      workoutFrequency: profile.workoutFrequency,
      height: UnitLength.fromCm(profile.heightCm, profile.isMetric),
      weight: UnitWeight.fromKg(profile.weightKg, profile.isMetric),
      isMetric: profile.isMetric,
      weightGoal: UnitWeight.fromKg(profile.weightGoalKg, profile.isMetric),
      diet: profile.diet,
      isOnboardingComplete: profile.isOnboardingComplete,
      gptApiKey: profile.gptApiKey,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }

  DbUserProfile toDB() {
    return DbUserProfile(
      id: -1.toBigInt(),
      dob: dob,
      gender: gender,
      workoutFrequency: workoutFrequency,
      heightCm: height.cm,
      weightKg: weight.kg,
      isMetric: isMetric,
      weightGoalKg: weightGoal.kg,
      diet: diet,
      isOnboardingComplete: isOnboardingComplete,
      gptApiKey: gptApiKey,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  final int? id;
  final DateTime dob;
  final Gender gender;
  final WorkoutFrequency workoutFrequency;
  final UnitLength height;
  final UnitWeight weight;
  final bool isMetric;
  final UnitWeight weightGoal;
  final Diet diet;
  final bool isOnboardingComplete;
  final String gptApiKey;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dob': dob.toIso8601String(),
      'gender': gender.index,
      'workout_frequency': workoutFrequency.index,
      'height': height.toJson(),
      'weight': weight.toJson(),
      'is_metric': isMetric,
      'weight_goal': weightGoal.toJson(),
      'diet': diet.index,
      'is_onboarding_complete': isOnboardingComplete,
      'gpt_api_key': gptApiKey,
    };
  }

  @override
  bool operator ==(Object other) {
    if (other is! UserProfile) return false;

    return dob.year == other.dob.year &&
        dob.month == other.dob.month &&
        dob.day == other.dob.day &&
        gender == other.gender &&
        workoutFrequency == other.workoutFrequency &&
        height == other.height &&
        weight == other.weight &&
        isMetric == other.isMetric &&
        weightGoal == other.weightGoal &&
        diet == other.diet &&
        isOnboardingComplete == other.isOnboardingComplete &&
        gptApiKey == other.gptApiKey &&
        id == id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  UserProfile copyWith({
    int? id,
    DateTime? dob,
    Gender? gender,
    WorkoutFrequency? workoutFrequency,
    UnitLength? height,
    UnitWeight? weight,
    bool? isMetric,
    UnitWeight? weightGoal,
    Diet? diet,
    bool? isOnboardingComplete,
    String? gptApiKey,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isMetric: isMetric ?? this.isMetric,
      weightGoal: weightGoal ?? this.weightGoal,
      diet: diet ?? this.diet,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      gptApiKey: gptApiKey ?? this.gptApiKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
