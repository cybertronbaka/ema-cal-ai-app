part of 'widgets.dart';

class SensitiveField extends HookWidget {
  const SensitiveField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
  });

  final String formControlName;
  final String? hintText;
  final TextInputAction? textInputAction;
  final void Function(FormControl<String>)? onEditingComplete;
  final void Function(FormControl<String>)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(true);

    return CustomTextField<String>(
      obscureText: isObscure.value,
      formControlName: formControlName,
      hintText: hintText,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      suffixIcon: Focus(
        canRequestFocus: false,
        descendantsAreFocusable: false,
        child: IconButton(
          icon: Icon(
            isObscure.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            isObscure.value = !isObscure.value;
          },
        ),
      ),
    );
  }
}
