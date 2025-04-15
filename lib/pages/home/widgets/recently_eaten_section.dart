part of '../home_page.dart';

class _RecentlyEatenSection extends StatelessWidget {
  const _RecentlyEatenSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recently eaten', style: textTheme.titleSmall),
        const _NoMealDataCard(),
      ],
    );
  }
}
