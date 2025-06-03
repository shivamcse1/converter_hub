import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final bool? focus;
  final bool? readOnly;
  final bool obscureText;
  final String obscuringCharacter;
  final TextAlign? contentAlign;
  final double? height;
  final double? width;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final double? radius;
  final Color? enableBorderColor;
  final Color? backGroundColor;
  final Color? focusBorderColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? contentStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  // final EdgeInsetsGeometry? contentPadding;
  final int? maxDigitLength;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.labelText,
    this.prefix,
    this.suffix,
    this.radius = 10,
    this.enableBorderColor,
    this.focusBorderColor,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.labelStyle,
    this.controller,
    this.keyboardType,
    this.margin,
    this.padding,
    this.focus,
    this.maxDigitLength,
    this.onChanged,
    this.validator,
    this.contentStyle,
    // this.contentPadding,
    this.readOnly,
    this.contentAlign,
    this.backGroundColor,
    this.hintText,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!.r),
      ),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.center,
        textAlign: contentAlign ?? TextAlign.start,
        readOnly: readOnly ?? false,
        style: contentStyle ,
        onChanged: onChanged,
        inputFormatters: [LengthLimitingTextInputFormatter(maxDigitLength)],
        autofocus: focus ?? false,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: hintStyle ?? TextStyle(color: AppColors.greyColor),
          hintText: hintText,
          errorStyle: const TextStyle(height: .1),
          contentPadding: EdgeInsets.symmetric(
              vertical: (height! - 20) / 2 - 2, horizontal: 10.w),
          filled: true,
          fillColor: backGroundColor ?? AppColors.whiteColor,
          suffixIcon: suffix,
          prefixIcon: prefix,
          labelText: labelText,
          labelStyle: labelStyle,
          isDense: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.r),
            borderSide: const BorderSide(color: AppColors.greyColor),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enableBorderColor ?? AppColors.greyColor),
              borderRadius: BorderRadius.circular(radius!.r)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!.r),
              borderSide: BorderSide(color: focusBorderColor ?? AppColors.greyColor)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!.r),
            borderSide: const BorderSide(color: AppColors.errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!.r),
            borderSide: const BorderSide(color: AppColors.errorColor),
          ),
        ),
      ),
    );
  }
}