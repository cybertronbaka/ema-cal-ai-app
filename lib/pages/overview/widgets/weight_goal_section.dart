part of '../overview_page.dart';

class _WeightGoalSection extends ConsumerWidget {
  const _WeightGoalSection();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            const Text(
              'Weight Goal',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            CustomSmallFilledButton(
              onPressed: () {},
              label: 'Update',
              fontSize: 10,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
          ],
        ),
        Text(profile.weightGoal.toString(), style: textTheme.titleLarge),
      ],
    );
  }
}
