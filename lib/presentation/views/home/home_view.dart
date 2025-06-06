import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/core/theme/app_styles.dart';
import 'package:converter_hub/presentation/views/home/widget/custom_home_item.dart';
import 'package:converter_hub/presentation/views/home/widget/custom_heading.dart';
import 'package:converter_hub/presentation/views/home/speech_to_text_view.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  double elevation = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: false,
        title: "Home",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Converter Section
              CustomHeading(headingText: "Converter"),
              SizedBox(height: 15.h),
              Row(
                children: [
                  SizedBox(width: 10.w),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.speechToTextView,
                        );
                      },
                      child: CustomHomeItem(
                        width: 125,
                        radius: 15,
                        backgrounndColor: AppColors.whiteColor,
                        image: ImageConstant.speechToText2Img,
                        text: "Speech \nTo Text",
                        textStyle: AppTextStyles.nunito15W600H1_4,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.imageToTextView);
                      },
                      child: CustomHomeItem(
                        width: 125,
                        radius: 15,
                        image: ImageConstant.imageToTextImg,
                        text: "Image \nTo Text",
                        textStyle: AppTextStyles.nunito15W600H1_4,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.textToSpeechImg,
                      text: "Text \nTo Speech",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.pdf2Img,
                      text: "Image \nTo PDF",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      image: ImageConstant.textSummarizeImg,
                      text: "Text \nSummarize",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      image: ImageConstant.qrCodeImg,
                      text: "QR Code \nGenerator",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.qrCodeScannerImg,
                      text: "QR Code\n Scanner",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.pdfImg,
                      text: "PDF \n To Text",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.videoToMp3Img,
                      text: "Video \n To Mp3",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),

              /// Translator Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: CustomHeading(headingText: "Translator"),
              ),
              CustomHomeItem(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                radius: 15,
                width: double.infinity,
                image: ImageConstant.translationImg,
                text: "A-Z \n One Language To Another",
                textStyle: AppTextStyles.nunito18W700H1_4.copyWith(
                  // fontSize: 18.sp,
                ),
              ),

              /// Compressor section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: CustomHeading(headingText: "Compressor"),
              ),
              Row(
                children: [
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.videoCompress2Img,
                      text: "Compress \nVideo",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),

                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.imageCompressImg,
                      text: "Compress \nImage",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: ImageConstant.compressFile2Img,
                      text: "Compress \nFile(Zip)",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),

              /// Dictionary section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: CustomHeading(headingText: "Dictionary"),
              ),
              Row(
                children: [
                  SizedBox(width: 10.w),

                  Expanded(
                    flex: 1,
                    child: CustomHomeItem(
                      radius: 15,
                      backgrounndColor: AppColors.whiteColor,
                      image: "assets/images/dictionary1_img.png",
                      text: "All \nDictionary",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    flex: 1,
                    child: CustomHomeItem(
                      radius: 15,
                      image: "assets/images/dictionary_img.png",
                      text: "Other \nDictionaries",
                      textStyle: AppTextStyles.nunito15W600H1_4,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: CustomHomeItem(
                        radius: 15,
                        image: "assets/images/dictionary_img.png",
                        text: "Other \nDictionaries",
                        textStyle: AppTextStyles.nunito15W600H1_4,
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
