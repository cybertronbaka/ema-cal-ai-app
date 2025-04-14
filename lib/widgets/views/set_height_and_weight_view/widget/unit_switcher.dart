part of '../set_height_and_weight_view.dart';

class _UnitSwitcher extends StatelessWidget {
  const _UnitSwitcher({required this.isMetricNotifier});

  final ValueNotifier<bool> isMetricNotifier;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    final unselectedColor = textTheme.titleMedium?.color?.withAlpha(99);

    return ListenableBuilder(
      listenable: isMetricNotifier,
      builder: (_, _) {
        return Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Imperial',
              style: textTheme.titleMedium?.copyWith(
                color: isMetricNotifier.value ? unselectedColor : null,
              ),
            ),
            Switch(
              value: isMetricNotifier.value,
              onChanged: (value) {
                isMetricNotifier.value = value;
              },
            ),
            Text(
              'Metric',
              style: textTheme.titleMedium?.copyWith(
                color: isMetricNotifier.value ? null : unselectedColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
