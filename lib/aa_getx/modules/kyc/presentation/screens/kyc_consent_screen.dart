import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/controllers/kyc_consent_controller.dart';

class KycConsentScreen extends GetView<KycConsentController> {
  KycConsentScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => backPressYesNoDialog(context),
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorBg,
          elevation: 0,
          leading: IconButton(
            icon: NavigationBackImage(),
            onPressed: () => backPressYesNoDialog(context),
          ),
        ),
        body: controller.isApiCalling.isTrue
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.isAPICallingText),
                ],
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: headingText("Confirm Your Details (1/2)")),
                      SizedBox(height: 40),
                      subHeadingText(Strings.personal_info),
                      SizedBox(height: 20),
                      Text(Strings.name, style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(controller.userKycDocResponseEntity.fullname!,
                          style: regularTextStyle_18_gray_dark),
                      SizedBox(height: 20),
                      Text("Pan Number", style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(controller.userKycDocResponseEntity.panNo!,
                          style: regularTextStyle_18_gray_dark),
                      SizedBox(height: 20),
                      Text("CKYC Number", style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(controller.userKycDocResponseEntity.ckycNo!,
                          style: regularTextStyle_18_gray_dark),
                      SizedBox(height: 20),
                      Text(Strings.email, style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(
                        controller.userKycDocResponseEntity.email != null && controller.userKycDocResponseEntity.email!.isNotEmpty
                            ? controller.userKycDocResponseEntity.email!.replaceRange(
                                controller.userEmail.indexOf('@') > 4 ? 4 : 2,
                                controller.userKycDocResponseEntity.email!.indexOf('@'),
                                "XXXXX")
                            : "-",
                        style: regularTextStyle_18_gray_dark,
                      ),
                      SizedBox(height: 20),
                      Text("Mobile Number", style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(
                        controller.userKycDocResponseEntity.mobNum != null && controller.userKycDocResponseEntity.mobNum!.isNotEmpty
                            ? encryptAcNo(controller.userKycDocResponseEntity.mobNum!)
                            : "-",
                        style: regularTextStyle_18_gray_dark,
                      ),
                      SizedBox(height: 20),
                      Text("Gender", style: mediumTextStyle_14_gray),
                      SizedBox(height: 5),
                      Text(
                        controller.userKycDocResponseEntity.genderFull!,
                        style: regularTextStyle_18_gray_dark,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [forwardNavigation()],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget forwardNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () => backPressYesNoDialog(Get.context!),
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
                controller.navigateToConsentAddressScreen();
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        )
      ],
    );
  }
}
