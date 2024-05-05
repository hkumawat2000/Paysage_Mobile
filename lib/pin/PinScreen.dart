import 'dart:async';
import 'package:choice/forgot_pin/ForgotPinScreen.dart';
import 'package:choice/login/LoginScreen.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/registration/RegistrationBloc.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../registration/OfflineCustomerScreen.dart';

class PinScreen extends StatefulWidget {
  bool isComingFromMore;

  PinScreen(this.isComingFromMore);

  @override
  PinScreenState createState() => PinScreenState();
}

class PinScreenState extends State<PinScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = Preferences();
  var savePin;
  // var kycComplete;
  String? enterPin;
  // var loanNo;
  var mobileNumber;
  final registrationBloc = RegistrationBloc();
  Utility utility = new Utility();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  var isFingerSupport = false;
  var isFingerEnable = false;
  List<BiometricType> availableBiometricType = <BiometricType>[];
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool isSubmitBtnClickable = true;
  String? versionName;
  bool _obscureText = true;
  bool hideShowText = false;
  var email, token, firebaseTokenExist;

  @override
  void initState() {
    fetchValues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchValues() async {
    String version = await Utility.getVersionInfo();
    String emailExist = await preferences.getEmail();
    String tokenExist = await preferences.getToken();
    String firebaseToken = await preferences.getFirebaseToken();
    String savePinSrt = await preferences.getPin();
    // bool kycCompleteSrt = await preferences.getUserKYC();
    // String? loanNoSrt = await preferences.getLoanApplicationNo();
    String? mobileNumberSrt = await preferences.getMobile();
    setState(() {
      versionName = version;
      email = emailExist;
      token = tokenExist;
      firebaseTokenExist = firebaseToken;
      savePin = savePinSrt;
      // kycComplete = kycCompleteSrt;
      // loanNo = loanNoSrt;
      mobileNumber = mobileNumberSrt;
    });
    if(savePin != null && savePin.isNotEmpty) {
      getFingerPintInfo();
    }
  }


  getFingerPintInfo() async {
    bool isEnableFingerprint = await preferences.getFingerprintEnable();
    bool isSupportFingerprint = await utility.getBiometricsSupport();
    availableBiometricType = await utility.getAvailableSupport();
    setState((){
      isFingerSupport = isSupportFingerprint;
      isFingerEnable = isEnableFingerprint;
    });
    printLog('isFingerSupport ===> $isFingerSupport');
    printLog('isFingerEnable ===> $isFingerEnable');
    printLog('availableBiometricType ===> ${availableBiometricType.length}');

    if(isFingerSupport && isFingerEnable && availableBiometricType.length != 0 && !widget.isComingFromMore) {
      isFingerPrintSupport();
    }
  }

  Future<void> isFingerPrintSupport() async {
    bool isAuthenticated = await utility.authenticateMe();
    if (isAuthenticated) {
      Utility.isNetworkConnection().then((isNetwork) async {
        if (isNetwork) {
          String currentSavePin = await preferences.getPin();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
            reFreshFirebaseToke(currentSavePin, Strings.biometric);
          });
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
    } else {
      printLog("====> Cancel by user <====");
    }
  }

  // Future<bool> authenticateMe() async {
  //   try {
  //     return await _localAuthentication.authenticate(
  //         localizedReason: 'Touch your finger on sensor to login',
  //         useErrorDialogs: false,
  //         stickyAuth: false,
  //         biometricOnly: true,
  //         androidAuthStrings: AndroidAuthMessages(
  //           signInTitle: "Login to spark.loans",
  //         )
  //     );
  //   } on PlatformException catch (e) {
  //     if(e.code == auth_error.lockedOut){
  //       Utility.showToastMessage("Too many attempts. Try again after 30 seconds");
  //     } else if(e.code == auth_error.permanentlyLockedOut) {
  //       Utility.showToastMessage("Too many incorrect attempts. Biometric authentication is disabled,until the user unlocks with strong authentication.");
  //     } else {
  //       Utility.showToastMessage(e.message.toString());
  //     }
  //     printLog("Attempt failed ==> ${e.message}");
  //     printLog("exception code ==> ${e.code}");
  //     return false;
  //   }
  // }

  void getPinApi() async {
    if (enterPin.toString().length < 4) {
      Utility.showToastMessage(Strings.message_valid_PIN);
    } else {
      LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
      await reFreshFirebaseToke(enterPin!, Strings.pin);
    }
  }

  reFreshFirebaseToke(String pin, String isComingFor) async {
    await FirebaseMessaging.instance.deleteToken();
    String? token = await FirebaseMessaging.instance.getToken();
      if(firebaseTokenExist == token) {
        printLog("=========================================================================");
        printLog("Token not refreshed");
        printLog("=========================================================================");
        reFreshFirebaseToke(pin, isComingFor);
      } else {
        printLog("New token created :: $token");
        getPinAPICall(mobileNumber, pin, token, isComingFor);
      }

    // Future.delayed(const Duration(milliseconds: 800), () {
    //   FirebaseMessaging.instance.getToken().then((token) {
    //     printLog("New token :: $token");
    //     if(firebaseTokenExist == token) {
    //       printLog("=========================================================================");
    //       printLog("First Time Token not refreshed");
    //       printLog("=========================================================================");
    //       Future.delayed(const Duration(milliseconds: 800), () {
    //         FirebaseMessaging.instance.getToken().then((firstToken) {
    //           if(firebaseTokenExist == firstToken) {
    //             printLog("=========================================================================");
    //             printLog("Second Time Token not refreshed");
    //             printLog("=========================================================================");
    //             Future.delayed(const Duration(milliseconds: 600), () {
    //               FirebaseMessaging.instance.getToken().then((secondToken) {
    //                 if(firebaseTokenExist == secondToken) {
    //                   printLog("=========================================================================");
    //                   printLog("Third Time Token not refreshed");
    //                   printLog("=========================================================================");
    //                   Future.delayed(const Duration(milliseconds: 800), () {
    //                     FirebaseMessaging.instance.getToken().then((thirdToken) {
    //                       if(firebaseTokenExist == thirdToken) {
    //                         printLog("=========================================================================");
    //                         printLog("Fourth Time Token not refreshed");
    //                         printLog("=========================================================================");
    //                       }
    //                       printLog("New token created :: $thirdToken");
    //                       getPinAPICall(mobileNumber, pin, thirdToken, isComingFor);
    //                     });
    //                   });
    //                 }
    //                 printLog("New token created :: $secondToken");
    //                 getPinAPICall(mobileNumber, pin, secondToken, isComingFor);
    //               });
    //             });
    //           } else {
    //             printLog("New token created :: $firstToken");
    //             getPinAPICall(mobileNumber, pin, firstToken, isComingFor);
    //           }
    //         });
    //       });
    //     } else {
    //       getPinAPICall(mobileNumber, pin, token, isComingFor);
    //     }
    //   });
    // });
  }

  getPinAPICall(mobileNumber, enterPin, token, isComingFor){
    preferences.setFirebaseToken(token!);
    registrationBloc.getPin(mobileNumber, enterPin, token).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileNumber;
        parameter[Strings.email] = email;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(isComingFor == "PIN"){
          firebaseEvent(Strings.log_in_with_pin, parameter);
        } else {
          firebaseEvent(Strings.log_in_with_biometric, parameter);
        }

        if (value.data!.customer != null) {
          preferences.setCamsEmail(value.data!.customer!.camsEmailId ?? "");
          preferences.setToken(value.data!.token!);
          // preferences.setCustomer(value.data);
          preferences.setFullName(value.data!.customer!.firstName.toString() + " " + value.data!.customer!.lastName.toString());
          // preferences.setUserKYC(value.data!.customer!.kycUpdate == 1 ? true : false);
          preferences.setEmail(value.data!.customer!.user!);
          preferences.setPin(enterPin);
        }
        // Utility.showToastMessage(value.message!);
        _localAuthentication.stopAuthentication();
        if(value.data!.customer!.offlineCustomer == 1 && value.data!.customer!.loanOpen == 0){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
        }else{
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(isFromPinScreen: true)));
        }
      } else {
        Utility.showToastMessage(value.errorMessage ?? Strings.something_went_wrong);

        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileNumber;
        parameter[Strings.email] = email;
        parameter[Strings.error_message] = value.errorMessage;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(isComingFor == "PIN"){
          firebaseEvent(Strings.log_in_with_pin_failed, parameter);
        } else {
          firebaseEvent(Strings.log_in_with_biometric_failed, parameter);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: colorBg,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  AppIcon(),
                  SizedBox(
                    height: 30,
                  ),
                  headingText(Strings.enter_four_digit_pin),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: PinCodeTextField(
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                      cursorColor: appTheme,
                      appContext: context,
                      textStyle: TextStyle(fontSize: mediumText_24, fontWeight: regular, color: colorDarkGray),
                      keyboardType: TextInputType.number,
                      backgroundColor: colorBg,
                      length: 4,
                      showCursor: true,
                      obscuringCharacter: '*',
                      obscureText: _obscureText,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          inactiveColor: colorGrey,
                          selectedColor: appTheme,
                          activeColor: appTheme,
                          disabledColor: colorGrey,
                          borderWidth: 2),
                      onCompleted: (pin) {
                        enterPin = pin;
                        if (enterPin!.length >= 4) {
                          isSubmitBtnClickable = false;
                          getPinApi();
                        } else {
                          isSubmitBtnClickable = true;
                        }
                      },
                      onChanged: (value) {
                        printLog(value);
                        if (value.length >= 4) {
                          isSubmitBtnClickable = false;
                        } else if (value.length == 0) {
                          hideShowText = false;
                        } else {
                          isSubmitBtnClickable = true;
                          hideShowText = true;
                        }
                        setState(() {});
                      },
                      beforeTextPaste: (text) {
                        if(text!.contains(new RegExp(r'[A-Za-z~!@#$%^&*()_+`"{}|<>?;:./,= ]'))){
                          return false;
                        }
                        return true;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: hideShowText,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_obscureText ? Strings.show : Strings.hide,
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      isFingerPrintSupport();
                    },
                    child: Visibility(
                      visible: isFingerSupport && isFingerEnable && availableBiometricType.length != 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage(AssetsImagePath.biometric),
                              width: 16, height: 16, color: colorBlack),
                          SizedBox(width: 4),
                          Text(Strings.login_with_biometric),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: isSubmitBtnClickable == true ? colorLightGray : appTheme,
                      child: AbsorbPointer(
                        absorbing: isSubmitBtnClickable,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                if (enterPin != null) {
                                  getPinApi();
                                } else {
                                  Utility.showToastMessage(Strings.message_valid_PIN);
                                }
                              } else {
                                showSnackBar(_scaffoldKey);
                              }
                            });
                          },
                          child: ArrowForwardNavigation(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(Strings.register_with_another_account),
                      GestureDetector(
                          onTap: () async {
                            FirebaseMessaging.instance.deleteToken();
                            _localAuthentication.stopAuthentication();
                            bool? accountPermission = await preferences.getEmailDialogConsent();
                            bool? photoPermission = await preferences.getPhotoConsent();
                            bool? biometricPermission = await preferences.getBiometricConsent();
                            bool? biometricEnable = await preferences.getFingerprintEnable();
                            bool? biometricConsent = await preferences.getFingerprintConsent();
                            await preferences.clearPreferences();
                            preferences.setIsVisitTutorial("true");
                            preferences.setFingerprintConsent(biometricConsent);
                            preferences.setEmailDialogConsent(accountPermission!);
                            preferences.setPhotoConsent(photoPermission);
                            preferences.setBiometricConsent(biometricPermission);
                            preferences.setFingerprintEnable(biometricEnable);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          },
                          child: Text(Strings.register,
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          _localAuthentication.stopAuthentication();
                          Navigator.push(
                              context, MaterialPageRoute(builder: (BuildContext context) => ForgotPinScreen()));
                        } else {
                          showSnackBar(_scaffoldKey);
                        }
                      });
                    },
                    child: Text(Strings.forget_pin,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  version(),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget version() {
    return Center(
      child: Text("Version $versionName"),
    );
  }

}
