// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/login_usecases.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_otp_usecase.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/otp_verification_controller.dart';

class OTPVerificationView extends StatefulWidget {
  LoginSubmitResquestEntity loginSubmitResquestEntity;

  OTPVerificationView({
    Key? key,
    required this.loginSubmitResquestEntity,
  }) : super(key: key);

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView>
    with TickerProviderStateMixin, CodeAutoFill {
// Due to use of modal bottom sheet and it only accepts a widget and not a classs which is extended with GetView.
// So to access the Controller I need to declare it here.
  final OtpVerificationController otpVerificationController =
  //Get.find<OtpVerificationController>();
  Get.put(
    OtpVerificationController(
      Get.put(
        LoginUseCase(
            Get.put(LoginRepositoryImpl(Get.put(LoginDataSourceImpl())))),
      ),
      Get.put(
        VerifyOtpUsecase(
            Get.put(LoginRepositoryImpl(Get.put(LoginDataSourceImpl())))),
      ),
      Get.put(
        ConnectionInfoImpl(Connectivity()),
      ),
    ),
  );
  
  @override
  void codeUpdated() {
    if (RegExp(r'^[0-9]+$').hasMatch(code!)) {
      otpVerificationController.otpValue = code;
      otpVerificationController.otpTextController.text = code ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                      color: appTheme,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    text:
                    "${Strings.enter_otp}  ${widget.loginSubmitResquestEntity.mobileNumber}",
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
                    controller: otpVerificationController.otpTextController,
                    cursorColor: appTheme,
                    appContext: context,
                    textStyle: TextStyle(
                        fontSize: mediumText_24,
                        fontWeight: regular,
                        color: colorDarkGray),
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
                      otpVerificationController.otpValue = otp;
                      if (otpVerificationController.otpValue!.length >= 4) {
                        otpVerificationController.isSubmitBtnClickable =
                            false.obs;
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            otpVerificationController.otpVerify(
                              widget.loginSubmitResquestEntity.mobileNumber,
                              widget
                                  .loginSubmitResquestEntity.firebase_token,
                              widget.loginSubmitResquestEntity.platform,
                              widget.loginSubmitResquestEntity.appVersion,
                            );
                          } else {
                            Utility.showToastMessage(
                                Strings.no_internet_message);
                          }
                        });
                      } else {
                        otpVerificationController.isSubmitBtnClickable =
                            true.obs;
                      }
                    },
                    onChanged: (value) {
                      printLog("onChange => $value");
                      if (value.length >= 4) {
                        otpVerificationController.isSubmitBtnClickable =
                            false.obs;
                      } else {
                        otpVerificationController.isSubmitBtnClickable =
                            true.obs;
                      }
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
                        color: otpVerificationController
                            .isSubmitBtnClickable.isTrue
                            ? colorLightGray
                            : appTheme,
                        child: AbsorbPointer(
                          absorbing: !otpVerificationController
                              .isSubmitBtnClickable.value,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection()
                                  .then((isNetwork) {
                                if (isNetwork) {
                                  otpVerificationController.otpVerify(
                                    widget.loginSubmitResquestEntity
                                        .mobileNumber,
                                    widget.loginSubmitResquestEntity
                                        .firebase_token,
                                    widget
                                        .loginSubmitResquestEntity.platform,
                                    widget.loginSubmitResquestEntity
                                        .appVersion,
                                  );
                                } else {
                                  Utility.showToastMessage(
                                      Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(Strings.submit,
                                style: buttonTextWhite),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(()=> Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: AbsorbPointer(
                          absorbing: !otpVerificationController
                              .isResendOTPClickable.value,
                          child: InkWell(
                            onTap: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  otpVerificationController.otpTextController
                                      .clear();
                                  listenForCode();
                                  var user = widget
                                      .loginSubmitResquestEntity.mobileNumber;
                                  if (user != null) {
                                    otpVerificationController.login(
                                        widget.loginSubmitResquestEntity
                                            .mobileNumber,
                                        widget.loginSubmitResquestEntity
                                            .firebase_token,
                                        widget.loginSubmitResquestEntity
                                            .platform,
                                        widget.loginSubmitResquestEntity
                                            .appVersion,
                                        Strings.four_digit_enter_otp +
                                            " " +
                                            user,
                                        widget.loginSubmitResquestEntity
                                            .acceptTerms);
                                  }
                                } else {
                                  Utility.showToastMessage(
                                      Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              Strings.resend_otp,
                              style: TextStyle(
                                  color: otpVerificationController
                                      .isResendOTPClickable.isFalse
                                      ? colorGrey
                                      : appTheme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Obx(()=> _timerAndRetrySection()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timerAndRetrySection() {
    // return
    //   AnimatedBuilder(
    //   animation: otpVerificationController.controller!,
    //   builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // retryAvailable
              //     ?
              Text(
                '${otpVerificationController.timerString}',
                style: TextStyle(
                  color: red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        );
    //   },
    // );
  }
}
