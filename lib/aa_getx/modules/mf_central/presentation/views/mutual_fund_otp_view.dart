import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/mutual_fund_otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MutualFundOtpView extends GetView<MutualFundOtpController>{

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // key: otpVerificationController.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:
          Container(
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
                      Strings.mf_otp_verification,
                      style: TextStyle(
                          color: appTheme,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(Strings.mf_enter_otp,
                      style: TextStyle(
                        color: colorLightGray,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: PinCodeTextField(
                        controller: controller.mfOtpTextController,
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
                        length: 6,
                        obscureText: false,
                        autoFocus: true,
                        animationType: AnimationType.fade,
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
                          controller.otpValue = otp;
                          if (controller.otpValue!.length >= 6) {
                            controller.isSubmitBtnClickable = true.obs;
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {

                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          } else {
                            controller.isSubmitBtnClickable = false.obs;
                          }
                        },
                        onChanged: (value) {
                          printLog("onChange => $value");
                          if (value.length >= 6) {
                            controller.isSubmitBtnClickable(true);
                          } else {
                            controller.isSubmitBtnClickable(false);
                          }
                        },
                        beforeTextPaste: (text) {
                          printLog("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                            color: controller.isSubmitBtnClickable.isTrue
                                ? appTheme
                                : colorLightGray,
                            child: AbsorbPointer(
                              absorbing: !controller.isSubmitBtnClickable.value,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {

                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: AbsorbPointer(
                              absorbing: !controller.isResendOTPClickable.value,
                              child: InkWell(
                                onTap: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      controller.mfOtpTextController.clear();
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: Text(
                                  Strings.resend_otp,
                                  style: TextStyle(
                                      color: controller.isResendOTPClickable.isFalse
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
        ),
      ),
    );
  }

  Widget _timerAndRetrySection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${controller.start.value}',
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
  }

}