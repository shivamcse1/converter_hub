// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:io';
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/data/models/pdf_image_model.dart';
import '../../../../provider/image_to_pdf_provider.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';

class PdfSaveView extends StatefulWidget {
  const PdfSaveView({super.key});

  @override
  State<PdfSaveView> createState() => _PdfSaveViewState();
}

class _PdfSaveViewState extends State<PdfSaveView> {
  late ImageToPdfProvider provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = context.read<ImageToPdfProvider>();
      provider.scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageToPdfProvider>(
      builder: (context, imageToPdfProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: CustomAppBar(
            title: imageToPdfProvider.pdfName,
            actions: [
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: IconButton(
                  onPressed: () {
                    imageToPdfProvider.pdfNameController.text =
                        imageToPdfProvider.pdfName;
                    _showNameEditDialog(pdfProvider: imageToPdfProvider);
                  },
                  icon: Icon(Icons.edit, color: AppColors.whiteColor),
                ),
              ),

              InkWell(
                onTap: () {},
                child: Icon(Icons.more_vert, color: AppColors.whiteColor),
              ),

              SizedBox(width: 15.w),
            ],
          ),

          body: GridView.builder(
            controller: imageToPdfProvider.pdfScrollController,
            itemCount: imageToPdfProvider.pdfImages.length + 1,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.w,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: .78,

              /// this is equal to width/height 80% width 100% height hogi
            ),
            itemBuilder: (context, index) {
              if (index == imageToPdfProvider.pdfImages.length) {
                return addImageBox(pdfProvider: imageToPdfProvider);
              }
              final imageData = imageToPdfProvider.pdfImages[index];
              return _buildPdfImageItem(index: index, pdfImages: imageData);
            },
          ),

          bottomNavigationBar: _buildBottomBar(pdfProvider: imageToPdfProvider),
        );
      },
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
            controller: pdfProvider.pdfNameController,
            suffix: InkWell(
              onTap: () {
                pdfProvider.pdfNameController.clear();
                pdfProvider.update();
              },
              child: Icon(Icons.cancel, color: AppColors.greyColor),
            ),
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
              onTap: () {
                pdfProvider.pdfName = pdfProvider.pdfNameController.text;
                pdfProvider.update();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPdfImageItem({
    required int index,
    required PdfImageModel pdfImages,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            image: DecorationImage(
              image: FileImage(File(pdfImages.image.path)),
            ),
            borderRadius: BorderRadius.circular(AppDecoration.radius12),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blackColor.withOpacity(.3),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(AppDecoration.radius12),
                bottomLeft: Radius.circular(AppDecoration.radius12),
              ),
            ),
            padding: EdgeInsets.only(left: 35.w, bottom: 5, top: 5),
            child: CustomText(
              text: pdfImages.imageName.substring(7),
              style: AppTextStyles.nunito14W700H1_4.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppDecoration.radius12),
                bottomLeft: Radius.circular(AppDecoration.radius12),
              ),
              color: AppColors.warningColor,
            ),
            child: CustomText(
              text: "${index + 1}",
              style: AppTextStyles.nunito14W700H1_4.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget addImageBox({required ImageToPdfProvider pdfProvider}) {
    return Material(
      borderRadius: BorderRadius.circular(AppDecoration.radius12),
      child: InkWell(
        onTap: () async {
          await pdfProvider.addImageInPdf(context: context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(AppDecoration.radius12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 40.r, color: AppColors.whiteColor),
              CustomText(
                text: AppString.pickImage,
                style: AppTextStyles.nunito16W700H1_4.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar({required ImageToPdfProvider pdfProvider}) {
    return Material(
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await pdfProvider.addImageInPdf(context: context, isBoth: true);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Icon(Icons.add, color: AppColors.whiteColor),
              ),
            ),

            Expanded(
              child: CustomElevatedButton(
                margin: EdgeInsets.only(left: 20.w),
                buttonColor: AppColors.primaryColor,
                buttonText: AppString.convertToPdf,
                buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                  color: AppColors.whiteColor,
                ),
                onTap: () async {
                  UiHelper.showLoder(context: context);
                  await Future.delayed(Duration(seconds: 1));
                  await pdfProvider.saveToPdf();
                  UiHelper.dismissLoder();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
