import 'package:converter_hub/core/app_imports.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  /// It used for mic permission
  static Future<bool> checkMicPermission() async {
    final PermissionStatus micStatus = await Permission.microphone.status;
    if (micStatus.isGranted == true) return true;
    bool status = await statusHandler(
      permission: Permission.microphone,
      status: micStatus,
    );
    return status;
  }

  static Future<bool> checkStoragePermission() async {
    final PermissionStatus storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) {
      debugPrint("Storage access allowed");
      return true;
    } else {
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        debugPrint("Storage access allowed");
        return true;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        return false;
      } else {
        return false;
      }
    }
  }

  /// it handle only status of any permisison
  static Future<bool> statusHandler({
    required PermissionStatus status,
    required Permission permission,
  }) async {
    switch (status) {
      case PermissionStatus.denied:
        final PermissionStatus currentStatus = await permission.request();
        UiHelper.dbugPrint("permission denied$currentStatus");
        return currentStatus.isGranted;

      case PermissionStatus.granted:
        UiHelper.dbugPrint("permission granted");
        return true;

      ///it execute and return false if any of three condition match
      case PermissionStatus.restricted:
      case PermissionStatus.provisional:
      case PermissionStatus.limited:
        UiHelper.dbugPrint("permission limited");
        return false;
      case PermissionStatus.permanentlyDenied:
        UiHelper.dbugPrint("permission permanently Denied");
        await openAppSettings();
        return false;
    }
  }
}
