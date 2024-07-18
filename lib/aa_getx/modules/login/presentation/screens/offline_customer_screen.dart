import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class OfflineCustomerScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => Get.dialog(
        onBackPressDialog(1, Strings.exit_app),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsImagePath.app_icon, height: 80, width: 80),
              SizedBox(height: 60),
              // headingText("Under process"),
              Center(
                child: Text("Your loan application is under process.",
                    style: subHeading.copyWith(fontSize: 18),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
