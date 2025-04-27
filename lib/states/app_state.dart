part of 'states.dart';

/// created only for testing
final keyboardVisibilityControllerProvider =
    Provider<KeyboardVisibilityController>((ref) => throw UnimplementedError());

final userProfileProvider = StateProvider<UserProfile?>((_) => null);

final gptApiKeyProvider = StateProvider<String?>((_) => null);

final packageInfoProvider = StateProvider<PackageInfo>(
  (_) => throw UnimplementedError(),
);

final mealTimeRemindersProvider = StateProvider<List<MealTimeReminder>>(
  (_) => [],
);
