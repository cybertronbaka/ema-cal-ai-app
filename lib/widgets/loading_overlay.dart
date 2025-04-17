part of 'widgets.dart';

class LoadingOverlay {
  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }

  LoadingOverlay._create(this._context);

  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(200),
      builder: (ctx) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator();
  }
}
