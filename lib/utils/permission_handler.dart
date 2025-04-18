import 'dart:async';

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  static Future<bool> requestPermission(
    BuildContext context,
    Permission permission,
  ) async {
    var status = await permission.status;
    switch (status) {
      case PermissionStatus.permanentlyDenied:
        if (context.mounted) _showOpenSettingsDialog(context, permission);
        return false;
      case PermissionStatus.granted:
        return true;
      default:
        status = await permission.request();
        return false;
    }
  }

  static void _showOpenSettingsDialog(
    BuildContext context,
    Permission permission,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => _PermissionDeniedDialog(
            permission: permission,
            requestPermission: () => requestPermission(context, permission),
          ),
    );
  }
}

extension _PermissionExt on Permission {
  String? get name => switch (this) {
    Permission.camera => 'Camera',
    Permission.storage => 'Gallery',
    Permission.photos => 'Gallery',
    _ => null,
  };

  IconData? get icon => switch (this) {
    Permission.camera => FontAwesomeIcons.camera,
    Permission.storage => FontAwesomeIcons.images,
    Permission.photos => FontAwesomeIcons.images,
    _ => null,
  };
}

class _PermissionDeniedDialog extends StatelessWidget {
  const _PermissionDeniedDialog({
    required this.permission,
    required this.requestPermission,
  });

  final Permission permission;
  final Future<void> Function() requestPermission;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (permission.icon != null) ...[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: FaIcon(permission.icon, size: 38, color: Colors.white),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            'Permissions to ${permission.name!} was denied',
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please grant Ema Cal AI permissions via Settings.',
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          CustomFilledButton(
            onPressed: () async {
              final openedSettings = await openAppSettings();
              if (!context.mounted) return;

              if (!openedSettings) {
                CustomSnackBar.showErrorNotification(
                  context,
                  'Please open your Settings app, find the Ema Cal AI app, and grant ${permission.name!} permissions.',
                );
                return;
              }

              late final AppLifecycleListener appLifecycleListener;
              appLifecycleListener = AppLifecycleListener(
                onResume: () {
                  if (context.mounted) Navigator.of(context).pop();
                  unawaited(requestPermission());

                  appLifecycleListener.dispose();
                },
              );
            },
            label: 'Go to Settings',
          ),
        ],
      ),
    );
  }
}
