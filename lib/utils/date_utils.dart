abstract class AppDateUtils {
  static String getWeekOfMonth(List<String> parts) {
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final targetWeek = int.parse(parts[2]);

    final firstDayOfYear = DateTime(year, 1, 1);

    // Find first Monday of the year
    DateTime firstMonday = firstDayOfYear;
    while (firstMonday.weekday != DateTime.monday) {
      firstMonday = firstMonday.add(const Duration(days: 1));
    }

    // Custom week-of-year: week 0 starts from Jan 1 until first Monday
    int customWeekOfYear(DateTime date) {
      if (date.isBefore(firstMonday)) return 0;
      return ((date.difference(firstMonday).inDays) ~/ 7) + 1;
    }

    // Build list of week numbers appearing in the month
    final firstDayOfMonth = DateTime(year, month, 1);
    final firstDayNextMonth =
        (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    final lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));

    final weekNumbers = <int>[];
    for (
      var d = firstDayOfMonth;
      !d.isAfter(lastDayOfMonth);
      d = d.add(const Duration(days: 1))
    ) {
      final w = customWeekOfYear(d);
      if (!weekNumbers.contains(w)) {
        weekNumbers.add(w);
      }
    }

    final idx = weekNumbers.indexOf(targetWeek);
    if (idx == -1) {
      throw ArgumentError(
        'Week $targetWeek does not appear in $year-${month.toString().padLeft(2, '0')}',
      );
    }

    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${monthNames[month - 1]} Week ${idx + 1}';
  }
}
