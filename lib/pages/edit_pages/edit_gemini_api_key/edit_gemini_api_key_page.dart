library;

import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/views/set_gemini_api_key_view.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditGeminiApiKeyPage extends HookConsumerWidget {
  const EditGeminiApiKeyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: Text(
          'Edit Gemini API Key',
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: SetGeminiApiKeyView(
        description:
            'Your API key is stored locally for your convenience.\n\n'
            "Since our service is currently free, we're unable to support external API keys at this time.\n"
            'Please continue using the provided key for seamless access.',
        initialValue: profile.gptApiKey,
        btnLabel: 'Done',
        onBtnPressed: (apiKey) async {
          await controller.setGptApiKey(context, apiKey);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
