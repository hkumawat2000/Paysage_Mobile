import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/controllers/account_settings_controller.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/views/settings_menu_view.dart';

class AccountSettingsScreen extends GetView<AccountSettingsController> {
  AccountSettingsScreen();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) => controller.willPopCallback,
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: buildAppBar(context),
        body: SafeArea(
          child: controller.isAPIResponse.isTrue
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                    child: Column(
                      children: <Widget>[
                        // settingHeader(),
                        SizedBox(height: 10),
                        profileInfoCard(), // profile card
                        SizedBox(height: 10),
                        // kycDetailsPendingCard(),
                        Expanded(
                            child: accountSettingMenu()), // setting menu popup
                      ],
                    ),
                  ),
                )
              : Center(child: Text(Strings.please_wait)),
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
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
      ),
      title: Text(
        Strings.account_setting,
        style: TextStyle(
            color: red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Gilroy'),
      ),
    );
  }

  Widget profileInfoCard() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Card(
              elevation: 2.0,
              color: colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 10, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.userName.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: appTheme),
                    ),
                    SizedBox(height: 6),
                    Text(
                      encryptAcNo(controller.userMobileNo.value),
                      style: TextStyle(fontSize: 15, color: appTheme),
                    ),
                    SizedBox(height: 2),
                    Text(
                      controller.userEmail.value.replaceRange(
                          controller.userEmail.value.indexOf('@') > 4 ? 4 : 2,
                          controller.userEmail.value.indexOf('@'),
                          "XXXXX"),
                      style: TextStyle(fontSize: 15, color: appTheme),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: appTheme,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              child: CircleAvatar(
                backgroundColor: colorLightBlue,
                backgroundImage: controller.image != null
                    ? FileImage(controller.image!)
                    : (controller.profileImage.value != null &&
                            controller.profileImage.value.isNotEmpty)
                        ? NetworkImage(controller.profileImage.value)
                        : AssetImage(AssetsImagePath.profile) as ImageProvider,
                radius: 40.0,
                child: Align(
                  alignment: Alignment(1.2, 0.7),
                  child: GestureDetector(
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(16.0),
                        color: colorDarkYellow,
                        border: Border.all(color: appTheme, width: 1),
                      ),
                      padding: EdgeInsets.all(4),
                      child:
                          Image(image: AssetImage(AssetsImagePath.camera_icon)),
                    ),
                    onTap: () {
                      Utility.isNetworkConnection().then((isNetwork) async {
                        if (isNetwork) {
                          bool photoConsent =
                              await controller.preferences.getPhotoConsent();
                          if (!photoConsent) {
                            permissionYesNoDialog(Get.context!);
                          } else {
                            uploadPhoto();
                          }
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> permissionYesNoDialog(BuildContext context) async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Text("Storage Access", style: boldTextStyle_16),
              content: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Why is LMS asking for my Storage access?\n\n',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'LMS asked for ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Storage Access',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to let you upload the required ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Documents & Image',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to avail the services.\nWe do ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'collect /share',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text:
                                  ' the Uploaded Document/Images with us and any other third party based on the services availed.\n\nPermission can be changed at anytime from the device settings.\n\nIn case of any doubts, please visit our ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      String privacyPolicyUrl = await controller
                                          .preferences
                                          .getPrivacyPolicyUrl();
                                      // printLog(
                                      //     "privacyPolicyUrl ==> $privacyPolicyUrl");
                                      //TODO : Navigate to T&C screen
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             TermsConditionWebView(
                                      //                 "",
                                      //                 true,
                                      //                 Strings.terms_privacy)));
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                              text: "Privacy Policy.",
                              style: boldTextStyle_12_gray_dark.copyWith(
                                  color: Colors.lightBlue)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            // width: 100,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(color: red)),
                              elevation: 1.0,
                              color: colorWhite,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: Text(
                                  "Deny",
                                  style: buttonTextRed,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            // width: 100,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              elevation: 1.0,
                              color: appTheme,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                      controller.preferences
                                          .setPhotoConsent(true);
                                      uploadPhoto();
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: Text(
                                  "Allow",
                                  style: buttonTextWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ) ??
        false;
  }

  Future<void> uploadPhoto() async {
    try {
      String byteImageString;
      XFile? imagePicker =
          await controller.imagePicker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          cropStyle: CropStyle.circle,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
                toolbarColor: appTheme,
                toolbarTitle: "Crop Image",
                toolbarWidgetColor: colorWhite,
                backgroundColor: colorBg,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true)
          ],
        );

        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          byteImageString = base64Encode(bytes);
          controller.rxbyteImageString.value = byteImageString;
          controller.updateProfilePicAndPin();
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(Get.context);
    }
  }

  Widget accountSettingMenu() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints.expand(),
      // child: GestureDetector(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.only(left: 4, right: 4),
        child: SettingsMenuView(
          isKYCCompleted: controller.isKYCCompleted.value,
          alertDataResponseEntity: controller.alretDataEntity.value,
          isSettingOpen: 0,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userName', controller.userName.value));
  }
}
