import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/widget/custom_image.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryItem extends StatelessWidget {
  final double? elevation;
  final double? height;
  final double? width;
  final Color? backgrounndColor;
  final EdgeInsets? insidePadding;
  final double? radius;
  final String? image;
  final String? text;
  final TextStyle? textStyle;

  const CustomCategoryItem({
    super.key,
    this.elevation = 4,
    this.height = 90,
    this.width = 90,
    this.backgrounndColor,
    this.insidePadding,
    this.radius,
    this.image,
    this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Container(
        padding:
            insidePadding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: backgrounndColor ?? AppColors.lightPinkColor,
          borderRadius: BorderRadius.circular(radius ?? 5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomImage(
              height: height!.h,
              width: width!.w,
              image: image ?? ImageConstant.previewIc,
              imageFit: BoxFit.cover,
            ),

            SizedBox(height: 20),
            CustomText(
              text: text ?? "",
              style:
                  textStyle ??
                  AppTextStyles.nunito16W800H1_4.copyWith(
                    color: AppColors.whiteColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
