import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/core/helper/image_picker_helper.dart';
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
              CustomImage(
                image: ImageConstant.cloudUploadIc,
                height: 100.h,
                width: 100.w,
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
                  tag: "tag1",
                  // label: "Camera",
                  onTap: () async {
                    final imageList = await ImagePickerHelper.pickImage();

                    debugPrint("Image is $imageList");
                  },
                ),
                ExpandedFABItem(
                  icon: Icons.image,
                  tag: "tag2",
                  label: "Gallery",
                  onTap: () {},
                ),
                ExpandedFABItem(
                  icon: Icons.folder,
                  tag: "tag3",
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
