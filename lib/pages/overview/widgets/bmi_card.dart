part of '../overview_page.dart';

class _BMICard extends ConsumerWidget {
  const _BMICard();

  static const minBmi = 13.0;
  static const maxBmi = 40.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;

    final bmi = profile.bmiIndex;
    final category = BMICategory.fromBMI(bmi);
    final textTheme = TextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(180),
          border: Border.all(color: Colors.black.withAlpha(10)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                const Text(
                  'Your BMI is:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: category.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    category.label,
                    style: TextStyle(
                      fontSize: 8,
                      color: category.fgColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(bmi.toStringAsFixed(1), style: textTheme.titleMedium),
            const SizedBox(height: 8),
            BMIIndicator(maxBmi: maxBmi, minBmi: minBmi, bmi: bmi),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var category in BMICategory.values)
                  Row(
                    spacing: 6,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category.color,
                        ),
                      ),
                      Text(
                        category.label,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
