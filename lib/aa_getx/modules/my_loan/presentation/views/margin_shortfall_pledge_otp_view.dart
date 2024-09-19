import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_pledge_otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


///todo: pass arguments while naviagtion to this page
//String cartName, fileId, pledgorBoid;
//   String instrumentType;
class MarginShortfallPledgeOTPView extends GetView<MarginShortfallPledgeOtpController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Container(
          height: 369,
          width: 375,
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
                        Strings.otp_verification, Strings.enter_pledge_otp),
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
                      inputFormatters: <TextInputFormatter>[
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
                      onCompleted: (otp)=>controller.otpFieldCompleted(otp),
                      onChanged: (value)=> value.length >= 4 ? controller.isSubmitBtnClickable = false : controller.isSubmitBtnClickable = true,
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
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
                            color: controller.isSubmitBtnClickable == true ? colorLightGray : appTheme,
                            child: AbsorbPointer(
                              absorbing: controller.isSubmitBtnClickable,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: ()=> controller.createLoanApplication(),
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
                          absorbing: controller.isResendOTPClickable.value,
                          child: InkWell(
                            onTap: ()=> controller.resendOtpClicked(),
                            child: new Text(
                              Strings.resend_otp,
                              style: TextStyle(
                                  color: controller.isResendOTPClickable == true ? colorGrey : appTheme,
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
    );
  }

  Widget _timerAndRetrySection() {
    return AnimatedBuilder(
      animation: controller.animController!,
      builder: (context, child) {
        return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // retryAvailable
                //     ?
                Text(controller.timerString,
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
}