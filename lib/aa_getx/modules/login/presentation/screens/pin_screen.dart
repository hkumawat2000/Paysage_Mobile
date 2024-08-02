import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/pin_screen_controller.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreenView extends GetView<PinScreenController> {
  const PinScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: controller.scadffoldKey,
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
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: PinCodeTextField(
                        controller: controller.enterPinTextEditingController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        cursorColor: appTheme,
                        appContext: context,
                        textStyle: TextStyle(
                            fontSize: mediumText_24,
                            fontWeight: regular,
                            color: colorDarkGray),
                        keyboardType: TextInputType.number,
                        backgroundColor: colorBg,
                        length: 4,
                        showCursor: true,
                        obscuringCharacter: '*',
                        obscureText: controller.obscureText.value,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            inactiveColor: colorGrey,
                            selectedColor: appTheme,
                            activeColor: appTheme,
                            disabledColor: colorGrey,
                            borderWidth: 2),
                        onCompleted: (pin) {
                          controller.enterPin = pin;
                          controller.onPinCompleted(pin);

                        },
                        onChanged: (value) {
                          printLog(value);
                          controller.onPinChanged(value);
                        },
                        beforeTextPaste: (text) {
                          if (text!.contains(new RegExp(
                              r'[A-Za-z~!@#$%^&*()_+`"{}|<>?;:./,= ]'))) {
                            return false;
                          }
                          return true;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.hideShowText.value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.hideOrShowText();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  controller.obscureText.isTrue
                                      ? Strings.show
                                      : Strings.hide,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.isFingerPrintSupport();
                      },
                      child: Visibility(
                        visible: controller.isFingerSupport.isTrue &&
                            controller.isFingerEnable.isTrue &&
                            controller.availableBiometricType.length != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image: AssetImage(AssetsImagePath.biometric),
                                width: 16,
                                height: 16,
                                color: colorBlack),
                            SizedBox(width: 4),
                            Text(Strings.login_with_biometric),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => Container(
                      height: 45,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: controller.isSubmitButtonClickable.isTrue
                            ? colorLightGray
                            : appTheme,
                        child: AbsorbPointer(
                          absorbing: !controller.isSubmitButtonClickable.value,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              controller.callGetPinApi();
                            },
                            child: ArrowForwardNavigation(),
                          ),
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
                            controller.toRegisterWithAnotherAccount();
                          },
                          child: Text(Strings.register,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.toNavigatetoForgotPin();
                    },
                    child: Text(
                      Strings.forget_pin,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => version()),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget version() {
    return Center(
      child: Text("Version ${controller.versionName}"),
    );
  }
}
