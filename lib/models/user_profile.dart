import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/models/unit_length.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:hive/hive.dart';

class UserProfile {
  const UserProfile({
    required this.dob,
    required this.gender,
    required this.workoutFrequency,
    required this.height,
    required this.weight,
    required this.measurementSystem,
    required this.weightGoal,
    required this.diet,
    required this.isOnboardingComplete,
  });

  factory UserProfile.fromHive(Box box) {
    return UserProfile(
      dob: DateTime.parse(box.get('dob')),
      gender: Gender.values[box.get('gender')],
      workoutFrequency: WorkoutFrequency.values[box.get('workout_frequency')],
      height: UnitLength.fromJson(box.get('height')),
      weight: UnitWeight.fromJson(box.get('weight')),
      measurementSystem:
          MeasurementSystem.values[box.get('measurement_system')],
      weightGoal: UnitWeight.fromJson(box.get('weight_goal')),
      diet: Diet.values[box.get('diet')],
      isOnboardingComplete: box.get('is_onboarding_complete'),
    );
  }

  final DateTime dob;
  final Gender gender;
  final WorkoutFrequency workoutFrequency;
  final UnitLength height;
  final UnitWeight weight;
  final MeasurementSystem measurementSystem;
  final UnitWeight weightGoal;
  final Diet diet;
  final bool isOnboardingComplete;

  Map<String, dynamic> toJson() {
    return {
      'dob': dob.toIso8601String(),
      'gender': gender.index,
      'workout_frequency': workoutFrequency.index,
      'height': height.toJson(),
      'weight': weight.toJson(),
      'measurement_system': measurementSystem.index,
      'weight_goal': weightGoal.toJson(),
      'diet': diet.index,
      'is_onboarding_complete': isOnboardingComplete,
    };
  }

  @override
  bool operator ==(covariant UserProfile other) {
    return dob.year == other.dob.year &&
        dob.month == other.dob.month &&
        dob.day == other.dob.day &&
        gender == other.gender &&
        workoutFrequency == other.workoutFrequency &&
        height == other.height &&
        weight == other.weight &&
        measurementSystem == other.measurementSystem &&
        weightGoal == other.weightGoal &&
        diet == other.diet &&
        isOnboardingComplete == other.isOnboardingComplete;
  }

  UserProfile copyWith({
    DateTime? dob,
    Gender? gender,
    WorkoutFrequency? workoutFrequency,
    UnitLength? height,
    UnitWeight? weight,
    MeasurementSystem? measurementSystem,
    UnitWeight? weightGoal,
    Diet? diet,
    bool? isOnboardingComplete,
  }) {
    return UserProfile(
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      measurementSystem: measurementSystem ?? this.measurementSystem,
      weightGoal: weightGoal ?? this.weightGoal,
      diet: diet ?? this.diet,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
