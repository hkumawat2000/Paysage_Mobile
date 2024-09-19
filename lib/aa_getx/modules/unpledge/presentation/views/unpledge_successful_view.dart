
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';

///Todo: add loantype in page arguments while redirecting to this screen
// String loanType;
// UnpledgeSuccessfulScreen(this.loanType);
class UnpledgeSuccessfulView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    String loanType = Get.arguments;
    return PopScope(
      onPopInvoked: (_) => OnBackPress.onBackPressDialog(0,Strings.back_btn_disable),
      child: Scaffold(
        backgroundColor: colorBg,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            //verifyEmail(),
            Image(
              image: AssetImage(AssetsImagePath.tutorial_4),
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Strings.success_received,
              style: TextStyle(color: appTheme, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Text(loanType == Strings.shares ? Strings.unpledge_success : Strings.revoke_success,
                style: TextStyle(
                  color: colorLightGray,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 130,
                    color: colorBg,
                    child: Material(
                      color: colorBg,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), side: BorderSide(color: red)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: ()=> Get.offNamed(dashboardView),
                        child: Text(
                          Strings.home,
                          style: TextStyle(color: red),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
