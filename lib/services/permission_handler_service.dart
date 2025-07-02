import 'package:converter_hub/core/helper/ui_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {


 /// It used for mic permission
  static Future<bool> micPermissionHandler() async {
    final PermissionStatus micStatus = await Permission.microphone.status;
    if(micStatus.isGranted == true) return true;
    bool status = await statusHandler(
      permission: Permission.microphone,
      status: micStatus,
    );
    return status;
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