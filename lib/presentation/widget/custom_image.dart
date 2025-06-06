import 'package:cached_network_image/cached_network_image.dart';
import 'package:converter_hub/core/constant/image_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final String? errorImage;
  final double height;
  final double width;
  final Color? backgroundColor;
  final BoxFit imageFit;
  final BoxShape shape;
  final BorderRadiusGeometry borderRadius;

  const CustomImage({
    super.key,
    required this.image,
    this.height = 50,
    this.width = 50,
    this.imageFit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.backgroundColor,
    this.errorImage,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(image);
    return uri.hasScheme
        ? shape == BoxShape.circle
            ? ClipOval(
              child: CachedNetworkImage(
                height: height.h,
                width: height.h,
                imageUrl: image,
                fit: imageFit,
                // Placeholder while the image is loading
                placeholder: (context, imgUrl) {
                  return Container(
                    color: AppColors.whiteColor,
                    child: const Center(child: CupertinoActivityIndicator()),
                  );
                },
                //when any error occur
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          shape != BoxShape.circle ? borderRadius : null,
                      color: backgroundColor ?? AppColors.backgroundColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          errorImage ?? ImageConstant.previewIc,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
            : ClipRRect(
              borderRadius: borderRadius,
              child: CachedNetworkImage(
                height: height.h,
                width: width.w,
                imageUrl: image,
                fit: imageFit,
                // Placeholder while the image is loading
                placeholder: (context, imgUrl) {
                  return Container(
                    color: AppColors.whiteColor,
                    child: const Center(child: CupertinoActivityIndicator()),
                  );
                },
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.asset(errorImage ?? ImageConstant.previewIc),
                  );
                },
              ),
            )
        : (image.endsWith(".jpg") ||
            image.endsWith(".png") ||
            image.endsWith(".jpeg") ||
            image.endsWith(".gif"))
        ? Container(
          height: height.h,
          width: shape == BoxShape.circle ? height.h : width.w,
          decoration: BoxDecoration(
            color:
                backgroundColor ??
                (shape == BoxShape.circle
                    ? AppColors.backgroundColor
                    : AppColors.transparentColor),
            borderRadius: shape != BoxShape.circle ? borderRadius : null,
            shape: shape,
            image: DecorationImage(fit: imageFit, image: AssetImage(image)),
          ),
        )
        : image.endsWith(".svg")
        ? Container(
          height: height.h,
          width: shape == BoxShape.circle ? height.h : width.w,
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: shape != BoxShape.circle ? borderRadius : null,
            color:
                backgroundColor ??
                (shape == BoxShape.circle
                    ? Colors.grey.shade300
                    : Colors.transparent),
          ),
          child: SvgPicture.asset(
            image,
            fit: imageFit,
            placeholderBuilder: (context) {
              return Container(
                color: Colors.white,
                child: const Center(child: CupertinoActivityIndicator()),
              );
            },
          ),
        )
        : Container(
          height: height.h,
          width: shape == BoxShape.circle ? height.h : width.w,
          decoration: BoxDecoration(
            borderRadius: shape != BoxShape.circle ? borderRadius : null,
            shape: shape,
            color:
                backgroundColor ??
                (shape == BoxShape.circle
                    ? AppColors.backgroundColor
                    : AppColors.transparentColor),
            image: DecorationImage(
              fit: imageFit,
              image: AssetImage(ImageConstant.imageErrorIc),
            ),
          ),
        );
  }
}
