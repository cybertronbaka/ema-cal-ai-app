part of 'database.dart';

// final int? id;
// final double calories;
// final double protein;
// final double carbs;
// final double fats;
// final double water;
// final String mealName;
// final String? mealDescription;
// final DateTime createdAt;

class DbMealDatas extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  RealColumn get calories => real()();
  RealColumn get protein => real()();
  RealColumn get carbs => real()();
  RealColumn get fats => real()();
  RealColumn get water => real()();
  TextColumn get mealName => text()();
  TextColumn get mealDescription => text().nullable()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
