import 'dart:async';
import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/unpledge/UnpledgeSuccessfulScreen.dart';
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


import 'UnpledgeBloc.dart';

class UnpledgeOTPVerificationScreen extends StatefulWidget{
  List<UnPledgeList> unpledgeListItem;
  String loanName;
  String maxAllowable;
  String loanType;

  @override
  UnpledgeOTPVerificationScreenState createState() =>
      UnpledgeOTPVerificationScreenState();

  UnpledgeOTPVerificationScreen(this.unpledgeListItem, this.loanName, this.maxAllowable, this.loanType);

}

class UnpledgeOTPVerificationScreenState extends State<UnpledgeOTPVerificationScreen>
    with TickerProviderStateMixin, CodeAutoFill{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  int _start = 120;
  bool retryAvailable = false;
  AnimationController? controller;
  String? otpValue;
  Preferences? preferences;
  var mobileExist;
  bool isResendOTPClickable = true;
  bool isSubmitBtnClickable = true;
  TextEditingController otpController = TextEditingController();
  final unpledgeBloc = UnpledgeBloc();
  String signature = "";


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
    SmsAutoFill().unregisterListener();
    super.dispose();
    cancel();
  }

  @override
  void initState() {
    listenForCode();
    preferences = Preferences();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
    super.initState();
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
    return GestureDetector(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: HeadingSubHeadingWidget(
                        Strings.otp_verification, Strings.enter_otp + " " ),
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
                        if (v!.length < 3) {
                          return "";
                        } else {
                          return null;
                        }
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
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              createUnpledgeRequest();
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        } else {
                          isSubmitBtnClickable = true;
                        }
                      },
                      onChanged: (value) {
                        if (value.length >= 4) {
                          isSubmitBtnClickable = false;
                        } else {
                          isSubmitBtnClickable = true;
                        }
                        setState(() {});
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
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        createUnpledgeRequest();
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });

                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.submit,
                                style: TextStyle(
                                    color: colorWhite, fontWeight: FontWeight.w700, fontSize: 16),
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
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: AbsorbPointer(
                          absorbing: isResendOTPClickable,
                          child: InkWell(
                            onTap: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  otpController.clear();
                                  listenForCode();
                                  unpledgeRequestOTP();
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

  void unpledgeRequestOTP() async{
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    unpledgeBloc.requestUnpledgeOTP().then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.otp_sent_success);
        startTimer();
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }


  void createUnpledgeRequest() async {
    String? mobile = await preferences!.getMobile();
    String email = await preferences!.getEmail();
    if (otpValue!.isEmpty ) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else if (otpValue!.length < 4) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      UnpledgeRequestBean unpledgeRequestBean = UnpledgeRequestBean();
      unpledgeRequestBean.loanName = widget.loanName;
      unpledgeRequestBean.securities = new UnPledgeSecurities(list: widget.unpledgeListItem);
      unpledgeRequestBean.otp = otpValue;
      unpledgeBloc.unpledgeRequest(unpledgeRequestBean).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          retryAvailable = false;
          // Utility.showToastMessage(value.message);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = widget.loanName;
          parameter[Strings.max_allowable] = widget.maxAllowable;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.Unpledge_Success, parameter);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UnpledgeSuccessfulScreen(widget.loanType)));

        } else if (value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else {
          otpController.clear();
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = widget.loanName;
          parameter[Strings.max_allowable] = widget.maxAllowable;
          parameter[Strings.error_message] = value.errorMessage;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.unpledge_failed, parameter);
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }

  }
}