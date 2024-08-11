import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/pin_screen_arguments.dart';
import 'package:lms/util/Preferences.dart';
import 'package:local_auth/local_auth.dart';

class SettingsMenuController extends GetxController {
  final ConnectionInfo _connectionInfo;

  SettingsMenuController(this._connectionInfo);

  RxBool isPaymentExpansion = false.obs;
  RxBool isSecurityExpansion = false.obs;
  RxBool isAccountExpansion = false.obs;
  RxBool isReminderExpansion = false.obs;
  RxBool isAddressExpansion = false.obs;
  RxBool isKYCExpansion = false.obs;
  RxBool isHelpFaqExpansion = false.obs;
  RxBool isSignOutExpansion = false.obs;
  RxBool isUserEnableFingerprint = false.obs;
  RxBool isFingerEnable = false.obs;
  RxBool isFingerSupport = false.obs;

  RxString instrumentType = "".obs;
  RxString loanApplicationStatus = "".obs;
  RxString pledgeBoid = "".obs;
  RxString myCamsEmail = "".obs;
  RxString loanName = "".obs;
  RxString doesPinExist = "".obs;
  RxString doesMobileExist = "".obs;

  final ExpansionTileController expansionTileSecuritycontroller = ExpansionTileController();
  final ExpansionTileController expansionTileAccountcontroller = ExpansionTileController();
  final ExpansionTileController expansionTileKYCcontroller = ExpansionTileController();
  final ExpansionTileController expansionTileFAQcontroller = ExpansionTileController();
  final GlobalKey expansionTileSecurity = new GlobalKey();
  final GlobalKey expansionTileAccount = new GlobalKey();
  final GlobalKey expansionTileKYC = new GlobalKey();
  final GlobalKey expansionTileFAQ = new GlobalKey();

  List<BiometricType> availableBiometricType = <BiometricType>[];
  Preferences preferences = Preferences();
  Utility utility = Utility();

  @override
  void onInit() {
    fetchDataFromPref();
    super.onInit();
  }

  Future<void> fetchDataFromPref() async {
    doesPinExist.value = await preferences.getPin();
    doesMobileExist.value = (await preferences.getMobile())!;
    isFingerSupport.value = await utility.getBiometricsSupport();
    isUserEnableFingerprint.value = await preferences.getFingerprintEnable();
    availableBiometricType = await utility.getAvailableSupport();
    isFingerEnable.value = await preferences.getFingerprintEnable();

    if (availableBiometricType.isEmpty) {
      isFingerEnable.value = false;
      preferences.setFingerprintEnable(false);
    }
  }

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );


  Future<bool> allowBiometricDialog(BuildContext context, bool value) async {
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
                          TextSpan(
                              text:
                                  'Why is LMS asking for use of Biometric Authentication?\n\nUse biometric login with your fingerprint or face for faster and easier access to your account.\n\nPermission can be changed at anytime from the device setting.\n\nIn case of any doubts, please visit our ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      String privacyPolicyUrl =
                                          await preferences
                                              .getPrivacyPolicyUrl();
                                      // printLog("privacyPolicyUrl ==> $privacyPolicyUrl");
                                      //TODO Navigate to T&C
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                              text: "Privacy Policy.",
                              style: boldTextStyle_12_gray_dark.copyWith(
                                  color: Colors.lightBlue)),
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
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                      preferences.setFingerprintConsent(true);
                                      preferences.setBiometricConsent(true);
                                      String email =
                                          await preferences.getEmail();
                                      String? mobile =
                                          await preferences.getMobile();
                                      var isAuthenticated =
                                          await utility.authenticateMe();
                                      if (isAuthenticated) {
                                        Map<String, dynamic> parameters =
                                            new Map<String, dynamic>();
                                        parameters[Strings.mobile_no] = mobile;
                                        parameters[Strings.email] = email;
                                        parameters[Strings.date_time] =
                                            getCurrentDateAndTime();
                                        if (value) {
                                          firebaseEvent(Strings.touch_id_enable,
                                              parameters);
                                        } else {
                                          firebaseEvent(
                                              Strings.touch_id_disable,
                                              parameters);
                                        }
                                        preferences.setFingerprintEnable(true);
                                        isFingerEnable.value = value;
                                      } else {
                                        preferences.setFingerprintEnable(false);
                                      }
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
        ) ??
        false;
  }

  Future<void> logoutConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.SignOut),
          content: const Text(
            Strings.message_sign_out,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(Strings.alert_button_no),
              onPressed: () {
                Navigator.of(context).pop(Strings.alert_button_no);
              },
            ),
            TextButton(
              child: const Text(Strings.alert_button_yes),
              onPressed: () {
                preferences.clearPreferences();
                preferences.setMobile(doesMobileExist.value);
                preferences.setPin(doesPinExist.value);
                // preferences.setLoggedOut("true");
                // preferences.setPAN(panExist);
                // preferences.setDOB(userDOB);
                if (isFingerSupport.isTrue) {
                  if (isUserEnableFingerprint.isTrue) {
                    preferences.setFingerprintEnable(true);
                  }
                }
                Get.offNamedUntil(
                    pinView,
                    arguments: PinScreenArguments(isComingFromMore: false),
                    (route) => false);
                //userLogout(context);
              },
            )
          ],
        );
      },
    );
  }
}
