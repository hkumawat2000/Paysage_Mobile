import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/controllers/contact_us_thank_you_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';

import '../../../../core/assets/assets_image_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';

class ContactUsThankYouView extends GetView<ContactUsThankYouController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: null,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FE),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              Image(
                image: AssetImage(AssetsImagePath.tutorial_1),
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(height: 30),
              Text(Strings.thank_you, style: TextStyle(color: appTheme,fontWeight: FontWeight.bold,fontSize: 22)),
              SizedBox(height: 5),
              Text(
                Strings.shortly_touch,
                style:
                TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                height: 45,
                width: 120,
                child: Material(
                  color: Color(0xFFF8F9FE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: red)),
                  elevation: 1.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: red)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Get.offAllNamed(dashboardView, arguments: DashboardArguments(
                        isFromPinScreen: false,
                        selectedIndex: 0,
                      ));
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(color: red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}