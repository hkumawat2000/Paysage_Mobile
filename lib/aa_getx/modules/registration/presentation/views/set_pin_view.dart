import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';

class SetPinView extends GetView<SetPinController> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => OnBackPress.onBackPressDialog(1,Strings.exit_app),
     // onPopInvoked: null,
      child: GestureDetector(
        child: Scaffold(
          backgroundColor: colorBg,
          body: Container(
            child: SingleChildScrollView(
              child: Obx(()=>
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    AppIcon(),
                    SizedBox(
                      height: 34,
                    ),
                    headingText(Strings.set_pin),
                    SizedBox(
                      height: 60,
                    ),
                    pinField(),
                    SizedBox(
                      height: 20,
                    ),
                    reEnterPinField(),
                    SizedBox(
                      height: 120,
                    ),
                    Container(
                      height: 45,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: ()=> controller.setPin(),
                          child: ArrowForwardNavigation(),
                        ),
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
        onTap: ()=> Get.focusScope!.unfocus(),
      ),
    );
  }

  Widget pinField() {
    final theme = Get.theme;
    return  Padding(
          padding: const EdgeInsets.only(left: 20, right:20),
          child: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: TextFormField(
              obscureText: controller.pinVisible.value,
              enabled: true,
              autofocus: true,
              maxLength: 4,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: controller.pinController,
              style: textFiledInputStyle,
              cursorColor: appTheme,
              onChanged: (text)=> controller.focusToConfirmPin(text),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 0.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                counterText: "",
                hintText: Strings.pin,
                labelText: Strings.pin,
                hintStyle: TextStyle(color: colorGrey),
                labelStyle: TextStyle(color: appTheme),
                suffixIcon: IconButton(
                  icon: Icon(controller.pinVisible.isTrue ? Icons.visibility_off : Icons.visibility, color: appTheme),
                  onPressed: ()=> controller.changePinVisibility(),
                ),
              ),
            ),
          ),
        );
  }

  Widget reEnterPinField() {
    final theme = Get.theme;
    return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: TextFormField(
              obscureText: controller.cnfPinVisible.value,
              enabled: true,
              autofocus: true,
              maxLength: 4,
              keyboardType:
              TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: controller.confirmPinController,
              focusNode: controller.confirmPinFocus,
              validator: (val)=> controller.validConfirmPin(val),
              onChanged: (text)=> controller.unFocus(text),
              cursorColor: appTheme,
              style: textFiledInputStyle,
              decoration: new InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 0.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                counterText: "",
                hintText: Strings.confirm_pin,
                labelText: Strings.confirm_pin,
                hintStyle: TextStyle(color: colorGrey),
                labelStyle: TextStyle(color: appTheme),
                suffixIcon: IconButton(
                  icon: Icon(controller.cnfPinVisible.isTrue ? Icons.visibility_off : Icons.visibility, color: appTheme),
                  onPressed: ()=> controller.changeCnfVisibility(),
                ),
              ),
            ),
          ),
        );
  }
}