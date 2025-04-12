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
      dob: DateTime.parse(box.get('dob')),
      gender: Gender.values[box.get('gender')],
      workoutFrequency: WorkoutFrequency.values[box.get('workout_frequency')],
      height: UnitLength.fromJson(box.get('height')),
      weight: UnitWeight.fromJson(box.get('weight')),
      measurementSystem:
          MeasurementSystem.values[box.get('measurement_system')],
      weightGoal: UnitWeight.fromJson(box.get('weight_goal')),
      diet: Diet.values[box.get('diet')],
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
    };
  }
}
