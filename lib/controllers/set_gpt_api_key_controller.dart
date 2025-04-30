import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final setGptApiKeyControllerProvider = Provider.autoDispose(
  (ref) => SetGptApiKeyController(ref),
);

class SetGptApiKeyController {
  SetGptApiKeyController(this.ref);

  Ref ref;

  Future<bool> verifyApiKey(BuildContext context, String apiKey) async {
    final (verified, error) = await ref
        .read(gptApiKeyVerifyRepoProvider)
        .verify(apiKey);
    if (error != null) {
      showError(context, error);
      return false;
    }

    print('got here');
    if (verified) {
      ref.read(gptApiKeyProvider.notifier).state = apiKey;
      return true;
    }

    showError(context, 'API Key does\'nt work');
    return false;
  }

  void showError(BuildContext context, String message) {
    if (!context.mounted) return;

    CustomSnackBar.showErrorNotification(context, message);
  }
}
