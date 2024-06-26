import 'package:lms/authentication/EnableFingerPrintDialog.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/welcome/NewWelcomeScreen.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../registration/OfflineCustomerScreen.dart';
import '../terms_conditions/TermsConditionWebView.dart';
import '../util/Preferences.dart';
import '../util/Style.dart';
import '../util/Utility.dart';

class FingureprintScreen extends StatefulWidget {
  bool isForOfflineCustomer;
  int isLoanOpen;

  FingureprintScreen(this.isForOfflineCustomer, this.isLoanOpen);

  @override
  State<StatefulWidget> createState() {
    return FingureprintScreenState();
  }
}

class FingureprintScreenState extends State<FingureprintScreen> {
  Preferences preferences = new Preferences();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: fingerprintSetUI(),
    );
  }

  fingerprintSetUI(){
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
            width: 100, height: 100, fit: BoxFit.fill, color: colorLightGray),
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
          onPressed: () async {
            bool consentForBiometric = await preferences.getBiometricConsent();
            if(!consentForBiometric) {
              permissionDialog(context);
            }else{
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  builder: (BuildContext bc) {
                    return EnableFingerPrintDialog(widget.isForOfflineCustomer, widget.isLoanOpen);
                  });
            }
          },
          child: Text(
            Strings.alert_button_yes,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            if (widget.isForOfflineCustomer && widget.isLoanOpen == 0) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RegistrationSuccessfulScreen()));
            }
          },
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

  Future<bool> permissionDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                            ..onTap = () {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  String privacyPolicyUrl = await preferences.getPrivacyPolicyUrl();
                                  printLog("privacyPolicyUrl ==> $privacyPolicyUrl");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  Navigator.pop(context);
                                } else{
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Navigator.pop(context);
                                  preferences.setBiometricConsent(true);
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      enableDrag: false,
                                      builder: (BuildContext bc) {
                                        return EnableFingerPrintDialog(widget.isForOfflineCustomer, widget.isLoanOpen);
                                      });
                                }else{
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
        );
      },
    ) ?? false;
  }

}
