// ignore_for_file: deprecated_member_use, avoid_print
import 'package:converter_hub/core/app_imports.dart';
import 'package:converter_hub/presentation/views/history/history_view.dart';
import 'package:converter_hub/presentation/views/home/home_view.dart';
import 'package:converter_hub/presentation/views/profile/profile_view.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> bodyWidget = [HomeView(), HistoryView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 500),
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
    height: 60.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
    ),
    child: TabBar(
      indicatorColor: AppColors.secondaryColor,
      padding: EdgeInsets.zero,
      onTap: (index) {
      },
      indicatorPadding: EdgeInsets.only(bottom: 60.h, left: 45.w, right: 45.w),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.primaryColor,
      tabs: [
        Tab(text: AppString.home, icon: Icon(Icons.home)),
        Tab(text: AppString.history, icon: Icon(Icons.history)),
        Tab(text: AppString.profile, icon: Icon(Icons.person)),
      ],
    ),
  );
}
