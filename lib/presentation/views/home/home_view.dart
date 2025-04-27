import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackBtnVisible: false,
        title: "HomeView",
        isTitleCentered: true,
        appBarColor: AppColors.lightPinkColor,
      ),
    );
  }
}
