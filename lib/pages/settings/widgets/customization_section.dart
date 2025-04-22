part of '../settings_page.dart';

class _CustomizationSection extends ConsumerWidget {
  const _CustomizationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);

    final tiles = [
      ('Personal Details', null, Routes.editPersonalDetails.name),
      (
        'Adjust Goals',
        'Calories, carbs, fats, and protein',
        Routes.adjustGoals.name,
      ),
      ('Gemini API Key', null, Routes.editGeminiAPIKey.name),
      (
        'Meal Time Reminders',
        'Breakfast, Lunch and Dinner',
        Routes.editMealTimeReminders.name,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customization', style: textTheme.titleMedium),
        for (final tile in tiles)
          ListTile(
            onTap: () {
              context.pushNamed(tile.$3);
            },
            title: Text(tile.$1),
            subtitle: tile.$2 == null ? null : Text(tile.$2!),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 18,
              color: AppColors.darkGrey,
            ),
          ),
      ],
    );
  }
}
