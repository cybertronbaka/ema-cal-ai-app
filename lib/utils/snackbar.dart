import 'package:flutter/material.dart';

enum CustomSnackBarType { error, success, info }

class CustomSnackBarCapsule {
  const CustomSnackBarCapsule({
    required this.message,
    this.type = CustomSnackBarType.error,
    this.durationInSeconds = 3,
  });

  final String message;
  final CustomSnackBarType type;
  final int durationInSeconds;
}

final Map<CustomSnackBarType, Color> _notificationColors = {
  CustomSnackBarType.error: Colors.redAccent,
  CustomSnackBarType.info: Colors.blueAccent,
  CustomSnackBarType.success: Colors.green,
};

final _notificationIcons = {
  CustomSnackBarType.error: Icons.error_outline,
  CustomSnackBarType.info: Icons.info_outline,
  CustomSnackBarType.success: Icons.done,
};

class CustomSnackBar {
  static void showNotification(
    BuildContext context,
    CustomSnackBarCapsule capsule,
  ) {
    final snackBar = SnackBar(
      content: Row(
        spacing: 10,
        children: [
          Icon(_notificationIcons[capsule.type], color: Colors.white),
          Expanded(child: Text(capsule.message)),
        ],
      ),
      duration: Duration(seconds: capsule.durationInSeconds),
      backgroundColor: _notificationColors[capsule.type],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorNotification(BuildContext context, String message) {
    showNotification(
      context,
      CustomSnackBarCapsule(message: message, type: CustomSnackBarType.error),
    );
  }

  static void showSuccessNotification(BuildContext context, String message) {
    showNotification(
      context,
      CustomSnackBarCapsule(message: message, type: CustomSnackBarType.success),
    );
  }

  static void showInfoNotification(BuildContext context, String message) {
    showNotification(
      context,
      CustomSnackBarCapsule(message: message, type: CustomSnackBarType.info),
    );
  }
}
