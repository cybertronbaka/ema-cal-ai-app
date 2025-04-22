part of '../settings_page.dart';

class _CustomizationSection extends ConsumerWidget {
  const _CustomizationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customization', style: textTheme.titleMedium),
        ListTile(
          onTap: () {
            context.pushNamed(Routes.editPersonalDetails.name);
          },
          title: const Text('Personal Details'),
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: AppColors.darkGrey,
          ),
        ),
        ListTile(
          onTap: () {},
          title: const Text('Adjust Goals'),
          subtitle: const Text('Calories, carbs, fats, and protein'),
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: AppColors.darkGrey,
          ),
        ),
        ListTile(
          onTap: () {
            context.pushNamed(Routes.editMealTimeReminders.name);
          },
          title: const Text('Meal Time Reminders'),
          subtitle: const Text('Breakfast, Lunch and Dinner'),
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
