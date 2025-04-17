part of 'dialogs.dart';

class ImageDescriptionSheet extends HookWidget {
  const ImageDescriptionSheet({super.key, this.image});
  final XFile? image;

  @override
  Widget build(BuildContext context) {
    final formGroup = useFormGroup(
      controls: {
        'msg': [''],
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
                child: Text('Describe your food', style: textTheme.titleMedium),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'This is will help us estimated contents',
                  style: textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 24),
              if (image != null) ...[
                SizedBox(height: 100, child: Image.file(File(image!.path))),
                const SizedBox(height: 16),
              ],
              const CustomTextField(
                formControlName: 'msg',
                hintText: 'Description (eg: Contains Chilli, Cheese,..)',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CustomFilledButton(
                onPressed: () {
                  Navigator.of(context).pop(formGroup.control('msg').value);
                },
                label: 'Next',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> showImageDescriptionSheet(
  BuildContext context, {
  XFile? image,
}) async {
  final value = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ImageDescriptionSheet(image: image);
    },
  );

  if (value == null || value is! String) return null;

  return value;
}
