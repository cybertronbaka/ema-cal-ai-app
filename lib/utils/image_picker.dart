import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class CustomImagePicker {
  static Future<XFile?> pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final granted = await requestPermission(context, source);
    if (!granted) return null;

    return await ImagePicker().pickImage(
      source: Platform.isMacOS ? ImageSource.gallery : source,
    );
  }

  static Future<bool> requestPermission(
    BuildContext context,
    ImageSource source,
  ) async {
    /// To let ImagePicker handle it
    if (Platform.isMacOS) return true;

    final permission = await _getPermissionType(source);
    var status = await permission.status;
    switch (status) {
      case PermissionStatus.permanentlyDenied:
        if (context.mounted) _showOpenSettingsDialog(context, source);
        return false;
      case PermissionStatus.granted:
        return true;
      default:
        status = await permission.request();
        return false;
    }
  }

  static Future<Permission> _getPermissionType(ImageSource source) async {
    return switch (source) {
      ImageSource.camera => Permission.camera,
      ImageSource.gallery =>
        Platform.isAndroid &&
                (await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32
            ? Permission.storage
            : Permission.photos,
    };
  }

  static void _showOpenSettingsDialog(
    BuildContext context,
    ImageSource source,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => _PermissionDeniedDialog(
            source: source,
            requestPermission: () => requestPermission(context, source),
          ),
    );
  }
}

extension _ImageSourceExt on ImageSource {
  String get name => switch (this) {
    ImageSource.camera => 'Camera',
    ImageSource.gallery => 'Gallery',
  };

  IconData get icon => switch (this) {
    ImageSource.camera => Icons.camera_alt,
    ImageSource.gallery => Icons.photo_library,
  };
}

class _PermissionDeniedDialog extends StatelessWidget {
  const _PermissionDeniedDialog({
    required this.source,
    required this.requestPermission,
  });

  final ImageSource source;
  final Future<void> Function() requestPermission;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(source.icon, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Permissions to ${source.name} was denied',
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please grant Ema Cal AI permissions via Settings.',
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomFilledButton(
            onPressed: () async {
              final openedSettings = await openAppSettings();
              if (!context.mounted) return;

              if (!openedSettings) {
                CustomSnackBar.showErrorNotification(
                  context,
                  'Please open your Settings app, find the Ema Cal AI app, and grant ${source.name} permissions.',
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
