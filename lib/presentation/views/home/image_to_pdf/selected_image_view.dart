import 'dart:io';
import 'dart:math';

import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/presentation/widget/custom_button.dart';
import 'package:converter_hub/presentation/widget/custom_textfield.dart';
import 'package:converter_hub/provider/image_to_pdf_provider.dart';

class SelectedImageView extends StatefulWidget {
  final List<XFile> imageList;
  const SelectedImageView({super.key, required this.imageList});

  @override
  State<SelectedImageView> createState() => _SelectedImageViewState();
}

class _SelectedImageViewState extends State<SelectedImageView> {
  late ImageToPdfProvider _imageToPdfProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _imageToPdfProvider = Provider.of<ImageToPdfProvider>(
        context,
        listen: false,
      );
      _imageToPdfProvider.update();
    });
  }

  @override
  void dispose() {
    _imageToPdfProvider.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageToPdfProvider(),
      child: Consumer<ImageToPdfProvider>(
        builder: (context, imageToPdfProvider, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: CustomAppBar(
              title: widget.imageList[imageToPdfProvider.currentIndex].name
                  .substring(7),
              actions: [
                IconButton(
                  onPressed: () {
                    imageToPdfProvider.imageNameController.text =
                        widget.imageList[imageToPdfProvider.currentIndex].name;

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
                    itemCount: widget.imageList.length,
                    controller: imageToPdfProvider.pageController,
                    onPageChanged: (index) {
                      imageToPdfProvider.updatePageIndex(index: index);
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double side =
                                constraints.maxWidth < constraints.maxHeight
                                    ? constraints.maxWidth
                                    : constraints.maxHeight;

                            return Transform.rotate(
                              angle: imageToPdfProvider.roationAngle,
                              child: SizedBox(
                                width: side,
                                height: side,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image.file(
                                    File(widget.imageList[index].path),
                                  ),
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
                        imageToPdfProvider.roationAngle =
                            imageToPdfProvider.roationAngle + pi / 2;
                        imageToPdfProvider.update();
                      },
                    ),
                    _buildBottomItem(
                      icon: Icons.rotate_left,
                      label: "Left",
                      onTap: () {
                        imageToPdfProvider.roationAngle =
                            imageToPdfProvider.roationAngle - pi / 2;
                        imageToPdfProvider.update();
                      },
                    ),
                    // Spacer(),
                    CustomElevatedButton(
                      buttonColor: AppColors.primaryColor,
                      buttonText: "Continue",
                      buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                        color: AppColors.whiteColor,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
            SizedBox(width: 20.w),
            Spacer(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDecoration.radius16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text:
                      "Page ${pdfProvider.currentIndex + 1} of ${widget.imageList.length}",
                  style: AppTextStyles.nunito14W600H1_4.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            Spacer(),
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
