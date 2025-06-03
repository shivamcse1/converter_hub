import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => HistoryViewState();
}

class HistoryViewState extends State<HistoryView> {
  double elevation = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: false,
        title: "History",
        titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
          color: AppColors.whiteColor,
        ),
        isTitleCentered: true,
        appBarColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
