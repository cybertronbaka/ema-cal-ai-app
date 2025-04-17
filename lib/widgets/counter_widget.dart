part of 'widgets.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.onReduce,
    required this.onAdd,
    required this.value,
  });

  final VoidCallback onReduce;
  final VoidCallback onAdd;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onReduce,
          child: const Icon(Icons.remove_rounded),
        ),
        Text(value.toString(), style: TextTheme.of(context).titleMedium),
        GestureDetector(onTap: onAdd, child: const Icon(Icons.add_rounded)),
      ],
    );
  }
}
