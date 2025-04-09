part of 'widgets.dart';

// Todo: Animate this
class OptionsList<T extends Enum> extends HookWidget {
  const OptionsList({
    super.key,
    this.onSelected,
    required this.builder,
    required this.options,
    this.initialValue,
  });
  final void Function(T selected)? onSelected;
  final Widget Function(T value) builder;
  final List<T> options;
  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    final selected = useState(initialValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        for (final value in options)
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                selected.value == value ? null : AppColors.secondary,
              ),
              foregroundColor: WidgetStatePropertyAll(
                selected.value == value ? null : Colors.black54,
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            onPressed: () {
              onSelected?.call(value);
              selected.value = value;
            },
            child: builder(value),
          ),
      ],
    );
  }
}
