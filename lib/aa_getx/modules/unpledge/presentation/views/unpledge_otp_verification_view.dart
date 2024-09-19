
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/controllers/unpledge_otp_verification_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UnpledgeOtpVerificationView extends GetView<UnpledgeOtpVerificationController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: controller.scaffoldKey,
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
                      controller: controller.otpController,
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
                      onCompleted: (otp)=> controller.otpOnCompleted(otp),
                      onChanged: (value)=> controller.otpOnChanged(value) ,
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
                          color: controller.isSubmitBtnClickable == true ? colorLightGray : appTheme,
                          child: AbsorbPointer(
                            absorbing: controller.isSubmitBtnClickable.value,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: ()=> controller.submitClicked(),
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
                          absorbing: controller.isResendOTPClickable.value,
                          child: InkWell(
                            onTap: ()=> controller.resendOtpClicked(),
                            child: Text(
                              Strings.resend_otp,
                              style: TextStyle(
                                  color: controller.isResendOTPClickable.value == true ? colorGrey : appTheme,
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
              Text(controller.timerString,
                  style: TextStyle(color: red, fontSize: 16.0, fontWeight: FontWeight.w500)),
              SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }
}

