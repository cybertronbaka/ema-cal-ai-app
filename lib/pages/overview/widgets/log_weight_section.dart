part of '../overview_page.dart';

class _LogWeightSection extends ConsumerWidget {
  const _LogWeightSection();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final textTheme = TextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(180),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Weight',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(profile.weight.toString(), style: textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Try to update once a week so we can adjust your plan to ensure you hit your goal',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomSmallFilledButton(
                onPressed: () {
                  // Todo: To Update history and from settings too
                  // Todo: To only allow updating with profile's isMetric (No Switch)
                },
                padding: const EdgeInsets.all(16),
                label: 'Log Weight',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
