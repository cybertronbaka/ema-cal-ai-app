part of 'widgets.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
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
    return OutlinedButton(
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

class CustomSmallOutlinedButton extends StatelessWidget {
  const CustomSmallOutlinedButton({
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
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.secondary,
        ),
        foregroundColor: WidgetStatePropertyAll(
          enabled ? null : AppColors.primary,
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
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
