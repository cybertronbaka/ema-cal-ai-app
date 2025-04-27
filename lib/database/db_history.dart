part of 'database.dart';

class DbHistories extends Table {
  Int64Column get id => int64().autoIncrement()();

  // Values
  TextColumn get type => textEnum<HistoryType>()();
  RealColumn get value => real()();

  // Timestamps
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
