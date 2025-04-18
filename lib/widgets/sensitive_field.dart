part of 'widgets.dart';

class SensitiveField extends HookWidget {
  const SensitiveField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.textInputAction,
    this.onSubmitted,
    this.onEditingComplete,
    this.readOnly = false,
  });

  final String formControlName;
  final String? hintText;
  final TextInputAction? textInputAction;
  final void Function(FormControl<String>)? onEditingComplete;
  final void Function(FormControl<String>)? onSubmitted;
  final bool readOnly;

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
      readOnly: readOnly,
      suffixIcon: Focus(
        canRequestFocus: false,
        descendantsAreFocusable: false,
        child: IconButton(
          icon: FaIcon(
            isObscure.value ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            size: 18,
          ),
          onPressed: () {
            isObscure.value = !isObscure.value;
          },
        ),
      ),
    );
  }
}
