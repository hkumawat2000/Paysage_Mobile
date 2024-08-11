// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/controllers/settings_menu_controller.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/views/change_password_view.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/views/manage_settings_view.dart';

import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';

class SettingsMenuView extends StatefulWidget {
  bool isKYCCompleted;
  AlertDataResponseEntity alertDataResponseEntity;
  int isSettingOpen;

  SettingsMenuView({
    required this.isKYCCompleted,
    required this.alertDataResponseEntity,
    required this.isSettingOpen,
  });

  @override
  State<SettingsMenuView> createState() => _SettingsMenuViewState();
}

class _SettingsMenuViewState extends State<SettingsMenuView> {
  final SettingsMenuController settingsMenuController =
      Get.put(SettingsMenuController(
    Get.put(
      ConnectionInfoImpl(Connectivity()),
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: ScrollConfiguration(
        behavior: new ScrollBehavior(),
        //..buildViewportChrome(context,Container(), AxisDirection.down),
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 0.1),
                ]),
              )
            ];
          },
          body: Obx(
            () => Container(
              color: colorWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      color: colorLightBlue,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(Strings.manage_setting,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Utility.isNetworkConnection()
                                  .then((isNetwork) async {
                                if (isNetwork) {
                                  if (widget.isSettingOpen == 0) {
                                    Get.bottomSheet(
                                      backgroundColor: Colors.transparent,
                                      ManageSettingsView(
                                        widget.isKYCCompleted,
                                        widget.alertDataResponseEntity,
                                      ),
                                    );
                                    settingsMenuController.fetchDataFromPref();
                                  }
                                } else {
                                  Utility.showToastMessage(
                                      Strings.no_internet_message);
                                }
                              });
                            },
                            child: Image(
                                image: AssetImage(
                                    AssetsImagePath.manage_settings_icon),
                                width: 23,
                                height: 23,
                                color: red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ExpansionTile(
                            key: settingsMenuController.expansionTileSecurity,
                            controller: settingsMenuController
                                .expansionTileSecuritycontroller,
                            // maintainState: false,
                            leading: Image(
                              image: AssetImage(
                                  AssetsImagePath.security_settings_icon),
                              width: 23,
                              height: 23,
                            ),
                            trailing: settingsMenuController
                                    .isSecurityExpansion.isTrue
                                ? Image(
                                    image: AssetImage(
                                        AssetsImagePath.down_arrow_imageicon),
                                  )
                                : Image(
                                    image: AssetImage(
                                        AssetsImagePath.right_arrow_imageicon),
                                  ),
                            title: Text(
                              Strings.security_setting,
                              style: TextStyle(
                                  color: settingsMenuController
                                          .isSecurityExpansion.isTrue
                                      ? red
                                      : appTheme,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              settingsMenuController.isSecurityExpansion.isTrue
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(50, 0, 0, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(color: colorGrey),
                                          GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image(
                                                      image: AssetImage(
                                                          AssetsImagePath
                                                              .signout_icon),
                                                      width: 23,
                                                      height: 23,
                                                      color: colorGreen),
                                                  SizedBox(width: 10),
                                                  Text('Change Pin',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return ChangePasswordView();
                                                },
                                              );
                                            },
                                          ),
                                          settingsMenuController
                                                  .isFingerSupport.isTrue
                                              ? Divider(color: colorGrey)
                                              : SizedBox(),
                                          settingsMenuController
                                                  .isFingerSupport.isTrue
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                          image: AssetImage(
                                                              AssetsImagePath
                                                                  .biometric),
                                                          width: 23,
                                                          height: 23,
                                                          color: colorGreen),
                                                      SizedBox(width: 10),
                                                      Text(Strings.biometric,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (settingsMenuController
                                                              .availableBiometricType
                                                              .isEmpty) {
                                                            commonDialog(
                                                                Strings
                                                                    .ac_setting_biometric_alert_msg,
                                                                0);
                                                          }
                                                        },
                                                        child: AbsorbPointer(
                                                          absorbing:
                                                              settingsMenuController
                                                                      .availableBiometricType
                                                                      .isEmpty
                                                                  ? true
                                                                  : false,
                                                          child: Container(
                                                            height: 26,
                                                            width: 65,
                                                            child: Switch(
                                                              // biometric toggle
                                                              value: settingsMenuController
                                                                  .isFingerEnable
                                                                  .value,
                                                              activeColor:
                                                                  colorGreen,
                                                              thumbIcon:
                                                                  settingsMenuController
                                                                      .thumbIcon,
                                                              // showOnOff: true,
                                                              // activeText: "On",
                                                              // activeTextColor: colorWhite,
                                                              // inactiveText: "Off",
                                                              //inactiveTextColor: colorWhite,
                                                              onChanged:
                                                                  (value) async {
                                                                String email =
                                                                    await settingsMenuController
                                                                        .preferences
                                                                        .getEmail();
                                                                String? mobile =
                                                                    await settingsMenuController
                                                                        .preferences
                                                                        .getMobile();
                                                                if (settingsMenuController
                                                                    .availableBiometricType
                                                                    .isEmpty) {
                                                                  commonDialog(
                                                                      Strings
                                                                          .ac_setting_biometric_alert_msg,
                                                                      0);

                                                                  settingsMenuController
                                                                      .isFingerEnable
                                                                      .value = false;
                                                                  settingsMenuController
                                                                      .preferences
                                                                      .setFingerprintEnable(
                                                                          false);
                                                                } else {
                                                                  bool
                                                                      consentForBiometric =
                                                                      await settingsMenuController
                                                                          .preferences
                                                                          .getFingerprintConsent();
                                                                  if (consentForBiometric) {
                                                                    var isAuthenticated =
                                                                        await settingsMenuController
                                                                            .utility
                                                                            .authenticateMe();
                                                                    if (isAuthenticated) {
                                                                      Map<String,
                                                                              dynamic>
                                                                          parameters =
                                                                          new Map<
                                                                              String,
                                                                              dynamic>();
                                                                      parameters[
                                                                              Strings.mobile_no] =
                                                                          mobile;
                                                                      parameters[
                                                                              Strings.email] =
                                                                          email;
                                                                      parameters[
                                                                              Strings.date_time] =
                                                                          getCurrentDateAndTime();
                                                                      if (value) {
                                                                        firebaseEvent(
                                                                            Strings.touch_id_enable,
                                                                            parameters);
                                                                      } else {
                                                                        firebaseEvent(
                                                                            Strings.touch_id_disable,
                                                                            parameters);
                                                                      }

                                                                      settingsMenuController
                                                                          .isFingerEnable
                                                                          .value = value;
                                                                      settingsMenuController
                                                                          .preferences
                                                                          .setFingerprintEnable(
                                                                              value);
                                                                    }
                                                                  } else {
                                                                    settingsMenuController
                                                                        .allowBiometricDialog(
                                                                            context,
                                                                            value);
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                            onExpansionChanged: (value) {
                              //if any one tile is expanded, other tiles will collapse
                              setState(() {
                                settingsMenuController
                                    .isSecurityExpansion.value = value;
                                if (settingsMenuController
                                    .isSecurityExpansion.isTrue) {
                                  settingsMenuController
                                      .isHelpFaqExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileFAQcontroller
                                      .collapse();
                                  settingsMenuController
                                      .isAccountExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileAccountcontroller
                                      .collapse();
                                  if (widget.isKYCCompleted) {
                                    settingsMenuController
                                        .isKYCExpansion.value = false;
                                    settingsMenuController
                                        .expansionTileKYCcontroller
                                        .collapse();
                                  }
                                }
                              });
                            },
                            backgroundColor: colorBg,
                          ),
                          ExpansionTile(
                            key: settingsMenuController.expansionTileAccount,
                            // maintainState: false,
                            leading: Image(
                              image:
                                  AssetImage(AssetsImagePath.account_details),
                              width: 23,
                              height: 23,
                            ),
                            trailing: settingsMenuController
                                    .isAccountExpansion.isTrue
                                ? Image(
                                    image: AssetImage(
                                        AssetsImagePath.down_arrow_imageicon),
                                  )
                                : Image(
                                    image: AssetImage(
                                        AssetsImagePath.right_arrow_imageicon),
                                  ),
                            title: Text(
                              Strings.account_detail,
                              style: TextStyle(
                                  color: settingsMenuController
                                          .isAccountExpansion.isTrue
                                      ? red
                                      : appTheme,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              settingsMenuController.isAccountExpansion.isTrue
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(50, 0, 0, 10),
                                      child: Column(
                                        children: [
                                          Divider(color: colorGrey),
                                          GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image(
                                                      image: AssetImage(
                                                          AssetsImagePath
                                                              .cams_email_id),
                                                      width: 23,
                                                      height: 23,
                                                      color: colorGreen),
                                                  SizedBox(width: 10),
                                                  Text('Cams Email ID',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              settingsMenuController
                                                      .loanApplicationStatus
                                                      .value =
                                                  widget.alertDataResponseEntity
                                                      .loanApplicationStatus!;
                                              settingsMenuController
                                                      .instrumentType.value =
                                                  widget.alertDataResponseEntity
                                                      .instrumentType!;
                                              settingsMenuController
                                                      .loanName.value =
                                                  widget.alertDataResponseEntity
                                                      .loanName!;
                                              //TODO Navigate to Additional Details screen
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             AdditionalAccountDetailScreen(4, loanApplicationStatus, loanName, instrumentType))); // Cams email screen
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                            onExpansionChanged: (value) {
                              setState(() {
                                settingsMenuController
                                    .isAccountExpansion.value = value;
                                if (settingsMenuController
                                    .isAccountExpansion.isTrue) {
                                  settingsMenuController
                                      .isSecurityExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileSecuritycontroller
                                      .collapse();
                                  settingsMenuController
                                      .isHelpFaqExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileFAQcontroller
                                      .collapse();
                                  if (widget.isKYCCompleted) {
                                    settingsMenuController
                                        .isKYCExpansion.value = false;
                                    settingsMenuController
                                        .expansionTileKYCcontroller
                                        .collapse();
                                  }
                                }
                              });
                            },
                            backgroundColor: colorBg,
                          ),
                          widget.isKYCCompleted
                              ? ExpansionTile(
                                  backgroundColor: colorBg,
                                  key: settingsMenuController.expansionTileKYC,
                                  // maintainState: false,
                                  leading: Image(
                                    image: AssetImage(
                                        AssetsImagePath.manage_kyc_icon),
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: settingsMenuController
                                          .isKYCExpansion.isTrue
                                      ? Image(
                                          image: AssetImage(AssetsImagePath
                                              .down_arrow_imageicon),
                                        )
                                      : Image(
                                          image: AssetImage(AssetsImagePath
                                              .right_arrow_imageicon),
                                        ),
                                  title: Text(
                                    Strings.manage_kyc,
                                    style: TextStyle(
                                        color: settingsMenuController
                                                .isKYCExpansion.isTrue
                                            ? red
                                            : appTheme,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children: <Widget>[
                                    settingsMenuController.isKYCExpansion.isTrue
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 0, 0, 10),
                                            child: SizedBox(),
                                            //TODO Manage KYC Screen
                                            //ManageKYCMenu(widget.alertData), //KYC tiles
                                          )
                                        : SizedBox(),
                                  ],
                                  onExpansionChanged: (value) {
                                    setState(() {
                                      settingsMenuController
                                          .isKYCExpansion.value = value;
                                      if (settingsMenuController
                                          .isKYCExpansion.isTrue) {
                                        settingsMenuController
                                            .isSecurityExpansion.value = false;
                                        settingsMenuController
                                            .expansionTileSecuritycontroller
                                            .collapse();
                                        settingsMenuController
                                            .isHelpFaqExpansion.value = false;
                                        settingsMenuController
                                            .expansionTileFAQcontroller
                                            .collapse();
                                        settingsMenuController
                                            .isAccountExpansion.value = false;
                                        settingsMenuController
                                            .expansionTileAccountcontroller
                                            .collapse();
                                      }
                                    });
                                  },
                                )
                              : SizedBox(),
                          ExpansionTile(
                            backgroundColor: colorBg,
                            key: settingsMenuController.expansionTileFAQ,
                            // maintainState: false,
                            leading: Image(
                              image: AssetImage(AssetsImagePath.faq),
                              width: 23,
                              height: 23,
                              color: red,
                            ),
                            trailing: settingsMenuController
                                    .isHelpFaqExpansion.isTrue
                                ? Image(
                                    image: AssetImage(
                                        AssetsImagePath.down_arrow_imageicon),
                                  )
                                : Image(
                                    image: AssetImage(
                                        AssetsImagePath.right_arrow_imageicon),
                                  ),
                            title: Text(
                              Strings.terms_and_privacy,
                              style: TextStyle(
                                  color: settingsMenuController
                                          .isHelpFaqExpansion.isTrue
                                      ? red
                                      : appTheme,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              settingsMenuController.isHelpFaqExpansion.isTrue
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(50, 0, 0, 10),
                                      child: SizedBox(),
                                      //TODO Help FAQ Screen
                                      //HelpFaqSettingMenu(), // FAQ Web view screen
                                    )
                                  : SizedBox(),
                            ],
                            onExpansionChanged: (value) {
                              setState(() {
                                settingsMenuController
                                    .isHelpFaqExpansion.value = value;
                                if (settingsMenuController
                                    .isHelpFaqExpansion.isTrue) {
                                  settingsMenuController
                                      .isSecurityExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileSecuritycontroller
                                      .collapse();
                                  settingsMenuController
                                      .isAccountExpansion.value = false;
                                  settingsMenuController
                                      .expansionTileAccountcontroller
                                      .collapse();
                                  if (widget.isKYCCompleted) {
                                    settingsMenuController
                                        .isKYCExpansion.value = false;
                                    settingsMenuController
                                        .expansionTileKYCcontroller
                                        .collapse();
                                  }
                                }
                              });
                            },
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
