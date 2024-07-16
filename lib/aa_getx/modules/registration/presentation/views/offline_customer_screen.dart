import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/offline_customer_controller.dart';

class OfflineCustomerView extends GetView<OfflineCustomerController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => OnBackPress.onBackPressDialog(1, Strings.exit_app),
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
                child: Text(Strings.yourLoanApplicationIsUnderProcessString,
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