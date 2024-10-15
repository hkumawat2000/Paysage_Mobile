
import 'dart:io';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController>{

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) =>  OnBackPress.onBackPressDialog(1,Strings.exit_app),
        child: Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: colorBg,
          body: Container(
            child:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  AppIcon(),
                  SizedBox(
                    height: 34,
                  ),
                  headingText(Strings.registration),
                  SizedBox(
                    height: 20,
                  ),
                  emailField(),
                  SizedBox(
                    height: 20,
                  ),
                  nameField(),
                  SizedBox(
                    height: 20,
                  ),
                  lastNameFeild(),
                  SizedBox(
                    height: 20,
                  ),
                  mobileFeild(),
        //                  SizedBox(
        //                    height: 20,
        //                  ),
        //                  referCodeFeild(),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Strings.register_with,
                          style: textFiledInputStyle,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Platform.isIOS
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () =>
                                        controller.googleSignClicked(),
                                    child: Image.asset(
                                      AssetsImagePath.login_google,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.appleSignIn(),
                                    child: Image(
                                        image: AssetImage(
                                            AssetsImagePath.apple_icon),
                                        width: 42,
                                        height: 42),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () => controller.googleSignClicked(),
                                child: Image.asset(
                                  AssetsImagePath.login_google,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: appTheme,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () => controller.registartion(
                            controller.firstNameController.text,
                            controller.lastNameController.text,
                            controller.emailController.text,
                            controller.versionName.value,
                            controller.deviceInfo,
                            Strings.register_with_email),
                        child: ArrowForwardNavigation(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(()=> version()),
                  SizedBox(height: 15),
                ],
              ),
            ),

        ),
        ),
    );
  }

  Widget version() {
    return Center(
      child: Text('Version ${controller.versionName.value}'),
    );
  }


  Widget nameField() {
    final theme = Get.theme;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: controller.firstNameController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          maxLength: 25,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],

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
            hintText: Strings.first_name,
            labelText: Strings.first_name,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
          keyboardType: TextInputType.name,
        ),
      ),
    );
  }

  Widget lastNameFeild() {
    final theme = Get.theme;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: controller.lastNameController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          maxLength: 25,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
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
            hintText: Strings.last_name,
            labelText: Strings.last_name,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
          keyboardType: TextInputType.name,
        ),
      ),
    );
  }

  Widget emailField() {
    final theme = Get.theme;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: CompositedTransformTarget(
          link: controller.layerLink,
          child: TextFormField(
            onChanged: (val)=> controller.emailOnChanged(val),
            onEditingComplete: () {
              if(Platform.isAndroid) {
                Get.focusScope?.nextFocus();
                if (controller.overlayEntry!.value.mounted)
                  controller.overlayEntry!.value.remove();
              }
            },
            onFieldSubmitted: (_) {
              if(Platform.isAndroid) {
                if (controller.overlayEntry!.value.mounted)
                  controller.overlayEntry!.value.remove();
              }
            },
            // focus to next
            keyboardType: TextInputType.emailAddress,
            focusNode: controller.focusNode,
            obscureText: false,
            controller: controller.emailController,
            style: textFiledInputStyle,
            cursorColor: appTheme,
            onTap: ()=> controller.getEmailList(),
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
              hintText: Strings.email,
              labelText: Strings.email,
              hintStyle: TextStyle(color: colorGrey),
              labelStyle: TextStyle(color: appTheme),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileFeild() {
    final theme = Get.theme;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          enabled: false,
          controller: controller.mobileController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appTheme),
            ),
            disabledBorder: OutlineInputBorder(
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
            hintText: Strings.mobile,
            labelText: Strings.mobile,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
        ),
      ),
    );
  }

}
