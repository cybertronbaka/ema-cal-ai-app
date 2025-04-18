part of 'database.dart';

// String label;
// TimeOfDay? timeOfDay;

enum DbReminderType { mealTime }

class DbReminders extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  TextColumn get type => textEnum<DbReminderType>()();
  TextColumn get label => text()();
  IntColumn get hour => integer().nullable()();
  IntColumn get minute => integer().nullable()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  // References
  Int64Column get onboardingData =>
      int64().nullable().references(DbOnboardingDatas, #id)();
}
