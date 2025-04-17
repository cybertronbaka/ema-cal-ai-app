part of 'widgets.dart';

class CustomTextField<T> extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
    this.readOnly = false,
    this.maxLines = 1,
  });

  final String formControlName;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(FormControl<T>)? onSubmitted;
  final void Function(FormControl<T>)? onEditingComplete;
  final bool readOnly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      maxLines: maxLines,
      formControlName: formControlName,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}
