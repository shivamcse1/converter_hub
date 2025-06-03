import 'package:cached_network_image/cached_network_image.dart';
import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  final String image;
  final String title;
  final String? errorImage;
  final BoxFit imageFit;
  final BoxShape shape;

  const CustomImageView({
    super.key,
    required this.image,
    this.imageFit = BoxFit.contain,
    this.shape = BoxShape.rectangle,
    this.errorImage,
    this.title = "Image View",
  });

  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(image);
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: true,
        backIconColor: AppColors.whiteColor,
        titleStyle: TextStyle(color: AppColors.whiteColor),
        title: title,
        appBarColor: AppColors.primaryColor,
      ),
      body: InteractiveViewer(
        minScale: 1.0,
        // boundaryMargin:
        //     const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        maxScale: 5.0,
        child: Center(
          child: Hero(
              transitionOnUserGestures: true,
              tag: "profile",
              child: uri.hasScheme
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: imageFit,
                      // Placeholder while the image is loading
                      placeholder: (context, imgUrl) {
                        return Container(
                          color: AppColors.whiteColor,
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      },
                      //when any error occur
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          errorImage ?? ImageConstant.previewIc,
                        );
                      },
                    )
                  : (image.endsWith(".jpg") ||
                          image.endsWith(".png") ||
                          image.endsWith(".jpeg") ||
                          image.endsWith(".gif"))
                      ? Image.asset(
                          image,
                          fit: imageFit,
                          errorBuilder: (context, image, error) {
                            return Image.asset(
                              errorImage ?? ImageConstant.previewIc,
                            );
                          },
                        )
                      : image.endsWith(".svg")
                          ? SvgPicture.asset(
                              image,
                              fit: imageFit,
                              placeholderBuilder: (context) {
                                return Container(
                                  color: AppColors.whiteColor,
                                  child: const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                );
                              },
                            )
                          : Image.asset(ImageConstant.previewIc)),
        ),
      ),
    );
  }
}