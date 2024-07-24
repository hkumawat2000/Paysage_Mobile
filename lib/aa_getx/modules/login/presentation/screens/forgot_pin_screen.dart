import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/forogt_pin_controller.dart';

class ForgotPinScreen extends GetView<ForgotPinController> {
  ForgotPinScreen();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                AppIcon(),
                SizedBox(
                  height: 30,
                ),
                headingText(Strings.forgot_pin),
                SizedBox(
                  height: 65,
                ),
                receivePinField(), //OTP field
                SizedBox(
                  height: 20,
                ),
                newPinField(), //New pin field
                SizedBox(
                  height: 30,
                ),
                doNotReceive(),
                SizedBox(
                  height: 40,
                ),
                submit(),
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

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget header() {
    return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme2,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset(
                AssetsImagePath.lms_logo,
              ),
            ),
          ],
        ));
  }

  Widget receivePinField() {
    final theme = Theme.of(Get.context!);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          obscureText: controller.receivePinVisible.value,
          enabled: true,
          autofocus: true,
          maxLength: 4,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          controller: controller.receivePinController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          onChanged: (text) {
            if (text.length == 4) {
              controller.toRequestFocus(false);
            }
          },
          decoration: InputDecoration(
            counterText: "",
            hintText: Strings.received_otp,
            hintStyle: textFiledHintStyle,
            suffixIcon: IconButton(
              icon: Icon(
                controller.receivePinVisible.isTrue
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: appTheme,
              ),
              onPressed: () {
                controller.toChangeReceivePinVisibility();
              },
            ),
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: appTheme,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget newPinField() {
    final theme = Theme.of(Get.context!);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          obscureText: controller.newPinVisible.value,
          enabled: true,
          autofocus: true,
          maxLength: 4,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          onChanged: (text) {
            controller.toRequestFocus(true);
          },
          controller: controller.newPinController,
          focusNode: controller.newPinFocusNode,
          cursorColor: appTheme,
          style: textFiledInputStyle,
          decoration: new InputDecoration(
            counterText: "",
            hintText: Strings.create_new_pin,
            hintStyle: textFiledHintStyle,
            suffixIcon: IconButton(
              icon: Icon(
                controller.newPinVisible.isFalse
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: appTheme,
              ),
              onPressed: () {
                controller.toChangePinVisibility();
              },
            ),
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: appTheme,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget doNotReceive() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(Strings.not_receive_pin),
        GestureDetector(
          child: Text(Strings.click_here,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          onTap: () {
            controller.autoFetchPreferenceValues();
            controller.listenForCode();
            //TODO
            // Utility.isNetworkConnection().then((isNetwork) {
            //   if (isNetwork) {
            //     autoFetch();
            //     listenForCode();
            //     // requestForOTP();
            //   } else {
            //     Utility.showToastMessage(Strings.no_internet_message);
            //   }
            // });
          },
        ),
      ],
    );
  }

  Widget submit() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(Get.context!).size.width,
              onPressed: () async {
                controller.setPin();
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        ),
      ],
    );
  }
}
