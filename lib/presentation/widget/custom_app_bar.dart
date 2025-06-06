import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackBtn;
  final List<Widget>? actions;
  final TextStyle? titleStyle;
  final double appBarheight;
  final Color? appBarColor;
  final Color? backIconColor;
  final bool isTitleCentered;
  final bool appBarcolorTransparency;
  final bool isBackBtnVisible;
  final Widget? leading;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? leadingPadding;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.actions,
    this.appBarcolorTransparency = false,
    this.titleStyle,
    this.appBarheight = 56,
    this.appBarColor,
    this.backIconColor,
    this.isTitleCentered = false,
    this.onBackBtn,
    this.leading,
    this.titleWidget,
    this.isBackBtnVisible = true,
    this.leadingPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: appBarcolorTransparency,
      toolbarHeight: appBarheight,
      leading:
          leading == null && isBackBtnVisible == true
              ? GestureDetector(
                onTap:
                    onBackBtn ??
                    () {
                      Navigator.pop(context);
                    },
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back,
                    color: backIconColor ?? AppColors.whiteColor,
                  ),
                ),
              )
              : leading ?? const SizedBox(),
      centerTitle: isTitleCentered,
      title:
          titleWidget ??
          CustomText(
            text: title,
            style:
                titleStyle ??
                AppTextStyles.nunito18W700H1_4.copyWith(
                  color: AppColors.whiteColor,
                ),
          ),
      backgroundColor: appBarColor ?? AppColors.primaryColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, appBarheight);
}
