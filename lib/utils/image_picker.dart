import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ema_cal_ai/utils/permission_handler.dart';
import 'package:ema_cal_ai/widgets/custom_camera/custom_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class CustomImagePicker {
  static Future<XFile?> pickImage(
    BuildContext context,
    ImageSource source, {

    /// if the function returns true, it means we will use the image
    Future<bool> Function(BuildContext, XFile)? afterPicked,
  }) async {
    if (!context.mounted) return null;

    final permission = await _getPermissionType(source);
    final granted = await PermissionHandler.requestPermission(
      // ignore: use_build_context_synchronously
      context,
      permission,
    );
    if (!granted) return null;

    if (source == ImageSource.camera && !Platform.isMacOS) {
      if (!context.mounted) return null;

      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CustomCamera(afterImageSelected: afterPicked);
          },
        ),
      );
    }

    final result = await ImagePicker().pickImage(
      source: Platform.isMacOS ? ImageSource.gallery : source,
    );
    if (result != null && context.mounted) {
      final value = await afterPicked?.call(context, result);
      if (value != null && !value) return null;
    }

    return result;
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
}
