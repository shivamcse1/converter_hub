import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: false,
        title: "Profile",
        isTitleCentered: true,
        appBarColor: AppColors.lightPinkColor,
      ),
    );
  }
}
