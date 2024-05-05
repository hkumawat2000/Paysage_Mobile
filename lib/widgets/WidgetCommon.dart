import 'dart:io';
import 'dart:math';

import 'package:choice/complete_kyc/CompleteKYCScreen.dart';
import 'package:choice/contact_us/ContactUsScreen.dart';
import 'package:choice/my_loan/MarginShortFallScreen.dart';
import 'package:choice/my_loan/MyLoansBloc.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/pin/PinScreen.dart';
import 'package:choice/registration/SetPinscreen.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//App Logo
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.spark_loan_logo,
    );
  }
}

//Used common widget for OTP pop-up heading and sub heading
class HeadingSubHeadingWidget extends StatelessWidget {
  String mainHeading;
  String subHeading;

  HeadingSubHeadingWidget(this.mainHeading, this.subHeading);

  @override
  Widget build(BuildContext context) {
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
}

//Bottom navigator menu item
class HomeMenuItem extends StatelessWidget {
  bool? isActive;
  IconData? icon;
  String? text;

  HomeMenuItem(this.isActive, this.icon, {this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 20,
          height: 30,
          child: Icon(icon, color: isActive! ? appTheme : Colors.grey),
        ),
        SizedBox(height: 2),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10, color: isActive! ? appTheme : Colors.grey),
        )
      ],
    );
  }
}

//Will not print the statement on log in release build
void printLog(String? log){
  if(!kReleaseMode){
    print(log);
  }
}

//Round down to 1000
double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

//Get device info
Future<String>? getDeviceInfo() async{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceManufacturer, deviceModel, oSVersion;
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel = androidInfo.model;
    oSVersion = androidInfo.version.release;
    deviceManufacturer = androidInfo.manufacturer;

    printLog('Manufactured by $deviceManufacturer');
    printLog('Android Version $oSVersion');
    printLog('Device Model $deviceModel');
    return "(Android version : $oSVersion), (Manufacturer : $deviceManufacturer), (Model : $deviceModel)";

  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceModel = iosInfo.model;
    oSVersion = iosInfo.systemVersion;

    printLog('Device Model ${iosInfo.model}');
    printLog('iOS version ${iosInfo.systemVersion}');
    return "(iOS version : $oSVersion) (Model : $deviceModel)";

  }else{
    return " ";
  }
}

//Common Heading Text
Widget headingText(string) {
  return Text(
    string,
    style: boldTextStyle_30,
  );
}

//Common Large Heading Text
Widget largeHeadingText(string) {
  return Text(
    string,
    style: extraBoldTextStyle_30,
  );
}

//Common Medium Heading Text
Widget mediumHeadingText(string) {
  return Text(
    string,
    style: mediumTextStyle_12_gray,
  );
}

//Common Sub Heading Text
Widget subHeadingText(string, {isNeg = false}) {
  return Text(
    string,
    style: boldTextStyle_24.copyWith(color: isNeg ? colorGreen : appTheme),
  );
}

//Common Script Name Text
Widget scripsNameText(string) {
  return Text(
    string,
    style: boldTextStyle_18,
  );
}

//Common Script Value Text
Widget scripsValueText(string) {
  return Text(
    string,
    style: boldTextStyle_18_gray_dark,
  );
}

////Common Bottom Box Text
Widget bottomBoxText(string) {
  return Text(
    string,
    style: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: colorBlack),
  );
}

//Get script initials
String getInitials(String? string, int? limitTo) {
  var buffer = StringBuffer();
  var split = string!.split(' ');
  for (var i = 0 ; i < (limitTo ?? split.length); i ++) {
    buffer.write(split[i][0]);
  }
  return buffer.toString();
}

