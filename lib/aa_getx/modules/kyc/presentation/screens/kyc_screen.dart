import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/controllers/kyc_controller.dart';

class CompleteKycView extends GetView<KycController> {
  CompleteKycView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: colorBg,
          body: controller.isApiCallInProgress.isTrue
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.isAPICallingText),
                  ],
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Image.asset(AssetsImagePath.updateKyc,
                            width: 195, height: 200),
                        SizedBox(
                          height: 20,
                        ),
                        largeHeadingText(Strings.KYC_info),
                        SizedBox(
                          height: 40,
                        ),
                        panField(),
                        SizedBox(
                          height: 14,
                        ),
                        dOBWidget(context),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                value: controller.checkBoxValue.value,
                                activeColor: appTheme,
                                onChanged: (bool? newValue) {
                                  controller.onCheckBoxValueChanged();
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  controller.consentKycText.toString(),
                                  style: mediumTextStyle_16_dark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        nextPreWidget(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget panField() {
    final theme = Theme.of(Get.context!);
    return Theme(
      data: theme.copyWith(primaryColor: appTheme),
      child: TextFormField(
        maxLength: 10,
        controller: controller.panController,
        style: textFiledInputStyle,
        cursorColor: appTheme,
        onChanged: (text) {
          controller.requestFocusOnDOB();
        },
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
          hintText: Strings.pan_no,
          labelText: Strings.pan_no,
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
      ),
    );
  }

  Widget dOBWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        dobField(),
        dOBCalendar(context),
      ],
    );
  }

  Widget dobField() {
    final theme = Theme.of(Get.context!);
    return Theme(
      data: theme.copyWith(primaryColor: appTheme),
      child: TextFormField(
        controller: controller.dateOfBirthController,
        style: textFiledInputStyle,
        cursorColor: appTheme,
        focusNode: controller.dobDateFocus,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
          LengthLimitingTextInputFormatter(10),
          DateFormatter(),
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
          hintText: Strings.dob,
          labelText: Strings.dob,
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
        ),
        onChanged: (val) {
          controller.onDOBChanged();
        },
      ),
    );
  }

  Widget dOBCalendar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        controller.selectDate(context);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Image.asset(AssetsImagePath.calendar,
            width: 24, height: 24, fit: BoxFit.fill),
      ),
    );
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            Get.back();
          },
        ),
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
                controller.toCallKycApiAndNavigateTo();
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        )
      ],
    );
  }
}
