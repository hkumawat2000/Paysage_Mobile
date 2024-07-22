
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/controllers/fingerprint_controller.dart';

class FingerPrintView extends GetView<FingerPrintController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: fingerprintSetUI(),
    );
  }

  fingerprintSetUI() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        AppIcon(),
        SizedBox(
          height: 34,
        ),
        headingText(Strings.set_biometric),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.biometric_id_text,
              style: TextStyle(color: colorLightGray),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Image(image: AssetImage(AssetsImagePath.biometric),
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            color: colorLightGray),
        SizedBox(
          height: 30,
        ),
        MaterialButton(
          color: appTheme,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () => controller.yesClicked(),
          child: Text(
            Strings.alert_button_yes,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => controller.skipClicked(),
          child: Text(Strings.skip),
        ),
        SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            Strings.biometric_id_sub_text,
            style: TextStyle(color: colorLightGray),
          ),
        ),
      ],
    );
  }
}

Future<bool> permissionDialog(FingerPrintController controller) async {
  return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Biometric Access", style: boldTextStyle_16),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Why is LMS asking for use of Biometric Authentication?\n\nUse biometric login with your fingerprint or face for faster and easier access to your account.\n\nPermission can be changed at anytime from the device setting.\n\nIn case of any doubts, please visit our ',style: regularTextStyle_12_gray_dark),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = ()=> controller.privacyPolicyClicked(),
                        text: "Privacy Policy.",
                        style: boldTextStyle_12_gray_dark.copyWith(color: Colors.lightBlue)
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      // width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        elevation: 1.0,
                        color: colorWhite,
                        child: MaterialButton(
                          minWidth: Get.width,
                          onPressed: ()=> controller.denyClicked(),
                          child: Text(
                            "Deny",
                            style: buttonTextRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      // width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          minWidth: Get.width,
                          onPressed: ()=> controller.allowClicked(),
                          child: Text(
                            "Allow",
                            style: buttonTextWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
  ) ?? false;
}