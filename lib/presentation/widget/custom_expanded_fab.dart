import 'package:converter_hub/core/app_imports.dart';

import '../../config/app_config.dart';

class CustomExpandedFAB extends StatelessWidget {
  final Color? bgColor;
  final Color? iconColor;
  final bool isExpand;
  final IconData fabIcon;
  final VoidCallback fabTap;
  final List<ExpandedFABItem>? expandedFAB;
  final TextStyle? lableStyle;
  final double? radius;
  final double? rightMargin;
  const CustomExpandedFAB({
    super.key,
    this.bgColor = AppColors.whiteColor,
    this.iconColor = AppColors.primaryColor,
    this.lableStyle,
    this.expandedFAB,
    this.radius,
    this.rightMargin = 0,
    required this.fabTap,
    this.isExpand = false,
    required this.fabIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: "btn",
            onPressed: fabTap,
            backgroundColor: bgColor,
            child: Icon(fabIcon, color: iconColor),
          ),
        ),
        if (isExpand && expandedFAB != null && expandedFAB!.isNotEmpty) ...[
          Positioned(
            bottom: 60,
            right: rightMargin,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(expandedFAB!.length, (index) {
                final singleItem = expandedFAB![index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: _buildExpandedFAB(
                    icon: singleItem.icon,
                    tag: "btn$index",
                    label: singleItem.label,
                    onTap: singleItem.onTap,
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildExpandedFAB({
    required IconData icon,
    required String tag,
    String? label,
    double labelWidth = 70,
    VoidCallback? onTap,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Row(
          children: [
            if (label != null && label.isNotEmpty)
              Transform.scale(
                scale: value,
                alignment: Alignment.center,
                child: SizedBox(
                  width: labelWidth,
                  child: Text(
                    label,
                    style:
                        lableStyle ??
                        TextStyle(
                          fontSize: 16.sp,
                          fontFamily: AppConfig.nunitoFontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            if (label != null && label.isNotEmpty) SizedBox(width: 5.w),
            Transform.scale(
              scale: value,
              alignment: Alignment.center,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15),
                ),
                heroTag: tag,
                onPressed: onTap,
                backgroundColor: bgColor,
                child: Icon(icon, color: iconColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

///model class for expandedFAB
class ExpandedFABItem {
  final IconData icon;
  final String? tag;
  final String? label;
  final VoidCallback? onTap;

  ExpandedFABItem({required this.icon, this.tag, this.label, this.onTap});
}
