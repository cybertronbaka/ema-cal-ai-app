part of 'widgets.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
    required this.label,
  });

  final VoidCallback onPressed;
  final bool enabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.secondary,
        ),
        foregroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.primary,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
