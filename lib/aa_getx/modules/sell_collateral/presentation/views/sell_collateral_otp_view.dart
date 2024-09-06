
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/controllers/sell_collateral_otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SellCollateralOtpView extends GetView<SellCollateralOtpController>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: new Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: new BoxDecoration(
              color: colorBg,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Obx(()=>SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: HeadingSubHeadingWidget(
                        Strings.otp_verification, Strings.enter_otp),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: PinCodeTextField(
                      controller: controller.otpController,
                      cursorColor: appTheme,
                      appContext: context,
                      textStyle: TextStyle(
                          fontSize: mediumText_24, fontWeight: regular, color: colorDarkGray),
                      backgroundColor: colorBg,
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      length: 4,
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
                      onCompleted: (otp)=> controller.otpCompleted(otp),
                      onChanged: (value)=>controller.otpOnChanged(value) ,
                      beforeTextPaste: (text) {
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: controller.isSubmitBtnClickable.value == true
                                ? colorLightGray
                                : appTheme,
                            child: AbsorbPointer(
                              absorbing: controller.isSubmitBtnClickable.value,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                onPressed: ()=>controller.createSellCollateralRequest(),
                                child: Text(
                                  Strings.submit,
                                  style: buttonTextWhite,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                                  color: controller.isResendOTPClickable.value == true
                                      ? colorGrey
                                      : appTheme,
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
                    height: 20,
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
      animation: controller.animController!,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(controller.timerString, style: TextStyle(color: red, fontSize: 16.0)),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        );
      },
    );
  }

}
