part of 'states.dart';

final sharedPrefProvider = Provider<SharedPrefProxy>(
  (ref) => throw UnimplementedError(),
);

/// created only for testing
final keyboardVisibilityControllerProvider =
    Provider<KeyboardVisibilityController>((ref) => throw UnimplementedError());

final gptApiKeyProvider = StateProvider<String?>((_) => null);

final userProfileProvider = StateProvider<UserProfile?>((_) => null);
