part of 'states.dart';

/// created only for testing
final keyboardVisibilityControllerProvider =
    Provider<KeyboardVisibilityController>((ref) => throw UnimplementedError());

final userProfileProvider = StateProvider<UserProfile?>((_) => null);

final gptApiKeyProvider = StateProvider<String?>((_) => null);
