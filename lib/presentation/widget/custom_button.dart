import 'package:converter_hub/core/decoration/app_decoration.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? radius;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? loderColor;
  final TextStyle? buttonTextStyle;
  final bool? isTextFieldEmpty;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;

  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.height = 50,
      this.width = double.infinity,
      this.radius,
      this.buttonColor,
      this.loderColor = Colors.white,
      this.buttonTextStyle,
      this.isTextFieldEmpty = true,
      this.margin,
      this.isLoading = false,
      this.borderWidth,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height!.h,
      width: width!.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: isTextFieldEmpty == true
                  ? buttonColor ?? AppColors.errorColor
                  : AppColors.errorColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: borderWidth ?? 1,
                      color: borderColor ?? AppColors.errorColor),
                  borderRadius: BorderRadius.circular(radius?.r ?? AppDecoration.radius10))),
          onPressed: onTap,
          child: (isLoading == true)
              ? Visibility(
                  visible: isLoading,
                  child: Container(
                    width: height!.h / 1.5,
                    height: height!.h / 1.18,
                    padding:  EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularProgressIndicator(
                      color: loderColor,
                      // backgroundColor: Colors.whi,
                    ),
                  ))
              : CustomText( text:buttonText,
                  style: isTextFieldEmpty == true
                      ? buttonTextStyle ?? AppTextStyles.nunito16W500H1_4
                      : AppTextStyles.nunito16W500H1_4)),
    );
  }
}

class CustomQuantityButton extends StatelessWidget {
  final VoidCallback? onPlusTap;
  final VoidCallback? onMinusTap;
  final String? quantity;
  final double? height;
  final double? width;
  final double? radius;
  final double? iconSize;
  final Color? buttonColor;
  final Color? iconColor;
  final TextStyle? quantityStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomQuantityButton({
    super.key,
    this.height = 32,
    this.width = 152,
    this.radius,
    this.buttonColor,
    this.quantityStyle,
    this.margin,
    this.onPlusTap,
    this.onMinusTap,
    this.quantity = "1",
    this.padding,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        height: height!.h,
        width: width!.w,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
        decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(radius?.r ?? AppDecoration.radius10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: onMinusTap,
                child: Icon(
                  Icons.remove,
                  color: iconColor ?? AppColors.primaryColor,
                  size: iconSize?.r,
                )),
            CustomText(
             text:  quantity!,
              style: quantityStyle ?? AppTextStyles.nunito16W500H1_4
            ),
            InkWell(
                onTap: onPlusTap,
                child: Icon(
                  Icons.add,
                  color: iconColor ?? AppColors.primaryColor,
                  size: iconSize?.r,
                ))
          ],
        ));
  }
}

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? buttonElevation;
  final Size? minimumSize;
  final double? borderWidth;
  final double? radius;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? loderColor;
  final Color? foregroundColor;
  final MaterialTapTargetSize? tapTargetSize;
  final TextStyle? buttonTextStyle;
  final bool isLoading;
  final OutlinedBorder? buttonShape;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.height,
    this.width,
    this.radius,
    this.buttonColor = Colors.transparent,
    this.loderColor = AppColors.whiteColor,
    this.buttonTextStyle,
    this.margin,
    this.isLoading = false,
    this.borderWidth,
    this.borderColor,
    this.buttonShape,
    this.padding,
    this.minimumSize,
    this.tapTargetSize,
    this.buttonElevation,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        height: height?.h,
        width: width?.w,
        child: TextButton(
          style: TextButton.styleFrom(
              foregroundColor: foregroundColor,
              splashFactory: InkRipple.splashFactory,
              padding: padding,
              elevation: buttonElevation,
              minimumSize: minimumSize,
              backgroundColor: buttonColor,
              tapTargetSize: tapTargetSize,
              shape: buttonShape),
          onPressed: onTap,
          child: (isLoading == true)
              ? Visibility(
                  visible: isLoading,
                  child: Container(
                    width: height!.h / 1.5,
                    height: height!.h / 1.18,
                    padding:  EdgeInsets.symmetric(vertical: 5.h),
                    child: CircularProgressIndicator(
                      color: loderColor,
                      // backgroundColor: Colors.whi,
                    ),
                  ))
              : CustomText(text:buttonText, style: buttonTextStyle),
        ));
  }
}