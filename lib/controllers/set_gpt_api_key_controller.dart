import 'package:ema_cal_ai/repos/gpt_api_key_verify_repo/gpt_api_key_verify_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final setGptApiKeyControllerProvider = Provider.autoDispose(
  (ref) => SetGptApiKeyController(ref),
);

class SetGptApiKeyController {
  SetGptApiKeyController(this.ref);

  Ref ref;

  Future<void> verifyApiKey(
    BuildContext context,
    String apiKey, {
    void Function()? onVerified,
  }) async {
    await FutureRunner<(bool, String?)>(
      context: context,
      onDone: (result) {
        final (verified, error) = result;

        if (error != null) {
          if (context.mounted) {
            showError(context, error);
          }
          return;
        }

        if (verified) {
          ref.read(gptApiKeyProvider.notifier).state = apiKey;
          onVerified?.call();
          return;
        }

        if (context.mounted) {
          showError(context, 'API Key does\'nt work');
        }
        return;
      },
    ).run(() async {
      return ref.read(gptApiKeyVerifyRepoProvider).verify(apiKey);
    });
  }

  void showError(BuildContext context, String message) {
    CustomSnackBar.showErrorNotification(context, message);
  }
}
