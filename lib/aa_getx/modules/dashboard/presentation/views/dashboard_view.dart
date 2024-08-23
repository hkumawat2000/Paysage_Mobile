import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPressed,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Obx(() =>controller.children[controller.selectedIndex!.value]),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: bottomNavigationBar,
            ),
          ],
        ),
      ),
    );
  }

  Widget get bottomNavigationBar {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child:  Obx(() =>BottomNavigationBar(
            backgroundColor: colorWhite,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
           // onTap: controller.onItemTapped,
            onTap: (newIndex) => controller.selectedIndex(newIndex),
            items: [
              BottomNavigationBarItem(
                label: "",
                icon: HomeMenuItem(false, Icons.home, text: 'Home'),
                activeIcon: HomeMenuItem(true, Icons.home, text: 'Home'),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 30,
                      child: Image.asset(AssetsImagePath.document,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Securities',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
                activeIcon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 30,
                      child: Image.asset(AssetsImagePath.document,
                          color: appTheme),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Securities',
                      style: TextStyle(fontSize: 10, color: appTheme),
                    )
                  ],
                ),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Text(
                        '₹',
                        style: TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Loans',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
                activeIcon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: appTheme, width: 2)),
                      child: Text(
                        '₹',
                        style: TextStyle(fontSize: 20.0, color: appTheme),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Loans',
                      style: TextStyle(fontSize: 10, color: appTheme),
                    )
                  ],
                ),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: HomeMenuItem(false, Icons.menu, text: 'More'),
                activeIcon: HomeMenuItem(true, Icons.menu, text: 'More'),
                // title: Container(),
              ),
            ],
          ),),),
    );
  }
}
