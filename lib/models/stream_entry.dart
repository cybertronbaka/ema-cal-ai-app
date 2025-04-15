import 'package:collection/collection.dart';

class StreakEntry {
  /// Creates a [StreakEntry] with the given [date] and completion status.
  const StreakEntry({required this.date, required this.isCompleted});

  /// Creates a [StreakEntry] for today with the specified completion status.
  factory StreakEntry.today({required bool isCompleted}) {
    return StreakEntry(date: DateTime.now(), isCompleted: isCompleted);
  }

  /// Creates a [StreakEntry] from a JSON map.
  factory StreakEntry.fromJson(Map<String, dynamic> json) => StreakEntry(
    date: DateTime.parse(json['date'] as String),
    isCompleted: json['is_completed'] as bool,
  );

  final DateTime date;
  final bool isCompleted;

  /// Creates a copy of this [StreakItem] with updated fields.
  StreakEntry copyWith({DateTime? date, bool? isCompleted}) {
    return StreakEntry(
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Returns a string representation of the [StreakItem].
  @override
  String toString() => 'StreakItem(date: $date, isCompleted: $isCompleted)';

  /// Enables equality comparison between [StreakItem] instances.
  @override
  bool operator ==(Object other) {
    if (other is! StreakEntry) return false;

    return other.date == date && other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => date.hashCode ^ isCompleted.hashCode;

  /// Converts the [StreakItem] to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'is_completed': isCompleted,
  };
}

extension StreamItemListExt on List<StreakEntry> {
  StreakEntry? findByDate(DateTime date) {
    final searchDate = DateTime.utc(date.year, date.month, date.day);

    return firstWhereOrNull(
      (item) =>
          DateTime.utc(item.date.year, item.date.month, item.date.day) ==
          searchDate,
    );
  }
}
