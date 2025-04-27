// ignore_for_file: deprecated_member_use, avoid_print

import 'package:converter_hub/core/theme/app_colors.dart';
import 'package:converter_hub/presentation/views/dashboard/category_view.dart';
import 'package:converter_hub/presentation/views/home/home_view.dart';
import 'package:converter_hub/presentation/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> bodyWidget = [HomeView(), CategoryView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 800),
      length: 3,
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(),
        body: TabBarView(children: bodyWidget),
      ),
    );
  }
}

Widget bottomNavBar() {
  return Container(
    height: 65,
    decoration: BoxDecoration(
      color: AppColors.blueColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: TabBar(
      indicatorColor: AppColors.lightPinkColor,
      padding: EdgeInsets.zero,
      onTap: (index) {
        print("current index $index");
      },
      indicatorPadding: EdgeInsets.only(bottom: 60, left: 45, right: 45),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.whiteColor,
      tabs: [
        Tab(text: "Home", icon: Icon(Icons.home)),
        Tab(text: "Category", icon: Icon(Icons.category)),
        Tab(text: "Profile", icon: Icon(Icons.person)),
      ],
    ),
  );
}
