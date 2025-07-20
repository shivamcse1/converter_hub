// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:converter_hub/core/app_imports.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  /// this fucntion is used for sharing text,message,url
  static Future<void> shareText({
    required String sharingText,
    String? subject,
  }) async {
    try {
      await Share.share(sharingText, subject: subject);
      UiHelper.showCustomToast(msg: "Successfully shared!");
    } catch (ex) {
      UiHelper.showCustomToast(msg: AppString.somethingWentWrong);
      debugPrint("Exception while sharing:$ex");
    }
  }

  /// this fucntion is used for sharing single or multiple files like  text,files,image,pdf,zip etc
  static Future<void> shareFiles({
    String? sharingText,
    String? subject,
    List<File>? files,
    required File singlefile,
  }) async {
    try {
      if (files != null && files.isNotEmpty) {
        final List<XFile> allShareableFiles =
            files.map((singleFile) => XFile(singleFile.path)).toList();
        await Share.shareXFiles(
          allShareableFiles,
          text: sharingText,
          subject: subject,
        );
      } else {
        final XFile shareAbleFile = XFile(singlefile.path);
        await Share.shareXFiles(
          [shareAbleFile],
          text: sharingText,
          subject: subject,
        );
      }
    } catch (ex) {
      UiHelper.showCustomToast(msg: AppString.somethingWentWrong);
      debugPrint("Exception while sharing:$ex");
    }
  }
}
