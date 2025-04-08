import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mocktail/mocktail.dart';

class MockKeyboardVisibilityController extends Mock
    implements KeyboardVisibilityController {
  MockKeyboardVisibilityController([this.returnValue = false]);
  final bool returnValue;

  @override
  Stream<bool> get onChange => Stream.value(returnValue);

  @override
  bool get isVisible => returnValue;
}
