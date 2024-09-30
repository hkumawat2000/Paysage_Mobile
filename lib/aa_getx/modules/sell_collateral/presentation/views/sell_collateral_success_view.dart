
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';

class SellCollateralSuccessView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String loanType = Get.arguments;
    return PopScope(
      canPop: false,
      onPopInvoked: (_)=> OnBackPress.onBackPressDialog(0,Strings.back_btn_disable),
      child: Scaffold(
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: colorBg,
              height: 45,
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Material(
                color: colorBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(color: red)),
                elevation: 1.0,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: red)),
                  onPressed: ()=> Get.offNamed(dashboardView),
                  child: Text(
                    Strings.home,
                    style: buttonTextRed,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage(AssetsImagePath.tutorial_4),
                height: 265.0,
                width: 265.0,
              ),
              SizedBox(height: 14),
              Text(
                Strings.success_received,
                textAlign: TextAlign.center,
                style: boldTextStyle_30,
              ),
              SizedBox(height: 10),
              Text(
                loanType == Strings.shares ? Strings.sell_collateral_success : Strings.invoke_success,
                textAlign: TextAlign.center,
                style: mediumTextStyle_14_gray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}