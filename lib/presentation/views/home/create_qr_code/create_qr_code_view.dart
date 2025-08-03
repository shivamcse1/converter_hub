// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:io';

import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
import 'package:converter_hub/core/utils/textfield_validator.dart';
import 'package:converter_hub/presentation/widget/custom_button.dart';
import 'package:converter_hub/presentation/widget/custom_textfield.dart';
import 'package:converter_hub/provider/qr_code_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../data/models/qr_code_model.dart';

class CreateQrCodeView extends StatefulWidget {
  const CreateQrCodeView({super.key});

  @override
  State<CreateQrCodeView> createState() => _CreateQrCodeViewState();
}

class _CreateQrCodeViewState extends State<CreateQrCodeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QrCodeProvider(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: CustomAppBar(
            isBackBtnVisible: true,
            title: AppString.createQrCode,
            titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
              color: AppColors.whiteColor,
            ),
            isTitleCentered: true,
            appBarColor: AppColors.primaryColor,
          ),
          body: Consumer<QrCodeProvider>(
            builder: (context, qrCodeProvider, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  child: Form(
                    key: qrCodeProvider.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Build Qr Data Input Types
                        CustomText(
                          text: AppString.selectQrCodeTypes,
                          style: AppTextStyles.nunito15W700H1_4,
                        ),
                        SizedBox(height: 8.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ValueListenableBuilder(
                            valueListenable: qrCodeProvider.selectedItem,
                            builder: (context, selectedIndex, child) {
                              return Row(
                                children: List.generate(
                                  qrCodeProvider.qrCodeInputType.length,
                                  (index) {
                                    bool isSelcted = selectedIndex == index;
                                    return _buildQrCodeTypesItem(
                                      qrCodeInputData:
                                          qrCodeProvider.qrCodeInputType[index],
                                      onTap: () {
                                        qrCodeProvider.setQrCodeTypesIndes(
                                          index,
                                        );
                                      },
                                      isSelect: isSelcted,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// Main Input Data Containt ///
                        _buildMainInputDataContainer(
                          qrCodeProvider: qrCodeProvider,
                        ),

                        if (qrCodeProvider.isQrCodeGenerated) ...[
                          /// Error Correction Level///
                          SizedBox(height: 20.h),
                          _buildErrorCorrectionLevel(
                            qrCodeProvider: qrCodeProvider,
                          ),

                          /// logo section ///
                          SizedBox(height: 20.h),
                          _buildLogoSection(qrCodeProvider: qrCodeProvider),
                          SizedBox(height: 20.h),

                          _buildQRCode(qrCodeProvider: qrCodeProvider),
                          SizedBox(height: 20.h),
                        ] else ...[
                          SizedBox(height: 20.h),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Consumer<QrCodeProvider>(
            builder: (context, qrCodeProvider, child) {
              return qrCodeProvider.isQrCodeGenerated
                  ? _buildPreviewQRCode(qrCodeProvider: qrCodeProvider)
                  : SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _buildQrCodeTypesItem({
    required QrCodeModel qrCodeInputData,
    VoidCallback? onTap,
    required bool isSelect,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color:
                isSelect
                    ? AppColors.primaryColor.withOpacity(.1)
                    : AppColors.whiteColor,
            border: Border.all(width: .5, color: AppColors.primaryColor),
          ),
          child: Row(
            children: [
              Icon(
                qrCodeInputData.icon,
                size: 20.r,
                color:
                    isSelect ? AppColors.primaryColor : AppColors.darkGreyColor,
              ),
              SizedBox(width: 5.w),
              CustomText(
                text: qrCodeInputData.title,
                style: AppTextStyles.nunito14W700H1_4.copyWith(
                  color:
                      isSelect
                          ? AppColors.primaryColor
                          : AppColors.darkGreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainInputDataContainer({
    required QrCodeProvider qrCodeProvider,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteColor),
      child: Column(
        children: [
          _buildSelectedUi(qrCodeProvider: qrCodeProvider),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: qrCodeProvider.qrCodeNameController,
            hintText: AppString.nameYourQRCode,
          ),
          SizedBox(height: 20.h),

          CustomTextField(
            controller: qrCodeProvider.contentCategoryController,
            hintText: AppString.contentCategory,
          ),
          SizedBox(height: 30.h),
          ValueListenableBuilder(
            valueListenable: qrCodeProvider.isValid,
            builder: (context, value, child) {
              return CustomElevatedButton(
                isLoading: qrCodeProvider.isLoading,
                buttonColor:
                    value && qrCodeProvider.isQrCodeGenerated == false
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(.1),
                buttonTextStyle: AppTextStyles.nunito16W700H1_4.copyWith(
                  color: AppColors.whiteColor,
                ),
                width: 1.sw,
                buttonText: AppString.generateAndDownloadQrCode,
                onTap:
                    value && qrCodeProvider.isQrCodeGenerated == false
                        ? () {
                          qrCodeProvider.generateQRCode(context: context);
                        }
                        : null,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedUi({required QrCodeProvider qrCodeProvider}) {
    final selectedType =
        qrCodeProvider.qrCodeInputType[qrCodeProvider.selectedItem.value];
    qrCodeProvider.selectedType = selectedType;

    switch (selectedType.id) {
      case AppString.link:
      case AppString.snapchat:
      case AppString.telegram:
      case AppString.instagram:
      case AppString.whatsapp:
      case AppString.youtube:
      case AppString.facebook:
      case AppString.github:
      case AppString.linkedin:
      case AppString.text:
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              controller: qrCodeProvider.dataController1,
              validator: (value) {
                if (selectedType.id == AppString.text) {
                  return TextfieldValidator.validateText(text: value);
                } else {
                  return TextfieldValidator.validateUrl(url: value);
                }
              },
              hintText:
                  qrCodeProvider.selectedItem.value == 0
                      ? AppString.putYourLinkUrlHere
                      : qrCodeProvider.selectedItem.value == 1
                      ? AppString.putYourTextHere
                      : "Paste Your ${selectedType.title} ${selectedType.id != AppString.text ? "link" : ""} here",
              prefix: Icon(selectedType.icon, color: AppColors.primaryColor),
            ),
          ],
        );

      case "Phone":
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validatePhone(phone: value);
              },
              controller: qrCodeProvider.dataController1,

              hintText: AppString.phoneNumber,
              keyboardType: TextInputType.phone,
              prefix: Icon(Icons.phone_android, color: AppColors.primaryColor),
            ),
          ],
        );
      case "Sms":
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validatePhone(phone: value);
              },
              controller: qrCodeProvider.dataController1,
              keyboardType: TextInputType.phone,
              hintText: AppString.phoneNumber,
              prefix: Icon(Icons.phone_android, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController2,
              hintText: AppString.textMessage,
              prefix: Icon(selectedType.icon, color: AppColors.primaryColor),
            ),
          ],
        );

      case AppString.email:
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateEmail(email: value);
              },
              controller: qrCodeProvider.dataController1,
              hintText: AppString.emailRecipient,
              prefix: Icon(selectedType.icon, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController2,
              hintText: AppString.subject,
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController3,
              hintText: AppString.bodyText,
              maxLines: 100,
            ),
          ],
        );

      case AppString.map:
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateUrl(url: value);
              },
              controller: qrCodeProvider.dataController1,
              hintText: AppString.googleMapLink,
              prefix: Icon(selectedType.icon, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20.h),

            CustomTextField(
              controller: qrCodeProvider.dataController2,
              keyboardType: TextInputType.phone,

              hintText: AppString.latitude,
              prefix: Icon(Icons.location_on, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20.h),

            CustomTextField(
              controller: qrCodeProvider.dataController3,
              keyboardType: TextInputType.phone,
              hintText: AppString.longitude,
              prefix: Icon(Icons.my_location, color: AppColors.primaryColor),
            ),
          ],
        );

      case AppString.wifi:
        return Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController1,
              hintText: AppString.wifiSSIDName,
              prefix: Icon(selectedType.icon, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController2,
              hintText: AppString.wpaWpa2,
            ),
            SizedBox(height: 20.h),

            CustomTextField(
              onChanged: (value) {
                qrCodeProvider.validateInputData();
              },
              validator: (value) {
                return TextfieldValidator.validateText(text: value);
              },
              controller: qrCodeProvider.dataController3,
              hintText: AppString.password,
            ),
          ],
        );

      default:
        return SizedBox();
    }
  }

  Widget _buildQRCode({required QrCodeProvider qrCodeProvider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteColor),
      child: Column(
        children: [
          RepaintBoundary(
            key: qrCodeProvider.qrKey,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(color: AppColors.whiteColor),
              child: Center(
                child: QrImageView(
                  backgroundColor: AppColors.whiteColor,
                  data: qrCodeProvider.qrCodeData,
                  version: QrVersions.auto,
                  errorCorrectionLevel:
                      qrCodeProvider.errorCorrectLevelList[qrCodeProvider
                          .selectedErrorLevelIndex]["value"],
                  size: 250.0,
                  embeddedImage:
                      qrCodeProvider.selectedLogoIndex < 0 &&
                              qrCodeProvider.pickedLogo.isEmpty
                          ? null
                          : qrCodeProvider.pickedLogo.isNotEmpty
                          ? FileImage(File(qrCodeProvider.pickedLogo))
                          : AssetImage(
                            qrCodeProvider.logoList[qrCodeProvider
                                .selectedLogoIndex],
                          ),
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(50, 50)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.secondaryColor.withOpacity(.1),
            ),
            child: Row(
              children: [
                Icon(Icons.verified, color: AppColors.secondaryColor),
                SizedBox(width: 5.w),
                CustomText(
                  text: AppString.great,
                  style: AppTextStyles.nunito15W700H1_4.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(width: 5.w),

                CustomText(
                  text: AppString.yourCodeEasyToScan,
                  style: AppTextStyles.nunito15W500H1_4.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          CustomElevatedButton(
            isLoading: qrCodeProvider.isLoading,
            width: 1.sw,
            buttonText: AppString.downloadQRCode,
            buttonColor: AppColors.primaryColor,
            buttonTextStyle: AppTextStyles.nunito15W700H1_4.copyWith(
              color: AppColors.whiteColor,
            ),
            onTap: () async {
              await qrCodeProvider.saveQrCode();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCorrectionLevel({required QrCodeProvider qrCodeProvider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.scannabilityLevel,
            style: AppTextStyles.nunito15W700H1_4,
          ),
          CustomText(
            text: "(${AppString.errorCorrectionLevel})",
            style: AppTextStyles.nunito15W500H1_4,
          ),
          SizedBox(height: 10.h),
          CustomText(
            maxLines: 10,
            text: AppString.byChangingTheErrorCorrectionLevelYouCanSimplify,
            style: AppTextStyles.nunito14W500H1_4.copyWith(
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(height: 15.h),

          Wrap(
            children: List.generate(
              qrCodeProvider.errorCorrectLevelList.length,
              (index) {
                final data = qrCodeProvider.errorCorrectLevelList[index];
                return _buildErrorCorrectionItem(
                  isSelect:
                      qrCodeProvider.selectedErrorLevelIndex == index
                          ? true
                          : false,
                  onTap: () {
                    qrCodeProvider.setErrorLevelIndex(index);
                  },
                  index: index,
                  heading: data["heading"],
                  image: data["image"],
                  title: data["title"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCorrectionItem({
    required String image,
    required String heading,
    required String title,
    required int index,
    bool isSelect = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h, right: index % 2 == 0 ? 20.w : 0),
        width: 150.w,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: isSelect ? AppColors.primaryColor : AppColors.lightGreyColor,
          ),
        ),
        child: Column(
          children: [
            CustomImage(image: image, height: 90, width: 90),
            SizedBox(height: 5.h),
            CustomText(
              text: heading,
              style: AppTextStyles.nunito18W700H1_4.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: title,
              maxLines: 10,
              style: AppTextStyles.nunito14W500H1_4.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection({required QrCodeProvider qrCodeProvider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppString.logo,
            style: AppTextStyles.nunito15W700H1_4,
          ),
          SizedBox(height: 15.h),

          Wrap(
            children: List.generate(qrCodeProvider.logoList.length + 1, (ind) {
              final index = ind != 0 ? ind - 1 : ind;
              final logoPath = qrCodeProvider.logoList[index];
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index != qrCodeProvider.logoList.length - 1 ? 10.w : 0.w,
                ),
                child:
                    ind == 0
                        ? InkWell(
                          onTap: () {
                            qrCodeProvider.clearLogo();
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color:
                                    qrCodeProvider.isLogoClear
                                        ? AppColors.primaryColor
                                        : AppColors.lightGreyColor,
                              ),
                            ),
                            child: Icon(Icons.clear, size: 48),
                          ),
                        )
                        : _buildLogoItem(
                          isSelect:
                              qrCodeProvider.selectedLogoIndex == index
                                  ? true
                                  : false,
                          imagePath: logoPath,
                          onTap: () {
                            qrCodeProvider.setLogoIndex(index);
                          },
                          index: index,
                        ),
              );
            }),
          ),

          SizedBox(height: 10.h),

          InkWell(
            onTap: () async {
              await ImagePickerHelper.imagePickerDialog(
                context: context,
                onCameraTap: () async {
                  await qrCodeProvider.pickLogo(
                    imageSource: ImageSource.camera,
                  );
                  Navigator.pop(context);
                },
                onGalleryTap: () async {
                  await qrCodeProvider.pickLogo(
                    imageSource: ImageSource.gallery,
                  );
                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.primaryColor.withOpacity(.1),
                border: Border.all(color: AppColors.primaryColor),
              ),

              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_upload, color: AppColors.primaryColor),
                    SizedBox(width: 5),
                    CustomText(
                      text: AppString.uploadImage,
                      style: AppTextStyles.nunito14W600H1_4.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoItem({
    required String imagePath,
    VoidCallback? onTap,
    required int index,
    bool isSelect = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: isSelect ? AppColors.primaryColor : AppColors.lightGreyColor,
          ),
        ),
        child: Image.asset(imagePath, width: 48.w),
      ),
    );
  }

  Widget _buildPreviewQRCode({required QrCodeProvider qrCodeProvider}) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 3),
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: QrImageView(
        data: '1234567890',
        version: QrVersions.auto,
        errorCorrectionLevel:
            qrCodeProvider.errorCorrectLevelList[qrCodeProvider
                .selectedErrorLevelIndex]["value"],
        size: 70.0,
        embeddedImage:
            qrCodeProvider.selectedLogoIndex < 0 &&
                    qrCodeProvider.pickedLogo.isEmpty
                ? null
                : qrCodeProvider.pickedLogo.isNotEmpty
                ? FileImage(File(qrCodeProvider.pickedLogo))
                : AssetImage(
                  qrCodeProvider.logoList[qrCodeProvider.selectedLogoIndex],
                ),
      ),
    );
  }
}
