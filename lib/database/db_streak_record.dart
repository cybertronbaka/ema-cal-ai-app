part of 'database.dart';

// final int count;
// final DateTime updatedAt;

class DbStreakRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Values
  IntColumn get count => integer()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
