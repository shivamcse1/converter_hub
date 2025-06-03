import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
       height: 50.h,
       width: 100.w,
       color: AppColors.greyColor,
     );
  }
}