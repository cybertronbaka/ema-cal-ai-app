part of '../home_page.dart';

class _StreaksWeekSection extends StatelessWidget {
  const _StreaksWeekSection();

  @override
  Widget build(BuildContext context) {
    final today = clock.now();
    final weekDates = getWeekDates(today);
    final List<StreakEntry> entries = [];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(weekDates.length, (i) {
        final date = weekDates[i];
        final streakItem = entries.findByDate(date);
        final isInFuture = date.difference(today).inDays > 0;
        final isStreakComplete =
            !isInFuture && streakItem != null && streakItem.isCompleted;

        return Column(
          spacing: 4,
          children: [
            DottedCircleBorder(
              radius: 20,
              color:
                  (isStreakComplete || isInFuture)
                      ? Colors.transparent
                      : AppColors.darkGrey,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isStreakComplete ? const Color(0xFFE67E22) : null,
                ),
                child: Center(
                  child: Text(
                    DateFormat('EEEEE').format(date),
                    style: TextStyle(
                      color: isStreakComplete ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              date.day.toString().padLeft(2, '0'),
              style: TextStyle(
                fontWeight: date == today ? FontWeight.w600 : null,
                color: isInFuture ? AppColors.darkGrey : null,
              ),
            ),
          ],
        );
      }),
    );
  }

  List<DateTime> getWeekDates(DateTime date) {
    // Find the Monday of the week
    DateTime monday = date.subtract(Duration(days: date.weekday - 1));

    // Generate all days from Monday to Sunday
    List<DateTime> weekDates = [];
    for (int i = 0; i < 7; i++) {
      weekDates.add(monday.add(Duration(days: i)));
    }

    return weekDates;
  }
}
