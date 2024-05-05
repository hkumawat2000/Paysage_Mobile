import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:choice/account_setting//AccountSettingBloc.dart';
import 'package:choice/account_setting//ManageSettingMenu.dart';
import 'package:choice/login/LoginBloc.dart';
import 'package:choice/network/requestbean/UpdateProfileAndPinRequestBean.dart';
import 'package:choice/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../terms_conditions/TermsConditionWebView.dart';
import '../util/Preferences.dart';
import '../util/Style.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final loginBloc = LoginBloc();
  final _accountSettingBloc = AccountSettingBloc();
  String? userName = "";
  String? userMobileNo = "";
  String? userEmail = "";
  String? profileImage = "";
  File? image;
  bool? isKYCCompleted;
  Preferences preferences = new Preferences();

//  File image;
//  String userName, userMobileNo, userEmail, profileImage;
//  bool isKYCCompleted;
  bool isAPIResponse = false;
  AlertData alertData = AlertData();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    getProfileAPI();
    super.initState();
  }

  getProfileAPI() {
    loginBloc.getProfileSetAlert(0, 0, 0).then((value) {
      if (value.isSuccessFull!) {
        setState(() {
          isAPIResponse = true;
          isKYCCompleted =
              value.alertData!.customerDetails!.kycUpdate == 1 ? true : false;
          if (value.alertData!.userKyc != null) {
            if(value.alertData!.userKyc!.kycStatus == "Pending" || value.alertData!.userKyc!.kycStatus == "Rejected"){
              userName = value.alertData!.customerDetails!.fullName!;
            }else{
              userName = value.alertData!.userKyc!.fullname!;
            }
          } else {
            userName = value.alertData!.customerDetails!.fullName;
          }
          userMobileNo = value.alertData!.customerDetails!.phone;
          userEmail = value.alertData!.customerDetails!.user;
          alertData = value.alertData!;
          if (value.alertData!.profilePhotoUrl != null) {
            profileImage = value.alertData!.profilePhotoUrl!;
          }
        });
      } else if (value.errorCode == 403) {
        isAPIResponse = false;
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        isAPIResponse = false;
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, "cancel");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: buildAppBar(context),
        body: SafeArea(
          child: isAPIResponse
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
                        profileInfoCard(),   // profile card
                        SizedBox(height: 10),
                        // kycDetailsPendingCard(),
                        Expanded(child: accountSettingMenu()),  // setting menu popup
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

  // Widget settingHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           padding: EdgeInsets.zero,
  //           constraints: BoxConstraints(),
  //           icon: ArrowToolbarBackwardNavigation(),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //         Spacer(),
  //         Text(
  //           Strings.account_setting,
  //           style: TextStyle(
  //               color: red,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18,
  //               fontFamily: 'Gilroy'),
  //           textAlign: TextAlign.center,
  //         ),
  //         Spacer(),
  //         // Image.asset(
  //         //   AssetsImagePath.notification_icon,
  //         //   width: 22.0,
  //         //   height: 22.0,
  //         //   color: appTheme,
  //         // ),
  //         // SizedBox(width: 6),
  //         // GestureDetector(
  //         //   child: Image.asset(
  //         //     AssetsImagePath.setting_icon,
  //         //     width: 22.0,
  //         //     height: 22.0,
  //         //     color: appTheme,
  //         //   ),
  //         //   onTap: () {
  //         //     Utility.isNetworkConnection().then((isNetwork) {
  //         //       if (isNetwork) {
  //         //         showModalBottomSheet(
  //         //           backgroundColor: Colors.transparent,
  //         //           context: context,
  //         //           isScrollControlled: true,
  //         //           isDismissible: false,
  //         //           enableDrag: false,
  //         //           builder: (BuildContext bc) {
  //         //             return ManageSettingScreen();
  //         //           },
  //         //         );
  //         //       } else {
  //         //         Utility.showToastMessage(Strings.no_internet_message);
  //         //       }
  //         //     });
  //         //   },
  //         // ),
  //       ],
  //     ),
  //   );
  // }

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
                      userName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: appTheme),
                    ),
                    SizedBox(height: 6),
                    Text(
                      encryptAcNo(userMobileNo!),
                      style: TextStyle(fontSize: 15, color: appTheme),
                    ),
                    SizedBox(height: 2),
                    Text(
                      userEmail!.replaceRange(
                          userEmail!.indexOf('@') > 4 ? 4 : 2,
                          userEmail!.indexOf('@'),
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
                backgroundImage: image != null
                    ? FileImage(image!)
                    : (profileImage != null && profileImage!.isNotEmpty)
                        ? NetworkImage(profileImage!)
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
                          bool photoConsent = await preferences.getPhotoConsent();
                          if(!photoConsent) {
                            permissionYesNoDialog(context);
                          }else{
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

        // Container(
        //     margin: EdgeInsets.only(top: 26),
        //     padding: EdgeInsets.all(10),
        //     alignment: Alignment.topRight,
        //     child: Image(
        //         image: AssetImage(AssetsImagePath.new_share),
        //         width: 20,
        //         height: 20,
        //         color: red),
        // ),
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
                      TextSpan(text: 'Why is Spark.Loans asking for my Storage access?\n\n',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'Spark Loan asked for ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'Storage Access', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' to let you upload the required ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'Documents & Image', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' to avail the services.\nWe do ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'collect /share', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' the Uploaded Document/Images with us and any other third party based on the services availed.\n\nPermission can be changed at anytime from the device settings.\n\nIn case of any doubts, please visit our ',style: regularTextStyle_12_gray_dark),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Utility.isNetworkConnection().then((isNetwork) async {
                              if (isNetwork) {
                                String privacyPolicyUrl = await preferences.getPrivacyPolicyUrl();
                                printLog("privacyPolicyUrl ==> $privacyPolicyUrl");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                        text: "Privacy Policy.",
                        style: boldTextStyle_12_gray_dark.copyWith(color: Colors.lightBlue)
                      ),
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
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  Navigator.pop(context);
                                } else{
                                  Utility.showToastMessage(Strings.no_internet_message);
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
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Navigator.pop(context);
                                  preferences.setPhotoConsent(true);
                                  uploadPhoto();
                                }else{
                                  Utility.showToastMessage(Strings.no_internet_message);
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
    ) ?? false;
  }

  uploadPhoto() async {
    try {
      String byteImageString;
      XFile? imagePicker = await _picker.pickImage(source: ImageSource.gallery);
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
                initAspectRatio:
                CropAspectRatioPreset.square,
                lockAspectRatio: true)

          ],
        );

        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          byteImageString = base64Encode(bytes);
          Utility.isNetworkConnection().then((isNetwork) {
            if (isNetwork) {
              LoadingDialogWidget.showDialogLoading(context, "Uploading...");
              imageCache.clear();
              imageCache.clearLiveImages();
              UpdateProfileAndPinRequestBean updateProfileAndPinRequestBean =
              new UpdateProfileAndPinRequestBean(
                  isForUpdatePin: 0,
                  oldPin: "1134",
                  newPin: "1234",
                  retypePin: "1234",
                  isForProfilePic: 1,
                  image: byteImageString);
              final Map<String, dynamic> requestData = updateProfileAndPinRequestBean.toJson();
              _accountSettingBloc.setProfileAndPin(requestData).then((value) {
                Navigator.pop(context);
                if (value.isSuccessFull!) {
                  setState(() {
                    if (value.isSuccessFull!) {
                      // Firebase Event
                      Map<String, dynamic> parameters = new Map<String, dynamic>();
                      parameters[Strings.name] = userName;
                      parameters[Strings.mobile_no] = userMobileNo;
                      parameters[Strings.email] = userEmail;
                      parameters[Strings.photo_url] = value.updatedData!.profilePictureFileUrl;
                      parameters[Strings.date_time] = getCurrentDateAndTime();
                      firebaseEvent(Strings.profile_photo_update, parameters);
                      setState(() {
                        image = File(cropped.path);
                        profileImage = value.updatedData!.profilePictureFileUrl;
                        Utility.showToastMessage("Profile picture updated");
                      });
                    } else if (value.errorCode == 403) {
                      commonDialog(context, Strings.session_timeout, 4);
                    } else {
                      if (value.errorMessage != null) {
                        commonDialog(context, value.errorMessage, 0);
                      }
                    }
                  });
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            }
          });
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(context);
      printLog(e.toString());
    }
  }

  // Widget kycDetailsPendingCard() {
  //   return Visibility(
  //     visible: widget.isKYCCompleted == 1? false :true,
  //     child: Column(
  //       children: [
  //         Card(
  //           elevation: 6.0,
  //           color: colorLightYellow,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Image.asset(AssetsImagePath.warning_icon,
  //                     height: 50, width: 50, color: appTheme),
  //                 SizedBox(width: 4),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(Strings.kyc_details_pending,
  //                           style: TextStyle(
  //                               color: red,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 14)),
  //                       Text(
  //                         Strings.kyc_details_text,
  //                         style: TextStyle(
  //                             color: appTheme,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(width: 4),
  //                 GestureDetector(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: appTheme,
  //                         borderRadius: BorderRadius.all(Radius.circular(20))),
  //                     child: Padding(
  //                       padding:
  //                           const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
  //                       child: Text(
  //                         Strings.add_kyc,
  //                         style: TextStyle(
  //                             fontSize: 12,
  //                             color: colorWhite,
  //                             fontWeight: FontWeight.bold,
  //                             fontFamily: 'Gilroy'),
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: (){
  //                     Utility.isNetworkConnection().then((isNetwork) {
  //                       if (isNetwork) {
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (BuildContext context) =>
  //                                     CompleteKYCScreen("")));
  //                       } else {
  //                         Utility.showToastMessage(Strings.no_internet_message);
  //                       }
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //       ],
  //     ),
  //   );
  // }

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
          child: SettingMenu(isKYCCompleted!, alertData, 0),  // setting menu popup
        ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userName', userName));
  }
}
