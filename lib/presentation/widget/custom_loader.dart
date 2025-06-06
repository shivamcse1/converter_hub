// ignore_for_file: deprecated_member_use

import 'package:converter_hub/core/constant/app_string.dart';
import 'package:converter_hub/core/decoration/app_decoration.dart';
import 'package:converter_hub/core/utils/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  static final CustomLoader _instance = CustomLoader._internal();
  factory CustomLoader() => _instance;
  CustomLoader._internal();
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void showLoader({
    required BuildContext context,
    Color? loaderColor,
    Color? backgroundColor,
    Color? indigatorColor,
    double? loderHeight,
    Decoration? loaderDecoration,
    EdgeInsetsGeometry? loaderMargin,
    EdgeInsetsGeometry? loaderPadding,
    AlignmentGeometry? loaderAlign,
    Widget? loaderWidget,
    String? loaderImage,
  }) {
    if (_isShowing) return;

    ///this created the overlay
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: backgroundColor ?? Colors.black.withOpacity(.2),
          child: Align(
            alignment: loaderAlign ?? Alignment.center,
            child: Container(
              height: loderHeight ?? 80.h,
              width: loderHeight ?? 80.w,
              margin: loaderMargin,
              padding: loaderPadding ?? EdgeInsets.all(AppDecoration.radius20),
              decoration:
                  loaderDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDecoration.radius20),
                    color: loaderColor ?? Colors.blueAccent.withOpacity(.4),
                  ),
              child:
                  loaderWidget ??
                  (loaderImage != null
                      ? checkImageType(image: loaderImage)
                      : CircularProgressIndicator(color: indigatorColor)),
            ),
          ),
        );
      },
    );

    ///But this is used to show overlay without this overlay will not be show
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    _isShowing = true;
  }

  static void dismisLoader() {
    try {
      if (_isShowing == false) return;
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isShowing = false;
    } catch (ex) {
      UiHelper.dbugPrint(
        "${AppString.exceptionOccurred} while removing the loader $ex",
      );
    }
  }

  static Widget checkImageType({required String image}) {
    if (image.endsWith('.json')) {
      return Lottie.asset(image);
    } else {
      return CircularProgressIndicator();
    }
  }
}
