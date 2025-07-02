// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:converter_hub/core/app_imports.dart';


class ImageToTextView extends StatefulWidget {
  const ImageToTextView({super.key});

  @override
  State<ImageToTextView> createState() => _ImageToTextViewState();
}

class _ImageToTextViewState extends State<ImageToTextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(isTitleCentered: true, title: AppString.imageToText),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Consumer<ImageToTextProvider>(
          builder: (context, imageToTextProvider, child) {
            return imageToTextProvider.pickedImageList.isEmpty &&
                    !imageToTextProvider.isLoading
                /// It execute when pickedimage list is empty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    CustomImage(
                      image: ImageConstant.cloudUploadIc,
                      height: 100.h,
                      width: 100.w,
                    ),
                    CustomText(
                      text: AppString.uploadOrPickImageFromDevice,
                      style: AppTextStyles.nunito16W500H1_4,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomImagePickerDailoge(
                                  onCameraTap: () async {
                                    Navigator.pop(context);
                                    await imageToTextProvider.pickImage(
                                      source: ImageSource.camera,
                                      context: context,
                                    );
                                  },
                                  onGalleryTap: () async {
                                    Navigator.pop(context);
                                    await imageToTextProvider.pickImage(
                                      source: ImageSource.gallery,
                                      context: context,
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppDecoration.radius10,
                                ),
                                color: AppColors.whiteColor,
                              ),
                              child: CustomImage(
                                image: ImageConstant.previewIc,
                                height: 45.h,
                                width: 45.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDecoration.radius10,
                              ),
                              color: AppColors.whiteColor,
                            ),
                            child: CustomImage(
                              image: ImageConstant.pdfImg,
                              height: 45.h,
                              width: 45.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                /// It execute when pickedimage list is not empty
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageToTextProvider.pickedImageList.length,
                          padding: EdgeInsets.zero,

                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 180.h,
                                  width: 100.w,
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: EdgeInsets.only(
                                    right: 10.w,
                                    top: 10.h,
                                  ),
                                  child: Image.file(
                                    imageToTextProvider.pickedImageList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Transform.translate(
                                  offset: Offset(78, -1),
                                  child: InkWell(
                                    onTap: () {
                                      imageToTextProvider.removePickImages(
                                        index: index,
                                        context: context,
                                      );
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: AppColors.blackColor.withOpacity(
                                        .6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        text:
                            "Total image ${imageToTextProvider.pickedImageList.length}",
                        style: AppTextStyles.nunito12W500H1_4,
                      ),

                      SizedBox(height: 20.h),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.h);
                        },
                        itemCount: imageToTextProvider.extractTextList.length,

                        itemBuilder: (context, contentIndex) {
                          return Container(
                            margin:
                                contentIndex ==
                                        imageToTextProvider
                                                .extractTextList
                                                .length -
                                            1
                                    ? EdgeInsets.only(bottom: 80.h)
                                    : null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDecoration.radius10,
                              ),
                              color: AppColors.whiteColor,
                            ),

                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  maxLines: 100,
                                  text:
                                      imageToTextProvider
                                          .extractTextList[contentIndex],
                                  style: AppTextStyles.nunito16W600H1_4,
                                ),

                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: 'Image ${contentIndex + 1}',
                                        style: AppTextStyles.nunito12W500H1_4
                                            .copyWith(
                                              color: AppColors.secondaryColor,
                                            ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        UiHelper.copyData(data: "ram");
                                      },
                                      child: Icon(
                                        Icons.copy,
                                        color: AppColors.primaryColor,
                                        size: 20.r,
                                      ),
                                    ),

                                    SizedBox(width: 40.w),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.share,
                                        color: AppColors.primaryColor,
                                        size: 20.r,
                                      ),
                                    ),
                                    SizedBox(width: 40.w),
                                    InkWell(
                                      onTap: () async {
                                        await imageToTextProvider
                                            .removePickImages(
                                              index: contentIndex,
                                              context: context,
                                            );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.primaryColor,
                                        size: 20.r,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}
