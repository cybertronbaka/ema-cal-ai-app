import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class FutureRunner<T> {
  const FutureRunner({
    required this.context,
    this.doneMessage,
    this.errorMessage,
    this.onError,
    this.onDone,
  });
  final BuildContext context;
  final String? doneMessage;
  final String Function(Object? obj, StackTrace stackTrace)? errorMessage;
  final void Function(Object? obj, StackTrace stackTrace)? onError;
  final void Function(T result)? onDone;

  Future<void> run(Future<T> future) async {
    final overlay = LoadingOverlay.of(context);
    await overlay
        .during(future)
        .then((value) {
          if (doneMessage != null && context.mounted) {
            CustomSnackBar.showSuccessNotification(context, doneMessage!);
          }
          onDone?.call(value);
        })
        .onError((e, stackTrace) {
          debugPrint(e.toString());
          debugPrint(stackTrace.toString());
          if (context.mounted) {
            CustomSnackBar.showErrorNotification(
              context,
              errorMessage != null
                  ? errorMessage!(e, stackTrace)
                  : e.toString(),
            );
          }

          onError?.call(e, stackTrace);
        });
  }
}
