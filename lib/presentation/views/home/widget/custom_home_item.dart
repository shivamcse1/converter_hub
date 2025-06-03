import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/widget/custom_image.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeItem extends StatelessWidget {
  final double? height;
  final double? width;
  final TextAlign? textAlign;
  final Color? backgrounndColor;
  final EdgeInsets? insidePadding;
  final EdgeInsets? margin;
  final double? radius;
  final String? image;
  final String? text;
  final TextStyle? textStyle;

  const CustomHomeItem({
    super.key,
    this.height,
    this.width,
    this.backgrounndColor,
    this.insidePadding,
    this.margin,
    this.radius,
    this.image,
    this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      width: width?.w,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 0.w),
      padding:
          insidePadding ??
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: backgrounndColor ?? AppColors.whiteColor,
        borderRadius: BorderRadius.circular(radius?.r ?? 5.0.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            image: image ?? ImageConstant.previewIc,
            imageFit: BoxFit.contain,
          ),

          SizedBox(height: 10.h),
          CustomText(
            maxLines: 2,
            text: text ?? "",
            textAlign: textAlign ?? TextAlign.center,
            style:
                textStyle ??
                AppTextStyles.nunito16W800H1_4.copyWith(
                  color: AppColors.whiteColor,
                ),
          ),
        ],
      ),
    );
  }
}
