import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


//Common Backward Arrow
class ArrowBackwardNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.left_arrow,
      height: 10.45,
      width: 18.57,
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
        // height: 50,
        // width: 10, // Adjust width as needed
        padding: EdgeInsets.all(8),
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


   showLoadingWithoutBack(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 100,
              width: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: new Row(
                  children: [
                    new CircularProgressIndicator(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: new Text(message),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

//Common Script Name Text
Widget scripsNameText(string) {
  return Text(
    string,
    style: boldTextStyle_18,
  );
}


//Common Sub Heading Text
Widget subHeadingText(string, {isNeg = false}) {
  return Text(
    string,
    style: boldTextStyle_24.copyWith(color: isNeg ? colorGreen : appTheme),
  );
}

//Change Number to String e.g. 1000 => 1,000
String numberToString(String str) {
  return str.replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
}

//For negative value show minus symbol as prefix
String negativeValue(double value) {
  return '-₹${numberToString(value.abs().toStringAsFixed(2))}';
}


//Common width sized box
class SizedBoxWidthWidget extends StatelessWidget {
  final width;

  SizedBoxWidthWidget(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

//Common Medium Heading Text
Widget mediumHeadingText(string) {
  return Text(
    string,
    style: mediumTextStyle_12_gray,
  );
}

String encryptAcNo(String str) {
  String encStr = "";
  for (int i = 0; i < str.length - 4; i++) {
    encStr += "X";
  }
  return str.replaceRange(2, str.length - 2, encStr);
}

class NavigationBackImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.back_button,
      height: 17,
      width: 8.5,
    );
  }
}

Widget marginShortfallInfo(loanBalance,
    marginShortFallCashAmt, drawingPower, marginShortfall, loanType) {
  return new Scaffold(
    backgroundColor: Colors.transparent,
    bottomNavigationBar: AnimatedPadding(
      duration: Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding:
      EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
      child: Container(
        height: 350,
        width: 375,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                Strings.margin_shortfall,
                style: TextStyle(
                    color: appTheme, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Loan Balance",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    loanBalance < 0
                        ? negativeValue(loanBalance)
                        : "₹${numberToString(loanBalance.toStringAsFixed(2))}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: loanBalance < 0 ? colorGreen : colorDarkGray),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Required Drawing Power",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    drawingPower + marginShortFallCashAmt < 0
                        ? negativeValue(drawingPower + marginShortFallCashAmt)
                        : "₹${numberToString((drawingPower + marginShortFallCashAmt).toStringAsFixed(2))}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorDarkGray),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Existing Drawing Power",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    drawingPower < 0
                        ? negativeValue(drawingPower)
                        : "₹${numberToString(drawingPower.toStringAsFixed(2))}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorDarkGray),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    Strings.margin_shortfall,
                    style: TextStyle(
                        color: appTheme,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    marginShortFallCashAmt < 0
                        ? negativeValue(marginShortFallCashAmt)
                        : "₹${numberToString(marginShortFallCashAmt.toStringAsFixed(2))}",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: red),
                  ) ,
                ],
              ),
              SizedBox(
                height: 27,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 120,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: appTheme,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: Get.width,
                        onPressed: ()=> Get.back(),
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget StockAtCart(String message, String stockAt){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(
                color: appTheme, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            stockAt.isNotEmpty
                ? stockAt.replaceRange(2, stockAt.length - 2, "xxxxxxxxxxxx")
                : "",
            style: TextStyle(color: colorDarkGray, fontSize: 18),
          ),
        ],
      ),
    );
}

Widget marginShortFall(
    loanBalance,
    minimumPledgeAmount,
    marginShortFallCashAmt,
    drawingPower,
    image,
    Color iconBg,
    bool isMarginShortfall, String loanType) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(15.0)), // set rounded corner radius
          // make rounded corner of border
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // set rounded corner radius
              ),
              child: Image.asset(
                image,
                width: 40,
                height: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    mediumHeadingText(Strings.margin_shortfall),
                    SizedBox(width: 05),
                    GestureDetector(
                      child: Image.asset(AssetsImagePath.info,
                          height: 12, width: 12),
                      onTap: () {
                        Get.bottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            marginShortfallInfo(
                                  loanBalance,
                                  marginShortFallCashAmt,
                                  drawingPower,
                                  minimumPledgeAmount,
                                  loanType),
                            );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  marginShortFallCashAmt < 0
                      ? negativeValue(marginShortFallCashAmt)
                      : '₹${numberToString(marginShortFallCashAmt.toStringAsFixed(2))}',
                  style: boldTextStyle_24,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showErrorMessage(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}

//Used common widget for OTP pop-up heading and sub heading
Widget HeadingSubHeadingWidget(String mainHeading, String subHeading) {
  return Column(
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            mainHeading,
            style: TextStyle(
                color: appTheme, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            subHeading,
            style: TextStyle(
                color: colorLightGray,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ],
  );
}

class ReusableIconTextContainerCard extends StatelessWidget {
  ReusableIconTextContainerCard(
      {required this.cardText, required this.cardIcon, required this.circleColor});
  final String cardText;
  final Image cardIcon;
  final Color circleColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: cardIcon,
            ),
            Text(
                cardText, style: subHeading
            ),
          ],
        ),
      ),
    );
  }
}


//Common Script Value Text
Widget scripsValueText(string) {
  return Text(
    string,
    style: boldTextStyle_18_gray_dark,
  );
}

//Common Large Heading Text
Widget largeHeadingText(string) {
  return Text(
    string,
    style: extraBoldTextStyle_30,
  );
}

Widget NoDataWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.no_data),
      ],
    ),
  );
}

Widget LoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.please_wait),
        CircularProgressIndicator(),
      ],
    ),
  );
}

Widget ErrorMessageWidget(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(error),
      ],
    ),
  );
}

//Round down to 1000
double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}