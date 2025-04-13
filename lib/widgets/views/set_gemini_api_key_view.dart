import 'package:ema_cal_ai/utils/hooks/form_group.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SetGeminiApiKeyView extends HookWidget {
  const SetGeminiApiKeyView({
    super.key,
    this.title,
    this.description,
    this.btnLabel = 'Save',
    this.onBtnPressed,
    this.initialValue,
  });

  final String? title;
  final String? description;
  final String btnLabel;
  final void Function(String value)? onBtnPressed;
  final String? initialValue;

  static const _hPadding = EdgeInsets.symmetric(horizontal: 16);
  static const _videoPath = 'assets/videos/get_gemini_api_key_instruction.mp4';

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final selected = useValueNotifier(initialValue);
    final formGroup = useFormGroup(
      controls: {
        'api_key': ['', Validators.required],
      },
    );

    return ReactiveForm(
      formGroup: formGroup,
      child: SafeArea(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: _hPadding,
                child: Text(title!, style: textTheme.titleLarge),
              ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxHeight <= 0) {
                    return const SizedBox.shrink();
                  }

                  return SingleChildScrollView(
                    padding: _hPadding,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          if (description != null)
                            Text(
                              description!,
                              style: const TextStyle(fontSize: 12),
                            ),

                          const SensitiveField(formControlName: 'api_key'),
                          const Text(
                            'Follow the following instruction video if you are not sure how to get the API key.',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const CustomAssetVideoPlayer(source: _videoPath),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: _hPadding.copyWith(bottom: 16, top: 16),
              width: double.infinity,
              child: ReactiveFormConsumer(
                builder: (context, fg, _) {
                  return CustomFilledButton(
                    enabled: fg.valid,
                    onPressed: () {
                      if (fg.invalid ||
                          selected.value == null ||
                          selected.value!.isEmpty) {
                        return;
                      }

                      onBtnPressed?.call(selected.value!);
                    },
                    label: btnLabel,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
