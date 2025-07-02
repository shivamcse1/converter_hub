import 'package:flutter/material.dart';
import '../../../core/constant/app_string.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../widget/custom_app_bar.dart';

class ImageToPdfView extends StatefulWidget {
  const ImageToPdfView({super.key});

  @override
  State<ImageToPdfView> createState() => _ImageToPdfViewState();
}

class _ImageToPdfViewState extends State<ImageToPdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        title: AppString.imageToPdf,
        titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
          color: AppColors.whiteColor,
        ),
        isTitleCentered: true,
        appBarColor: AppColors.primaryColor,
      ),

      body: Column(
        children: [

        ],
      ),
    );
  }
}
