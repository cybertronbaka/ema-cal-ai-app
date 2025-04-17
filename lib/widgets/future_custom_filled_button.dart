part of 'widgets.dart';

class FutureCustomFilledButton extends HookWidget {
  const FutureCustomFilledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  });

  final Future<void> Function() onPressed;
  final bool enabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isRunning = useState(false);

    return CustomFilledButton(
      enabled: !isRunning.value && enabled,
      onPressed: () async {
        if (isRunning.value) return;

        isRunning.value = true;
        try {
          await onPressed();
        } finally {
          isRunning.value = false;
        }
      },
      label: label,
    );
  }
}
