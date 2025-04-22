part of 'states.dart';

final streaksCountProvider = StateProvider((ref) {
  ref.onDispose(() {
    debugPrint('Disposed streaksCountProvider');
  });
  return 0;
});
