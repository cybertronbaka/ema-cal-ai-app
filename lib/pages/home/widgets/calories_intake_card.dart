part of '../home_page.dart';

class _DailyCaloriesIntakeCard extends StatelessWidget {
  const _DailyCaloriesIntakeCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1891',
                  style: textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Calories left',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey.withAlpha(100),
                      color: MacroNutrients.calories.color,
                      strokeWidth: 5,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkGrey.withAlpha(20),
                      ),
                      child: const Icon(
                        // Todo: Change the icon Use SVGs
                        Icons.bolt_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
