import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';

void setupPermissions(Map<int, int> permissions) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        const MethodChannel('flutter.baseflow.com/permissions/methods'),
        (methodCall) async {
          switch (methodCall.method) {
            case 'requestPermissions':
              return permissions;
            case 'checkPermissionStatus':
              for (MapEntry<int, int> permissionKey in permissions.entries) {
                if (permissionKey.key == methodCall.arguments) {
                  return permissionKey.value;
                }
              }
              return PermissionStatus.restricted.index;
          }
          return null;
        },
      );
}
