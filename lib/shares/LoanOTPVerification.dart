import 'dart:async';

import 'package:lms/login/LoginBloc.dart';
import 'package:lms/login/LoginValidationBloc.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MF_WebViewLoginScreen.dart';
import 'package:lms/shares/LoanApplicationSuccess.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'LoanApplicationBloc.dart';

class LoanOTPVerification extends StatefulWidget {
  String cartName, fileId, pledgorBoid, isComingFor;
  String? loanRenewalName;
  String? loanName;

  @override
  LoanOTPVerificationState createState() => new LoanOTPVerificationState();

  LoanOTPVerification(this.cartName, this.fileId, this.pledgorBoid, this.isComingFor,this.loanRenewalName, this.loanName);
}

class LoanOTPVerificationState extends State<LoanOTPVerification>
    with TickerProviderStateMixin, CodeAutoFill {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final loanApplicationBloc = LoanApplicationBloc();
  Timer? _timer;
  int _start = 120;
  bool retryAvailable = false;
  AnimationController? controller;
  final loginBloc = LoginBloc();
  String? otpValue;
  String? urlRequest;
  final _loginValidatorBloc = LoginValidatorBloc();
  Preferences? preferences;
  var mobileExist, firebaseToken, token;
  bool isResendOTPClickable = true;
  bool isSubmitBtnClickable = true;
  TextEditingController otpController = TextEditingController();
  String signature = "";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_start < 1) {
          timer.cancel();
          isResendOTPClickable = false;
          retryAvailable = true;
        } else {
          _start = _start - 1;
        }
      });
    });
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
  void initState() {
    listenForCode();
    super.initState();
    preferences = new Preferences();
    autoLogin();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
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
    return new
    GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AnimatedPadding(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                // height: 369,
                // width: 375,
                decoration: new BoxDecoration(
                  color: colorWhite,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: HeadingSubHeadingWidget(
                              Strings.otp_verification, widget.isComingFor != Strings.loanRenewal ? widget.isComingFor == Strings.mutual_fund ? Strings.enter_lien_otp : Strings.enter_pledge_otp : "Enter OTP to confirm your renewal application for loan (sent on your registered mobile number)"),
                        ),
                        SizedBox(
                          height: 39,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: PinCodeTextField(
                            controller: otpController,
                            cursorColor: appTheme,
                            appContext: context,
                            textStyle: TextStyle(
                                fontSize: mediumText_24, fontWeight: regular, color: colorDarkGray),
                            backgroundColor: colorWhite,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            ],
                            length: 4,
                            obscureText: false,
                            autoFocus: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              return null;
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              inactiveColor: colorGrey,
                              selectedColor: appTheme,
                              activeColor: appTheme,
                              disabledColor: colorGrey,
                              borderWidth: 2,
                            ),
                            onCompleted: (otp) {
                              otpValue = otp;
                              if (otpValue!.length >= 4) {
                                isSubmitBtnClickable = false;
                                Utility.isNetworkConnection()
                                    .then((isNetwork) {
                                  if (isNetwork) {
                                    if(widget.loanName == Strings.loanRenewal){
                                      loanRenewalApplication();
                                    } else {
                                      createLoanApplication();
                                    }
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              } else {
                                isSubmitBtnClickable = true;
                              }

//                            Utility.isNetworkConnection().then((isNetwork) {
//                              if (isNetwork) {
//                                createLoanApplication();
//                              } else {
//                                showSnackBar(_scaffoldKey);
//                              }
//                            });
                            },
                            onChanged: (value) {
                              printLog(value);
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  elevation: 1.0,
                                  color: isSubmitBtnClickable == true ? colorLightGray : appTheme,
                                  child: AbsorbPointer(
                                    absorbing: isSubmitBtnClickable,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                      minWidth: MediaQuery.of(context).size.width,
                                      onPressed: () async {
                                        Utility.isNetworkConnection()
                                            .then((isNetwork) {
                                          if (isNetwork) {
                                            print("coming for --> ${widget.loanName.toString()}");
                                            if(widget.loanName == Strings.loanRenewal){
                                              loanRenewalApplication();
                                            } else {
                                              createLoanApplication();
                                            }
                                          } else {
                                            Utility.showToastMessage(Strings.no_internet_message);
                                          }
                                        });
                                      },
                                      child: Text(
                                        Strings.submit,
                                        style: TextStyle(
                                            color: colorWhite,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
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
                              padding: const EdgeInsets.only(left: 40, right: 40),
                              child: AbsorbPointer(
                                absorbing: isResendOTPClickable,
                                child: InkWell(
                                  onTap: () async {
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        otpController.clear();
                                        listenForCode();
                                        pledgeOTP();
                                        setState(() {
                                          _start = 120;
                                          retryAvailable = false;
                                          isResendOTPClickable = true;
                                        });
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });
                                  },
                                  child: new Text(
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
                      ]),
                )),
          )),
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
                    style: TextStyle(
                        color: red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 20,
                ),
              ],
            ));
      },
    );
  }


  void createLoanApplication() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    String? mobile = await preferences!.getMobile();
    String? email = await preferences!.getEmail();

    loanApplicationBloc.mfCreateLoanApplication(widget.cartName, otpValue).then((value) {
      Navigator.pop(context);
      if(value.isSuccessFull!){
        if(widget.isComingFor == Strings.mutual_fund || widget.isComingFor == Strings.mf_increase_loan){
          urlRequest = value.processCartData!.mycamUrl;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MF_WebViewLoginScreen(urlRequest!, token)));
        } else {
          retryAvailable = false;
          _start = 0;
          // preferences!.setLoanApplicationNo(value.processCartData!.loanApplication!.name!);
          // preferences!.setCartName(widget.cartName);
          // preferences!.setDrawingPower(value.processCartData!.loanApplication!.drawingPower.toString());
          // preferences!.setSanctionedLimit(value.processCartData!.loanApplication!.totalCollateralValue.toString());

          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.cart_name] = widget.cartName;
          parameter[Strings.demat_ac_no] = widget.pledgorBoid;
          parameter[Strings.drawing_power_prm] = value.processCartData!.loanApplication!.drawingPower!.toStringAsFixed(2);
          parameter[Strings.total_collateral_value_prm] = value.processCartData!.loanApplication!.totalCollateralValue!.toStringAsFixed(2);
          parameter[Strings.date_time] = getCurrentDateAndTime();
          if(widget.isComingFor == Strings.loan) {
            parameter[Strings.loan_application_no_prm] = value.processCartData!.loanApplication!.name;
            firebaseEvent(Strings.loan_created, parameter);
          } else if(widget.isComingFor == Strings.increase_loan) {
            parameter[Strings.increase_loan_application_no] = value.processCartData!.loanApplication!.name;
            firebaseEvent(Strings.increase_loan_otp_success, parameter);
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LoanApplicationSuccess(value.processCartData!.loanApplication!.name!, "")));
        }
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else{
        otpController.clear();
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  void loanRenewalApplication() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    String? mobile = await preferences!.getMobile();
    String? email = await preferences!.getEmail();

    loanApplicationBloc.createLoanRenewalApplication(widget.loanRenewalName, otpValue).then((value) {
      Navigator.pop(context);
      if(value.isSuccessFull!){

        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.cart_name] = widget.cartName;
        parameter[Strings.demat_ac_no] = widget.pledgorBoid;
        // parameter[Strings.drawing_power_prm] = value.processCartData!.loanApplication!.drawingPower!.toStringAsFixed(2);
        // parameter[Strings.total_collateral_value_prm] = value.processCartData!.loanApplication!.totalCollateralValue!.toStringAsFixed(2);
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.loanName == Strings.loanRenewal) {
          parameter[Strings.loan_renewal_application_no] = widget.loanRenewalName;
          firebaseEvent(Strings.loan_renewal_otp_success, parameter);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoanApplicationSuccess(widget.loanRenewalName!, widget.loanName!)));

      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else{
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Future<void> autoLogin() async {
    mobileExist = await preferences!.getMobile();
    printLog(mobileExist);
    firebaseToken = await preferences!.getFirebaseToken();
    token = await preferences!.getToken();
  }


  void pledgeOTP() {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    String? instrumentType;
    if(widget.isComingFor == Strings.mutual_fund){
      instrumentType = Strings.mutual_fund;
    }else{
      instrumentType = Strings.shares;
    }
    loanApplicationBloc.pledgeOTP(instrumentType).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.success_otp_sent);
        setState(() {
          _start = 120;
          retryAvailable = false;
        });
        startTimer();
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}
