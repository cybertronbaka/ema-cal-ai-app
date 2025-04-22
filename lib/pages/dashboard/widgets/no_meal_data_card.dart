part of '../dashboard_page.dart';

class _NoMealDataCard extends StatelessWidget {
  const _NoMealDataCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 6,
        children: [
          Text(
            "You haven't uploaded any food",
            style: textTheme.titleSmall?.copyWith(fontSize: 14),
          ),
          Text(
            'Start tracking Today\'s meals by taking a quick picture',
            style: textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
