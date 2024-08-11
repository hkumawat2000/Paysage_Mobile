import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/size_config.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/pin_screen_arguments.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';

//Common App Icon
class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsImagePath.app_icon, width: 47, height: 47);
  }
}

class OnBackPress {
  static onBackPressDialog(int isExitApp, String message) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(message,
                      style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
                ), //
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    minWidth: SizeConfig.screenWidth,
                    onPressed: () async {
                      ///isExitApp = 1 == exit app else pop up dialog
                      if (isExitApp == 1) {
                        Get.back();
                        SystemNavigator.pop();
                      } else {
                        Get.back();
                      }
                    },
                    child: Text(
                      Strings.ok,
                      style: TextStyle(
                          color: colorWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
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

//Common Heading Text
Widget headingText(string) {
  return Text(
    string,
    style: boldTextStyle_30,
  );
}

//Common Forward Arrow
class ArrowForwardNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.right_arrow,
      height: 10,
      width: 20,
      color: colorWhite,
    );
  }
}

class ArrowToolbarBackwardNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.back_button,
      height: 17.08,
      width: 8.54,
      color: appTheme,
    );
  }
}

//Get current date and time
String getCurrentDateAndTime() {
  DateTime now = new DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy hh:mm a').format(now);
  return formattedDate;
}

//Common function for firebase event
void firebaseEvent(String eventName, Map<String, dynamic> parameter) {
  FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameter);
}

//Get device info
Future<String>? getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceManufacturer, deviceModel, oSVersion;
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel = androidInfo.model;
    oSVersion = androidInfo.version.release;
    deviceManufacturer = androidInfo.manufacturer;

    debugPrint('Manufactured by $deviceManufacturer');
    debugPrint('Android Version $oSVersion');
    debugPrint('Device Model $deviceModel');
    return "(Android version : $oSVersion), (Manufacturer : $deviceManufacturer), (Model : $deviceModel)";
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceModel = iosInfo.model;
    oSVersion = iosInfo.systemVersion;

    debugPrint('Device Model ${iosInfo.model}');
    debugPrint('iOS version ${iosInfo.systemVersion}');
    return "(iOS version : $oSVersion) (Model : $deviceModel)";
  } else {
    return " ";
  }
}

void showDialogLoading(String message) {
  Get.dialog(
    barrierDismissible: false, // Disable background dismissal
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Container(
        height: 100,
        width: 30, // Adjust width as needed
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20.0), // Spacing between indicator and text
            Text(message),
          ],
        ),
      ),
    ),
  );
}

Future<void> commonDialog(message, value) {
  /*value 0 = Pop dialog
  value 1 = Complete KYC
  value 2 = Email Verification
  value 4 = Session Timeout
  value 6 = Demat Screen*/
  return Get.dialog(
      barrierDismissible: value == 5 ? true : false,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              value != 2
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        value == 4 || value == 5 || value == 6
                            ? SizedBox()
                            : GestureDetector(
                                child: Icon(
                                  Icons.cancel,
                                  color: colorLightGray,
                                  size: 20,
                                ),
                                onTap: () => Get.back(),
                              ),
                      ],
                    )
                  : Container(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(message, style: regularTextStyle_16_dark),
                ), //
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    minWidth: Get.width, // Set minimum width to screen width
                    onPressed: () async {
                      //Todo: replace the following navigation after needed pages are converted into getX
                      if (value == 1) {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             CompleteKYCScreen()));
                      } else if (value == 2) {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             SetPinScreen(false, 0)));
                        Get.toNamed(setPinView,
                            arguments: SetPinArgs(
                                isForOfflineCustomer: false, isLoanOpen: 0));
                      } else if (value == 3) {
                        Get.back();
                        Get.back();
                      } else if (value == 4) {
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => PinScreen(false),
                        //   ),
                        //       (route) => false,
                        // );
                        Get.offNamedUntil(
                          pinView,
                          (route) => false,
                          arguments:
                              PinScreenArguments(isComingFromMore: false),
                        );
                      } else if (value == 5) {
                        Get.back();
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => DashBoard(),
                        //   ),
                        //       (route) => false,
                        // );
                      } else if (value == 6) {
                        Get.back();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DematDetailScreen(2, "", "", "", "")));
                      } else {
                        Get.back();
                      }
                    },
                    child: Text(
                      Strings.ok,
                      style: buttonTextWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}

class RegexValidator {
  static final String emailRegex =
      r'^([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})';
  static final String nameRegex = r'^[a-z A-Z,.\-]+$';
}

class Alert {
  static showSnackBar(
      {required String title, String? description, Widget? icon}) {
    Get.snackbar(
      title,
      description ?? "",
      colorText: colorWhite,
      backgroundColor: appTheme,
      icon: icon,
    );
  }
}

//SnackBar for no internet connection
void showSnackBar(final GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackBarContent = SnackBar(
    content: Text(Strings.no_internet_message),
    action: SnackBarAction(
        label: Strings.ok,
        onPressed: () {
          null;
        }
        // _scaffoldKey.currentState!.hideCurrentSnackBar
        ),
    duration: Duration(seconds: 10),
  );
  //_scaffoldKey.currentState!.showSnackBar(snackBarContent);
}

void showSnackBarWithMessage(
    final GlobalKey<ScaffoldState> _scaffoldKey, String message) {
  final snackBarContent = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: Strings.ok,
      onPressed: () {
        null;
      },
      //  _scaffoldKey.currentState!.hideCurrentSnackBar
    ),
    duration: Duration(days: 365),
  );
  // _scaffoldKey.currentState!.showSnackBar(snackBarContent);
}

//On click of notification redirect user to particular screen
notificationNavigator(
    BuildContext context, String screenName, String? loanNumber) async {
  /// todo: uncomment following code after dashboard screen is completed and call API after my_loan module is completed
  /*if (screenName == "My Loans") {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DashBoard(selectedIndex: 2)));
  } else if (screenName == "Dashboard") {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DashBoard()));
  } else if (screenName == "Margin Shortfall Action") {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    final myLoansBloc = MyLoansBloc();
    myLoansBloc.getLoanDetails(loanNumber).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        if(value.data!.marginShortfall == null){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => DashBoard(selectedIndex: 2)));
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => MarginShortfallScreen(
                  value.data!,
                  value.data!.pledgorBoid!,
                  value.data!.sellCollateral == null ? true : false,
                  value.data!.marginShortfall!.status == "Sell Triggered" ? true : false,
                  value.data!.marginShortfall!.status == "Request Pending" ? true : false,
                  value.data!.marginShortfall!.actionTakenMsg ?? "",
                  value.data!.loan!.instrumentType!, value.data!.loan!.schemeType!)));
        }
      } else if (value.errorCode == 403) {
        commonDialog(Strings.session_timeout, 4);
      } else {
        commonDialog(value.errorMessage, 0);
      }
    });
  }*/

  //Mask the text
}

String encryptAcNo(String str) {
  String encStr = "";
  for (int i = 0; i < str.length - 4; i++) {
    encStr += "X";
  }
  return str.replaceRange(2, str.length - 2, encStr);
}

