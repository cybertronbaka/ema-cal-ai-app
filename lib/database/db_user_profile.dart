part of 'database.dart';

// final DateTime dob;
// final Gender gender;
// final WorkoutFrequency workoutFrequency;
// final UnitLength height;
// final UnitWeight weight;
// final bool isMetric;
// final UnitWeight weightGoal;
// final Diet diet;
// final bool isOnboardingComplete;
// final String gptApiKey;

class DbUserProfiles extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  TextColumn get gender => textEnum<Gender>()();
  TextColumn get workoutFrequency => textEnum<WorkoutFrequency>()();
  BoolColumn get isMetric => boolean()();
  TextColumn get diet => textEnum<Diet>()();
  BoolColumn get isOnboardingComplete => boolean()();
  DateTimeColumn get dob => dateTime()();
  TextColumn get gptApiKey => text()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  RealColumn get weightGoalKg => real()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  // References
}
