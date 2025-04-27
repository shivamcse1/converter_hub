import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/views/dashboard/widget/custom_category_item.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  double elevation = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: false,
        title: "Category",
        isTitleCentered: true,
        appBarColor: AppColors.lightPinkColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            /// First Row Section
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.speechToText2Img,
                      text: "Speech To Text",
                    ),
                  ),

                  SizedBox(width: 20),
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.imageToTextImg,
                      text: "Image To Text",
                    ),
                  ),
                ],
              ),
            ),

            /// Second Row Section
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.textToSpeech2Img,
                      text: "Text To Speech",
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.translationImg,
                      text: "Translation",
                    ),
                  ),
                ],
              ),
            ),

            /// Third Row Section
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.docImg,
                      text: "Image To DOC",
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomCategoryItem(
                      image: ImageConstant.pdfImg,
                      text: "Image To PDF",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
