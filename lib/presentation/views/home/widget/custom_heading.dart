import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeading extends StatelessWidget {
  final String headingText;
  final TextStyle? headingStyle;
  const CustomHeading({
    super.key,
    required this.headingText,
    this.headingStyle
    });

  @override
  Widget build(BuildContext context) {
    return CustomText(
          text: headingText,
          style: headingStyle ?? AppTextStyles.nunito18W700H1_4.copyWith(fontSize: 20.sp),
       );
  }
}