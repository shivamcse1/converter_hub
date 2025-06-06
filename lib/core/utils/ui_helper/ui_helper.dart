import 'package:converter_hub/core/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../theme/app_colors.dart';

class UiHelper {
  /// for print any statement
  static void dbugPrint(String msg) {
    debugPrint(msg);
  }

  // show custom toast
  static customToast({
    String msg = AppString.issueOccurred,
    ToastGravity toastGravity = ToastGravity.CENTER,
    Color toastColor = AppColors.errorColor,
    Color textColor = AppColors.whiteColor,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: textColor,
      fontSize: 16.0.sp,
    );
  }

  static copyData({required String data}) {
    Clipboard.setData(ClipboardData(text: data));
    customToast(msg: "Text copied", toastColor: AppColors.greyColor);
  }

  

  
}
