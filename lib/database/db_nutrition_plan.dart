part of 'database.dart';

// final int timeframeInWeeks;
// final int calories;
// final double proteinG;
// final double carbsG;
// final double fatsG;
// final double waterLiters;
// final String gymAdvice;
// final String medicalAdvice;
// final String warnings;

class DbNutritionPlans extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  IntColumn get timeframeInWeeks => integer()();
  IntColumn get calories => integer()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatsG => real()();
  RealColumn get waterLiters => real()();
  TextColumn get gymAdvice => text()();
  TextColumn get medicalAdvice => text()();
  TextColumn get warnings => text()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
