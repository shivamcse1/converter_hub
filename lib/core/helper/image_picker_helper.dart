import 'package:converter_hub/core/app_imports.dart';

class ImagePickerHelper {
  static ImagePicker picker = ImagePicker();

  static Future<List<XFile>> pickImage({
    ImageSource? imageSource,
    int imageLimit = 20,
    double maxWidth = 1024,
    int imageQuality = 85,
  }) async {
    try {
      switch (imageSource) {
        case ImageSource.camera:
        case ImageSource.gallery:
          final XFile? image = await picker.pickImage(
            source: imageSource!,
            imageQuality: imageQuality,
            maxWidth: maxWidth,
          );
          if (image != null) {
            return [image];
          }
          return [];
        case null:
          final List<XFile> pickedImages = await picker.pickMultiImage(
            limit: imageLimit,
            imageQuality: imageQuality,
            maxWidth: maxWidth,
          );
          return pickedImages;
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
      return [];
    }
  }

  static void imagePickerDialog({
    required BuildContext context,
    VoidCallback? onCameraTap,
    VoidCallback? onGalleryTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(top: 15.w),
          title: CustomText(
            textAlign: TextAlign.center,
            text: "Selcet Image from",
            style: AppTextStyles.nunito18W500H1_4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDecoration.radius10),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 15.h,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onCameraTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImage(image: ImageConstant.cameraIc),
                    CustomText(
                      text: "Camera",
                      style: AppTextStyles.nunito16W600H1_4,
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: onGalleryTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImage(image: ImageConstant.galleryIc),
                    CustomText(
                      text: "Gallery",
                      style: AppTextStyles.nunito16W600H1_4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
