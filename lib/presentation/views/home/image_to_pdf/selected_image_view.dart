import 'dart:io';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/pdf_save_view.dart';
import 'package:converter_hub/presentation/widget/custom_button.dart';
import 'package:converter_hub/presentation/widget/custom_textfield.dart';
import 'package:converter_hub/provider/image_to_pdf_provider.dart';

class SelectedImageView extends StatefulWidget {
  const SelectedImageView({super.key});

  @override
  State<SelectedImageView> createState() => _SelectedImageViewState();
}

class _SelectedImageViewState extends State<SelectedImageView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageToPdfProvider>(
      builder: (context, imageToPdfProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: CustomAppBar(
            title: imageToPdfProvider
                .pdfImages[imageToPdfProvider.currentIndex]
                .imageName
                .substring(7),
            actions: [
              IconButton(
                onPressed: () {
                  imageToPdfProvider.imageNameController.text =
                      imageToPdfProvider
                          .pdfImages[imageToPdfProvider.currentIndex]
                          .imageName;

                  _showNameEditDialog(pdfProvider: imageToPdfProvider);
                },
                icon: Icon(Icons.edit, color: AppColors.whiteColor),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: AppColors.whiteColor),
              ),
              SizedBox(width: 10.w),
            ],
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: PageView.builder(
                  itemCount: imageToPdfProvider.pdfImages.length,
                  controller: imageToPdfProvider.pageController,
                  onPageChanged: (index) {
                    imageToPdfProvider.updatePageIndex(index: index);
                  },
                  itemBuilder: (context, index) {
                    final imageData = imageToPdfProvider.pdfImages[index];
                    final angle = imageData.rotationAngle;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isPortraitAngle =
                              angle % (2 * 3.141592653589793) == 0;

                          return Center(
                            child: Transform.rotate(
                              angle: angle,
                              child: Image.file(
                                File(imageData.image.path),
                                height:
                                    isPortraitAngle
                                        ? constraints.maxHeight
                                        : null,
                                width:
                                    !isPortraitAngle
                                        ? constraints.maxHeight
                                        : null,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 80.h),
            ],
          ),

          bottomSheet: _builBottomSheet(pdfProvider: imageToPdfProvider),

          bottomNavigationBar: Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomItem(
                    icon: Icons.rotate_right,
                    label: "Right",
                    onTap: () {
                      imageToPdfProvider.updatePdfImageInfo(
                        isLeft: false,
                        isAngle: true,
                      );
                    },
                  ),
                  _buildBottomItem(
                    icon: Icons.rotate_left,
                    label: "Left",
                    onTap: () {
                      imageToPdfProvider.updatePdfImageInfo(
                        isLeft: true,
                        isAngle: true,
                      );
                    },
                  ),
                  // Spacer(),
                  CustomElevatedButton(
                    buttonColor: AppColors.primaryColor,
                    buttonText: "Continue",
                    buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChangeNotifierProvider.value(
                                value: imageToPdfProvider,
                                child: PdfSaveView(),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          SizedBox(height: 2.h),
          CustomText(
            text: label,
            style: AppTextStyles.nunito14W700H1_4.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _builBottomSheet({required ImageToPdfProvider pdfProvider}) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              child: Offstage(
                offstage: pdfProvider.currentIndex == 0,
                child: Card(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      pdfProvider.pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDecoration.radius16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text:
                      "Page ${pdfProvider.currentIndex + 1} of ${pdfProvider.pdfImages.length}",
                  style: AppTextStyles.nunito14W600H1_4.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            Card(
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  pdfProvider.pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                icon: Icon(Icons.arrow_forward, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNameEditDialog({required ImageToPdfProvider pdfProvider}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDecoration.radius16),
          ),
          actionsPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.w,
          ),
          titlePadding: EdgeInsets.only(top: 20.h, left: 15.w),
          title: CustomText(
            text: "Rename",
            style: AppTextStyles.nunito16W700H1_4,
          ),
          content: CustomTextField(
            controller: pdfProvider.imageNameController,
            suffix: Icon(Icons.cancel, color: AppColors.greyColor),
          ),
          actions: [
            CustomTextButton(
              buttonText: "Cancel",
              buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                color: AppColors.errorColor,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            CustomTextButton(
              buttonText: "Save",
              buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                color: AppColors.successColor,
              ),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
