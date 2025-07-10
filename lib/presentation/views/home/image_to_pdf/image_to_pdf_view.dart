// ignore_for_file: use_build_context_synchronously

import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
import 'package:converter_hub/presentation/views/home/image_to_pdf/selected_image_view.dart';
import 'package:converter_hub/presentation/widget/custom_expanded_fab.dart';
import 'package:converter_hub/provider/image_to_pdf_provider.dart';

class ImageToPdfView extends StatefulWidget {
  const ImageToPdfView({super.key});

  @override
  State<ImageToPdfView> createState() => _ImageToPdfViewState();
}

class _ImageToPdfViewState extends State<ImageToPdfView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageToPdfProvider(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          isBackBtnVisible: true,
          title: AppString.imageToPdf,
          titleStyle: AppTextStyles.nunito18W700H1_4.copyWith(
            color: AppColors.whiteColor,
          ),
          isTitleCentered: true,
          appBarColor: AppColors.primaryColor,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: CustomImage(
                  image: ImageConstant.cloudUploadIc,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              CustomText(
                text: AppString.uploadOrPickImageFromDevice,
                style: AppTextStyles.nunito16W500H1_4,
              ),

              SizedBox(height: 70.h),
            ],
          ),
        ),

        floatingActionButton: Consumer<ImageToPdfProvider>(
          builder: (context, imageToPdfProvider, child) {
            return CustomExpandedFAB(
              fabIcon: imageToPdfProvider.isExapnded ? Icons.clear : Icons.add,
              fabTap: () {
                imageToPdfProvider.isExapnded = !imageToPdfProvider.isExapnded;
                imageToPdfProvider.update();
              },
              isExpand: imageToPdfProvider.isExapnded,

              expandedFAB: [
                ExpandedFABItem(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () async {
                    await ImagePickerHelper.pickImage().then((value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    SelectedImageView(imageList: value),
                          ),
                        );
                      }
                    });
                  },
                ),
                ExpandedFABItem(
                  icon: Icons.image,
                  label: "Gallery",
                  onTap: () {},
                ),
                ExpandedFABItem(
                  icon: Icons.folder,
                  label: "Multiple",
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
