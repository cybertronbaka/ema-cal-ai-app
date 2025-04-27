import 'package:ema_cal_ai/utils/is_test.dart';
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
    this.showOverlay = true,
  });
  final BuildContext context;
  final String? doneMessage;
  final String Function(Object? obj, StackTrace stackTrace)? errorMessage;
  final void Function(Object? obj, StackTrace stackTrace)? onError;
  final void Function(T result)? onDone;
  final bool showOverlay;

  Future<void> run(Future<T> Function() future) async {
    if (showOverlay) {
      final overlay = LoadingOverlay.of(context);
      await overlay.during(future).then(_onDone).onError(_onError);
    } else {
      try {
        final result = await future();
        _onDone(result);
      } catch (e, st) {
        _onError(e, st);
      }
    }
  }

  void _onDone(T value) {
    if (doneMessage != null && context.mounted) {
      CustomSnackBar.showSuccessNotification(context, doneMessage!);
    }
    onDone?.call(value);
  }

  void _onError(Object e, StackTrace stackTrace) {
    if (!kIsTest) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }
    if (context.mounted) {
      CustomSnackBar.showErrorNotification(
        context,
        errorMessage != null ? errorMessage!(e, stackTrace) : e.toString(),
      );
    }

    onError?.call(e, stackTrace);
  }
}
