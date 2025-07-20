// ignore_for_file: deprecated_member_use

import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../../presentation/widget/custom_loader.dart';
import '../theme/app_colors.dart';

class UiHelper {
  /// for print any statement
  static void dbugPrint(String msg) {
    debugPrint(msg);
  }

  // show custom toast
  static showCustomToast({
    String msg = AppString.issueOccurred,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
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
    showCustomToast(msg: "Text copied", toastColor: AppColors.greyColor);
  }

  static showLoder({required BuildContext context}) {
    CustomLoader.showLoader(
      context: context,
      backgroundColor: AppColors.blackColor.withOpacity(.8),
      loderHeight: 120.h,
      loaderDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDecoration.radius10),
        color: AppColors.primaryColor.withOpacity(.7),
      ),
      loaderWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(ImageConstant.colorfullLoder, height: 60),
          CustomText(
            text: "Loading",
            style: AppTextStyles.nunito15W700H1_4.copyWith(
              color: AppColors.warningColor,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  static dismissLoder() {
    CustomLoader.dismisLoader();
  }
}
