import 'dart:async';
import 'package:choice/login/LoginBloc.dart';
import 'package:choice/login/LoginValidationBloc.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/registration/RegistrationScreen.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../registration/OfflineCustomerScreen.dart';
import '../registration/SetPinscreen.dart';

class OTPVerificationScreen extends StatefulWidget{
  String mobileNumber;
  int acceptTerms;

  @override
  OTPVerificationScreenState createState() => new OTPVerificationScreenState();

  OTPVerificationScreen(this.mobileNumber,this.acceptTerms);
}

class OTPVerificationScreenState extends State<OTPVerificationScreen>
    with TickerProviderStateMixin, CodeAutoFill {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  int _start = 120;
  bool retryAvailable = false;
  AnimationController? controller;
  final loginBloc = LoginBloc();

  String? otpValue;
  final _loginValidatorBloc = LoginValidatorBloc();
  Preferences? preferences;
  var mobileExist, firebase_token;
  bool isResendOTPClickable = true;
  bool isSubmitBtnClickable = true;
  TextEditingController otpController = TextEditingController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              isResendOTPClickable = false;
              retryAvailable = true;
//              Utility.showToastMessage(Strings.expire_otp);
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  String get timerString {
    Duration duration = Duration(seconds: _start);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer!.cancel();
    controller!.dispose();
    _loginValidatorBloc.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
    cancel();
  }

  @override
  void initState(){
    initSmsListener();
    listenForCode();
    preferences = Preferences();
    autoLogin();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
    super.initState();
  }

  Future<void> initSmsListener() async {
    String signature = await SmsAutoFill().getAppSignature;
    print("signature ==> $signature");
    setState(() {});
  }

  @override
  void codeUpdated() {
    if(RegExp(r'^[0-9]+$').hasMatch(code!)){
      otpValue = code;
      otpController.text = code ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            // height: 369,
            // width: 375,
            decoration: new BoxDecoration(
              color: colorWhite,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      Strings.otp_verification,
                      style: TextStyle(
                          color: appTheme, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "${Strings.enter_otp}  ${widget.mobileNumber}",
                        style: TextStyle(
                          color: colorLightGray,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(text: "  "),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pop(context),
                            text: Strings.edit_number,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: HeadingSubHeadingWidget(
                    //       Strings.otp, Strings.enter_otp + " " + "${widget.mobileNumber}"),
                    // ),
                    SizedBox(
                      height: 39,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: PinCodeTextField(
                        controller: otpController,
                        cursorColor: appTheme,
                        appContext: context,
                        textStyle: TextStyle(
                            fontSize: mediumText_24, fontWeight: regular, color: colorDarkGray),
                        backgroundColor: colorWhite,
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        length: 4,
                        obscureText: false,
                        autoFocus: true,
                        animationType: AnimationType.fade,
                        // validator: (v) {
                        //   if (v!.length < 3) {
                        //     return "";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          inactiveColor: colorGrey,
                          selectedColor: appTheme,
                          activeColor: appTheme,
                          disabledColor: colorGrey,
                          borderWidth: 2,
                        ),
                        onCompleted: (otp) {
                          printLog("Completed::$otp");
                          otpValue = otp;
                          if (otpValue!.length >= 4) {
                            isSubmitBtnClickable = false;
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                otpVerify();
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          } else {
                            isSubmitBtnClickable = true;
                          }
                        },
                        onChanged: (value) {
                          printLog("onChange => $value");
                          if (value.length >= 4) {
                            isSubmitBtnClickable = false;
                          } else {
                            isSubmitBtnClickable = true;
                          }
                          setState(() {});
                        },
                        beforeTextPaste: (text) {
                          printLog("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
//                    child: PinEntryTextField(
//                      fields: 4,
//                      showFieldAsBox: false,
//                      onSubmit: (String otp) {
//                        otpValue = otp;
//                        networkCheck.isNetworkConnection().then((isNetwork) {
//                          if (isNetwork) {
//                            otpVerify(otpValue);
//                          } else {
//                            showErrorMessage(Strings.no_internet_message);
//                          }
//                        });
//                      }, // end onSubmit
//                    ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: 140,
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
                                      otpVerify();
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: Text(
                                  Strings.submit,
                                  style: buttonTextWhite
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: AbsorbPointer(
                            absorbing: isResendOTPClickable,
                            child: InkWell(
                              onTap: () async {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    otpController.clear();
                                    listenForCode();
                                    var user = widget.mobileNumber;
                                    if (user != null) {
                                      login(Strings.four_digit_enter_otp + " " + user);
                                      setState(() {
                                        _start = 120;
                                        retryAvailable = false;
                                        isResendOTPClickable = true;

                                      });
                                    }
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.resend_otp,
                                style: TextStyle(
                                    color: isResendOTPClickable == true ? colorGrey : appTheme,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        _timerAndRetrySection(),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _timerAndRetrySection() {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // retryAvailable
              //     ?
              Text(timerString,
                  style: TextStyle(color: red, fontSize: 16.0, fontWeight: FontWeight.w500)),
              SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }

  void otpVerify() {
    if (otpValue == null) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else if (otpValue!.length < 4) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      loginBloc.otpVerify(widget.mobileNumber, otpValue, firebase_token).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          preferences!.setCamsEmail(value.data!.customer!.camsEmailId ?? "");
          preferences!.setToken(value.data!.token!);
          preferences!.setMobile(value.data!.customer!.phone!);
          // preferences!.setCustomer(value.data);
          preferences!.setEmail(value.data!.customer!.user!);
          preferences!.setFullName(value.data!.customer!.firstName! + " " + value.data!.customer!.lastName!);

          if (value.data!.customer!.offlineCustomer != null && value.data!.customer!.offlineCustomer! == 1 && value.data!.customer!.setPin == 0) {
            parameter[Strings.mobile_no] = widget.mobileNumber;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.login_otp_verified, parameter);
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => SetPinScreen(true, value.data!.customer!.loanOpen!)));
          } else if (value.data!.customer!.offlineCustomer != null && value.data!.customer!.offlineCustomer! == 1 && value.data!.customer!.loanOpen == 0) {
            parameter[Strings.mobile_no] = widget.mobileNumber;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.login_otp_verified, parameter);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
          } else {
            parameter[Strings.mobile_no] = widget.mobileNumber;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.login_otp_verified, parameter);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) => DashBoard()), (route) => false);
          }
        } else {
          if (value.errorCode == 404) {
            parameter[Strings.mobile_no] = widget.mobileNumber;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.login_otp_verified, parameter);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    RegistrationScreen(widget.mobileNumber, otpValue!)), (
                route) => false);
          } else if (value.errorCode == 401) {
            otpController.clear();
            parameter[Strings.mobile_no] = widget.mobileNumber;
            parameter[Strings.error_message] = value.errorMessage;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.login_otp_failed, parameter);
            Utility.showToastMessage(value.errorMessage!);
          }
        }
      });
    }
  }

  Future<void> autoLogin() async {
    mobileExist = await preferences!.getMobile();
    printLog(mobileExist);
    firebase_token = await preferences!.getFirebaseToken();
  }

  void login(String message) {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    loginBloc.loginSubmit(widget.mobileNumber.trim(), firebase_token,widget.acceptTerms).then((value) {
      Navigator.pop(context); //pop dialog
      if (value.isSuccessFull!) {
        Utility.showToastMessage(message);
        startTimer();
      } else {
        Utility.showToastMessage(value.message!);
      }
    });
  }
}
