import 'package:ema_cal_ai/repos/gpt_api_key_repo/gpt_api_key_repo.dart';
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

  Future<String?> getApiKey() async {
    String? apiKey = ref.read(gptApiKeyProvider);
    if (apiKey != null) return apiKey;

    apiKey = await ref.read(gptApiKeyRepoProvider).get();
    return apiKey;
  }

  Future<bool> verifyApiKey(BuildContext context, String apiKey) async {
    final verified = await ref.read(gptApiKeyVerifyRepoProvider).verify(apiKey);
    if (verified) {
      try {
        await ref.read(gptApiKeyRepoProvider).save(apiKey);
        return true;
      } catch (_) {
        return false;
      }
    }

    if (context.mounted) {
      CustomSnackBar.showErrorNotification(context, 'API Key does\'nt work');
    }

    return false;
  }
}