Future<void> commonDialog(BuildContext context, message, value) {
  /*value 0 = Pop dialog
  value 1 = Complete KYC
  value 2 = Email Verification
  value 4 = Session Timeout
  value 6 = Demat Screen*/
  return showDialog<void>(
    barrierDismissible: value == 5 ? true : false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
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
                                onTap: () => Navigator.pop(context),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      if (value == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CompleteKYCScreen()));
                      } else if (value == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SetPinScreen(false, 0)));
                      } else if (value == 3) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else if (value == 4) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PinScreen(false),
                          ),
                          (route) => false,
                        );
                      } else if (value == 5) {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => DashBoard(),
                          ),
                          (route) => false,
                        );
                      }else if (value == 6) {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DematDetailScreen(2, "", "", "", "")));
                      } else {
                        Navigator.pop(context);
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
      );
    },
  );
}

//My Vault screen back press back dialog
// Future<bool> backConfirmationDialog(BuildContext context) async {
//   return await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15.0))),
//         content: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: new Text(Strings.back_button_validation,
//                       style: regularTextStyle_16_dark),
//                 ), //
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35),
//                           side: BorderSide(color: red)),
//                       elevation: 1.0,
//                       color: colorWhite,
//                       child: MaterialButton(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                         minWidth: MediaQuery.of(context).size.width,
//                         onPressed: () async {
//                           Utility.isNetworkConnection()
//                               .then((isNetwork) {
//                             if (isNetwork) {
//                               Navigator.pop(context);
//                             }else{
//                               Utility.showToastMessage(
//                                   Strings.no_internet_message);
//                             }
//                           });
//                         },
//                         child: Text(
//                           Strings.cancel,
//                           style: buttonTextRed,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Container(
//                     height: 40,
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                         minWidth: MediaQuery.of(context).size.width,
//                         onPressed: () async {
//                           Utility.isNetworkConnection()
//                               .then((isNetwork) {
//                             if (isNetwork) {
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                             }else{
//                               Utility.showToastMessage(
//                                   Strings.no_internet_message);
//                             }
//                           });
//                         },
//                         child: Text(
//                           Strings.okay,
//                           style: buttonTextWhite,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   ) ?? false;
// }


//Back-press of CKYC consent 1/2 screen dialog
Future<bool> backPressYesNoDialog(BuildContext context) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(Strings.sure_go_back,
                      style: regularTextStyle_16_dark),
                ), //
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          side: BorderSide(color: red)),
                      elevation: 1.0,
                      color: colorWhite,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
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
                          Strings.no,
                          style: buttonTextRed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }else{
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Text(
                          Strings.yes,
                          style: buttonTextWhite,
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

//Change Number to String e.g. 1000 => 1,000
String numberToString(String str) {
  return str.replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
}


//For negative value show minus symbol as prefix
String negativeValue(double value) {
  return '-₹${numberToString(value.abs().toStringAsFixed(2))}';
}

//Mask the text
String encryptAcNo(String str) {
  String encStr = "";
  for (int i = 0; i < str.length - 4; i++) {
    encStr += "X";
  }
  return str.replaceRange(2, str.length - 2, encStr);
}

//Round down to 1000
roundDownTo(double amount){
  double result = (amount~/1000) * 1000;
  return result.toStringAsFixed(2);
}


// Widget pledgeCart(totalValue, totalScripts, bool resetValue, totalValueText) {
//   var total_value;
//   String total_scrips;
//   if (totalScripts != 0) {
//     total_value = roundDouble(totalValue, 2);
//     total_scrips = totalScripts.toString();
//   } else {
//     total_value = 0.0;
//     total_scrips = 0.toString();
//   }
//   return Padding(
//     padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//     child: Container(
//       decoration: BoxDecoration(
//         color: colorLightBlue,
//         border: Border.all(color: colorLightBlue, width: 3.0),
//         // set border width
//         borderRadius: BorderRadius.all(
//             Radius.circular(15.0)), // set rounded corner radius
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(
//             height: 10,
//           ),
//           largeHeadingText(total_value < 0
//               ? negativeValue(total_value)
//               : '₹${numberToString(total_value.toStringAsFixed(2))}'),
//           SizedBox(
//             height: 2,
//           ),
//           Text(totalValueText, style: subHeading),
//           SizedBox(
//             height: 14,
//           ),
//           subHeadingText(total_scrips),
//           SizedBox(
//             height: 2,
//           ),
//           Text(Strings.scrips, style: subHeading),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget marginShortFall(
    BuildContext context,
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
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext bc) {
                              return marginShortfallInfo(
                                  context,
                                  loanBalance,
                                  marginShortFallCashAmt,
                                  drawingPower,
                                  minimumPledgeAmount,
                              loanType);
                            });
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

// Widget dematAccountNo(String stockAt) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 20, right: 20),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           Strings.demat_account,
//           style: mediumTextStyle_16_gray,
//         ),
//         Text(
//           encryptAcNo(stockAt),
//           style: mediumTextStyle_16_dark,
//         ),
//       ],
//     ),
//   );
// }

Widget marginShortfallInfo(BuildContext context, loanBalance,
    marginShortFallCashAmt, drawingPower, marginShortfall, loanType) {
  return new Scaffold(
    backgroundColor: Colors.transparent,
    bottomNavigationBar: AnimatedPadding(
      duration: Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
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

//SnackBar for no internet connection
void showSnackBar(final GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackBarContent = SnackBar(
    content: Text(Strings.no_internet_message),
    action: SnackBarAction(
        label: Strings.ok,
        onPressed: _scaffoldKey.currentState!.hideCurrentSnackBar),
    duration: Duration(seconds: 10),
  );
  _scaffoldKey.currentState!.showSnackBar(snackBarContent);
}

//Show SnackBar for dynamic message
void showSnackBarWithMessage(
    final GlobalKey<ScaffoldState> _scaffoldKey, String message) {
  final snackBarContent = SnackBar(
    content: Text(message),
    action: SnackBarAction(
        label: Strings.ok,
        onPressed: _scaffoldKey.currentState!.hideCurrentSnackBar),
    duration: Duration(days: 365),
  );
  _scaffoldKey.currentState!.showSnackBar(snackBarContent);
}

class onBackPressDialog extends StatefulWidget {
  int isExitApp;
  String message;
  @override
  onBackPressDialogState createState() => onBackPressDialogState();
  //isExitApp = 1 == exit app else pop up dialog
  onBackPressDialog(this.isExitApp, this.message);
}

class onBackPressDialogState extends State<onBackPressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(widget.message,
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (widget.isExitApp == 1) {
                      Navigator.pop(context);
                      SystemNavigator.pop();
                    } else {
                      Navigator.pop(context);
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
    );
  }
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

//Common Appbar Back Arrow
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

//Common App Icon
class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsImagePath.app_icon, width: 47, height: 47);
  }
}

//Common height sized box
class SizedBoxHeightWidget extends StatelessWidget {
  final height;

  SizedBoxHeightWidget(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
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

//Common function for firebase event
void firebaseEvent(String eventName, Map<String, dynamic> parameter){
  FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameter);
}

//Get current date and time
String getCurrentDateAndTime(){
  DateTime now = new DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy hh:mm a').format(now);
  return formattedDate;
}


//On click of notification redirect user to particular screen
notificationNavigator(BuildContext context, String screenName, String? loanNumber) async {
  if (screenName == "My Loans") {
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
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        commonDialog(context, value.errorMessage, 0);
      }
    });
  }
}

class StockAtCart extends StatelessWidget {
  String message, stockAt;

  StockAtCart(this.message, this.stockAt);

  @override
  Widget build(BuildContext context) {
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
            stockAt != null && stockAt.isNotEmpty
                ? stockAt.replaceRange(2, stockAt.length - 2, "xxxxxxxxxxxx")
                : "",
            style: TextStyle(color: colorDarkGray, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

////On click of sms link redirect user to particular screen
smsNavigator(BuildContext context, String screenName) async {
  if (screenName == "my_securities") {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DashBoard(selectedIndex: 1)));
  } else if (screenName == "contact_us") {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ContactUsScreen()));
  } else if (screenName == "my_loans") {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DashBoard(selectedIndex: 2)));
  }
  await Preferences().setSmsRedirection("");
}