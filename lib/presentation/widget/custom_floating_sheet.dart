import 'package:converter_hub/core/decoration/app_decoration.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingSheet extends StatelessWidget {
  final Color? iconColor;
  final Color? backgroundColor;
  final double? radius;
  final void Function()? onCopy ;
  final void Function()? onDelete ;
  final void Function()? onShare ;

  const CustomFloatingSheet({
    super.key, 
    this.iconColor, 
    this.backgroundColor, 
    this.radius, 
    this.onCopy, 
    this.onDelete, 
    this.onShare, 
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? AppDecoration.radius10),
        color: backgroundColor ?? AppColors.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onCopy,
            child: Icon(Icons.copy, color: iconColor?? AppColors.primaryColor)),
          InkWell(
            onTap: onShare,
            child: Icon(Icons.share, color: iconColor?? AppColors.primaryColor)),
          InkWell(
            onTap: onDelete,
            child: Icon(Icons.delete, color: iconColor?? AppColors.primaryColor)),
        ],
      ),
    );
  }
}
