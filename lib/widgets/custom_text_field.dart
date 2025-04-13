part of 'widgets.dart';

class CustomTextField<T> extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.borderRadius = 32,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
  });

  final String formControlName;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final double borderRadius;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(FormControl<T>)? onSubmitted;
  final void Function(FormControl<T>)? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControlName: formControlName,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}
