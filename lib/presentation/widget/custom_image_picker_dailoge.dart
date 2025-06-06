import 'package:converter_hub/core/decoration/app_decoration.dart';
import 'package:converter_hub/presentation/widget/custom_image.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/image_constant.dart';
import '../../core/theme/app_styles.dart';

class CustomImagePickerDailoge extends StatelessWidget {
  final VoidCallback ? onCameraTap ;
  final VoidCallback ? onGalleryTap ;
  const CustomImagePickerDailoge({
    super.key, 
    this.onCameraTap, 
    this.onGalleryTap,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 15.w),
      title: CustomText(
        textAlign: TextAlign.center,
        text: "Selcet Image from",
        style: AppTextStyles.nunito18W500H1_4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDecoration.radius10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onCameraTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(image: ImageConstant.cameraIc),
                CustomText(text: "Camera", style: AppTextStyles.nunito16W600H1_4),
              ],
            ),
          ),

          InkWell(
            onTap: onGalleryTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(image: ImageConstant.galleryIc),
                CustomText(
                  text: "Gallery",
                  style: AppTextStyles.nunito16W600H1_4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
