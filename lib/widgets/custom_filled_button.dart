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

class CustomSmallFilledButton extends StatelessWidget {
  const CustomSmallFilledButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
    required this.label,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  });

  final VoidCallback onPressed;
  final bool enabled;
  final String label;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.secondary,
        ),
        foregroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.primary,
        ),
        padding: WidgetStatePropertyAll(padding),
        minimumSize: const WidgetStatePropertyAll(Size(10.0, 10.0)),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: fontSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
