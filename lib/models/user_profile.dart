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
  });

  factory UserProfile.fromHive(Box box) {
    return UserProfile(
      dob: DateTime.parse(box.get(_dobKey)),
      gender: Gender.values[box.get(_genderKey)],
      workoutFrequency: WorkoutFrequency.values[box.get(_workoutFrequencyKey)],
      height: UnitLength.fromJson(box.get(_heightKey)),
      weight: UnitWeight.fromJson(box.get(_weightKey)),
      measurementSystem:
          MeasurementSystem.values[box.get(_measurementSystemKey)],
      weightGoal: UnitWeight.fromJson(box.get(_weightGoalKey)),
      diet: Diet.values[box.get(_dietKey)],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _dobKey: dob.toIso8601String(),
      _genderKey: gender.index,
      _workoutFrequencyKey: workoutFrequency.index,
      _heightKey: height.toJson(),
      _weightKey: weight.toJson(),
      _measurementSystemKey: measurementSystem.index,
      _weightGoalKey: weightGoal.toJson(),
      _dietKey: diet.index,
    };
  }

  final DateTime dob;
  static const _dobKey = 'dob';

  final Gender gender;
  static const _genderKey = 'gender';

  final WorkoutFrequency workoutFrequency;
  static const _workoutFrequencyKey = 'workoutFrequency';

  final UnitLength height;
  static const _heightKey = 'height';

  final UnitWeight weight;
  static const _weightKey = 'weight';

  final MeasurementSystem measurementSystem;
  static const _measurementSystemKey = 'measurementSystem';

  final UnitWeight weightGoal;
  static const _weightGoalKey = 'weightGoal';

  final Diet diet;
  static const _dietKey = 'diet';
}
