part of 'dialogs.dart';

class EditFieldDialog<T> extends HookWidget {
  const EditFieldDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.initialValue,
    this.description,
    this.keyboardType,
    this.validators = const [],
  });

  final String hintText;
  final T initialValue;
  final String title;
  final String? description;
  final TextInputType? keyboardType;
  final List<Validator<dynamic>> validators;

  @override
  Widget build(BuildContext context) {
    const fieldName = 'value';

    final formGroup = useFormGroup(
      controls: {
        fieldName: FormControl<T>(value: initialValue, validators: validators),
      },
    );
    final textTheme = TextTheme.of(context);

    return CustomDialog(
      child: ReactiveForm(
        formGroup: formGroup,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: textTheme.titleMedium),
              ),
              const SizedBox(height: 4),
              if (description != null) ...[
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(description!, style: textTheme.bodySmall),
                ),
              ],
              const SizedBox(height: 24),

              CustomTextField(
                formControlName: fieldName,
                hintText: hintText,
                keyboardType: keyboardType,
              ),
              const SizedBox(height: 20),
              ReactiveFormConsumer(
                builder: (_, fg, _) {
                  return CustomFilledButton(
                    enabled: fg.valid,
                    onPressed: () {
                      if (fg.invalid) return;

                      Navigator.of(
                        context,
                      ).pop(formGroup.control(fieldName).value);
                    },
                    label: 'Save',
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> showEditFieldDialog<T>(
  BuildContext context, {
  required String hintText,
  required T initialValue,
  required String title,
  String? description,
  TextInputType? keyboardType,
  List<Validator<dynamic>> validators = const [],
}) async {
  final value = await showDialog(
    context: context,
    builder: (context) {
      return EditFieldDialog(
        hintText: hintText,
        initialValue: initialValue,
        description: description,
        title: title,
        keyboardType: keyboardType,
        validators: validators,
      );
    },
  );

  if (value == null || value is! T) return null;

  return value;
}
