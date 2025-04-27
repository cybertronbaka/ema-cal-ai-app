import 'package:mocktail/mocktail.dart';

extension VoidAnswer on When<Future<void>> {
  void thenAnswerWithVoid() => thenAnswer((_) async {});
}

extension ValueAnswer<T> on When<Future<T>> {
  void thenAnswerWithValue(T value) => thenAnswer((_) async => value);
}
