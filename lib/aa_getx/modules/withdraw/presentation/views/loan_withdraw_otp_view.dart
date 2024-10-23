// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/withdraw/data/data_source/loan_withdraw_datasource.dart';
import 'package:lms/aa_getx/modules/withdraw/data/repositories/loan_withdraw_repository_impl.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/create_withdraw_request_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/request_loan_withdraw_otp_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/controllers/loan_withdraw_otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoanWithdrawOtpView extends StatefulWidget {
  String? loanName, amount, bankAccountName, accountNumber;

  LoanWithdrawOtpView({
    Key? key,
    required this.loanName,
    required this.amount,
    required this.bankAccountName,
    required this.accountNumber,
  }) : super(key: key);

  @override
  State<LoanWithdrawOtpView> createState() => _LoanWithdrawOtpViewState();
}

class _LoanWithdrawOtpViewState extends State<LoanWithdrawOtpView>
    with TickerProviderStateMixin, CodeAutoFill {
  final LoanWithdrawOtpController otpVerificationController =
      //Get.find<OtpVerificationController>();
      Get.put(
    LoanWithdrawOtpController(
      Get.put(
        ConnectionInfoImpl(Connectivity()),
      ),
      Get.put(
        CreateWithdrawRequestUsecase(
          Get.put(
            LoanWithdrawRepositoryImpl(
              Get.put(
                LoanWithdrawDatasourcecDataSourceImpl(),
              ),
            ),
          ),
        ),
      ),
      Get.put(
        GetLoanWithdrawOTPUsecase(
          Get.put(
            LoanWithdrawRepositoryImpl(
              Get.put(
                LoanWithdrawDatasourcecDataSourceImpl(),
              ),
            ),
          ),
        ),
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
      child: Scaffold(
        // key: otpVerificationController.scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
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
                      height: 30,
                    ),
                    HeadingSubHeadingWidget(Strings.otp_verification,
                        "Enter OTP to confirm your application for loan withdraw (sent to your registered mobile number)"),
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
                          // printLog("Completed::$otp");
                          otpVerificationController.otpValue = otp;
                          if (otpVerificationController.otpValue!.length >= 4) {
                            otpVerificationController.isSubmitBtnClickable =
                                false.obs;
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                otpVerificationController.createWithdrawRequest(
                                  widget.bankAccountName!,
                                  widget.amount,
                                  widget.loanName,
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
                          // printLog("onChange => $value");
                          if (value.length >= 4) {
                            otpVerificationController.isSubmitBtnClickable =
                                false.obs;
                          } else {
                            otpVerificationController.isSubmitBtnClickable =
                                true.obs;
                          }
                        },
                        beforeTextPaste: (text) {
                          //printLog("Allowing to paste $text");
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
                                      otpVerificationController
                                          .createWithdrawRequest(
                                              widget.bankAccountName!,
                                              widget.amount,
                                              widget.loanName);
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
                    Obx(
                      () => Row(
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
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      otpVerificationController
                                          .otpTextController
                                          .clear();
                                      listenForCode();
                                      otpVerificationController
                                          .requestWithdrawOtpOnRetry();
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
                          Obx(() => _timerAndRetrySection()),
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
            '${otpVerificationController.start.value}',
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
