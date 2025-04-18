part of 'database.dart';

// OnboardingStep currentStep;
// DateTime? dob;
// Gender? gender;
// WorkoutFrequency? workoutFrequency;
// UnitLength height;
// UnitWeight weight;
// bool? isMetric;
// UnitWeight? weightGoal;
// Diet? diet;
// List<MealTimeReminder>? mealTimeReminders;
// String? gptApiKey;
// NutritionPlan? nutritionPlan;

class DbOnboardingDatas extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  TextColumn get currentStep => textEnum<OnboardingStep>()();
  TextColumn get gender => textEnum<Gender>().nullable()();
  TextColumn get workoutFrequency => textEnum<WorkoutFrequency>().nullable()();
  BoolColumn get isMetric => boolean().nullable()();
  TextColumn get diet => textEnum<Diet>().nullable()();
  DateTimeColumn get dob => dateTime().nullable()();
  TextColumn get gptApiKey => text().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get weightGoalKg => real().nullable()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  // References

  // Not Sure how to one to many so I have just added a field in DBReminders with OnboardingData as nullable
}
