import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/more/presentation/controllers/more_controller.dart';
import 'package:shimmer/shimmer.dart';

class MoreView extends GetView<MoreController> {

  // void userLogout(BuildContext context) async {
  //   String firebaseToken = await preferences.getFirebaseToken();
  //   LogoutRequestBean logoutRequestBean = LogoutRequestBean(firebaseToken: firebaseToken);
  //   Utility.isNetworkConnection().then((isNetwork) {
  //     if (isNetwork) {
  //       LoadingDialogWidget.showDialogLoading(context, "Logging out...");
  //       profileBloc.userLogout(logoutRequestBean).then((value) {
  //         Navigator.pop(context); //pop dialog
  //         Navigator.pop(context); //pop dialog
  //         if (value.isSuccessFull!) {
  //           preferences.clearPreferences();
  //           Utility.showToastMessage(value.message!.message!);
  //           preferences.setFingerprintEnable(true);
  //           preferences.setPanName(userFullName!);
  //           preferences.setLoanList(list);
  //
  //           if (registerData!.pendingEsigns!.length != 0) {
  //             preferences.setEsign(true);
  //           } else {
  //             preferences.setEsign(false);
  //           }
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (BuildContext context) => PinScreen(),
  //             ),
  //             (route) => false,
  //           );
  //         } else {
  //           Utility.showToastMessage(value.message!.message!);
  //         }
  //       });
  //     } else {
  //       showSnackBar(_scaffoldKey);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: ()=> controller.logOutClicked() ,
              child: Text(
                Strings.logout,
                style:
                TextStyle(color: red, fontSize: 14.0, fontWeight: semiBold),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: colorBg,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: headingText("More"),
                  ),
                  IconButton(
                    icon: Image.asset(AssetsImagePath.manage_settings_icon,
                        width: 23.0, height: 25.0, color: appTheme),
                    onPressed: ()=> controller.manageSettingsClicked(),
                  )
                ],
              ),
              Card(
                elevation: 0.5,
                color: colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CircleAvatar(
                          backgroundColor: colorLightBlue,
                          backgroundImage: controller.profilePhotoUrl.isNotEmpty
                              ? NetworkImage(controller.profilePhotoUrl.value)
                              : AssetImage(AssetsImagePath.profile)as ImageProvider,
                          radius: 40.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: Column(
                          children: [
                            Text(
                              controller.userFullName?.value ?? "",
                              style: boldTextStyle_24,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            controller.lastLogin != null
                                ? Text(controller.lastLogin != null
                                ? 'Last Login : ${controller.lastLogin}' : "",
                                style: boldTextStyle_14, textAlign: TextAlign.center)
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              controller.isAPIRespond.value
                  ? Column(
                children: <Widget>[
                  controller.isLoanExist.value
                      ? GestureDetector(
                    child: ReusableMoreIconTileCard(
                      assetsImagePath:
                      AssetsImagePath.increase_limit,
                      tileText: Strings.increase_loan,
                    ),
                    onTap: ()=> controller.increaseLimitClicked(),
                  )
                      : SizedBox(),
//                  isLoanExist ? GestureDetector(
//                    onTap: () {
//                      if (loanBalance <= drawingPower) {
//                        Utility.isNetworkConnection().then((isNetwork) {
//                          if (isNetwork) {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (BuildContext contex) => LoanWithdrawScreen(loanName)));
//                          } else {
//                            Utility.showToastMessage(Strings.no_internet_message);
//                          }
//                        });
//                      } else {
//                        Utility.showToastMessage(Strings.withdraw_amount_message);
//                      }
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.atm,
//                      tileText: toTitleCase(Strings.withdraw),
//                    ),
//                  )
//                      : SizedBox(),
                  controller.isLoanExist.value
                      ? GestureDetector(
                    onTap: ()=> controller.sellCollateralOrInvokeClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath:
                      AssetsImagePath.sell_collateral,
                      tileText: controller.loanType == Strings.shares ? Strings.sell_collateral : Strings.invoke,
                    ),
                  )
                      : SizedBox(),
                  controller.isLoanExist.value
                      ? GestureDetector(
                    onTap: ()=>controller.loanAccStatementClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.document,
                      tileText: Strings.statement,
                    ),
                  )
                      : SizedBox(),
                  controller.isLoanExist.value
                      ? GestureDetector(
                    onTap: ()=>controller.paymentClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.credit_card,
                      tileText: "Payment",
                    ),
                  )
                      : SizedBox(),
                  controller.isKYCCompleted.value
                      ? controller.isEmailVerified.value
                      ? controller.canPledge == 1
                      ? GestureDetector(
                    onTap: ()=> controller.pledgeClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.pledge,
                      tileText: Strings.pledge,
                    ),
                  )
                      : SizedBox()
                      : SizedBox()
                      : SizedBox(),
                  // SizedBox(height: 15),
                  controller.isLoanExist.value
                      ? GestureDetector(
                    onTap: ()=> controller.unPledgeClicked() ,
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.unpledge,
                      tileText: controller.loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                    ),
                  )
                      : SizedBox(),
//                  userEsign != null ? GestureDetector(
//                    onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.unpledge,
//                      tileText: toTitleCase("UnPledge"),
//                    ),
//                  ):Container(),
//                   !isKYCCompleted
//                         GestureDetector(
//                           onTap: () {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 // Firebase Event
//                                 Map<String, dynamic> parameter = new Map<String, dynamic>();
//                                 parameter[Strings.mobile_no] = mobileExist;
//                                 parameter[Strings.date_time] = getCurrentDateAndTime();
//                                 firebaseEvent(Strings.check_eligible_lender, parameter);
//
//                                 // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SecuritySelectionScreen()));
//
//                                 // showModalBottomSheet(
//                                 //     backgroundColor: Colors.transparent,
//                                 //     context: context,
//                                 //     isScrollControlled: true,
//                                 //     builder: (BuildContext bc) {
//                                 //       return LenderScreen(isEmailVerified, canPledge);
//                                 //     });
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: ReusableMoreIconTileCard(
//                             assetsImagePath: AssetsImagePath.history_grey,
//                             tileText: toTitleCase(Strings.check_eligible_limit),
//                           ),
//                         ),
                  GestureDetector(
                    onTap: ()=>controller.approvedSchemeOrSecurityClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.approved_security_list_icon,
                      tileText: controller.loanType == Strings.mutual_fund ? Strings.approved_scheme: Strings.approved_security,
                    ),
                  ),
                  // : SizedBox(),
                  /* SizedBox(
                    height: 15,
                  ),*/
//                   SizedBox(height: 15),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (BuildContext context) => EligibilityScreen()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.history_grey,
//                      tileText: toTitleCase("Eligibility"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Track My Application/Requests"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Upload TDS certificates"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("FAQs"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (BuildContext context) => ReferAndEarnScreen()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Refer & Win"),
//                    ),
//                  ),

//                   SizedBox(height: 15),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.unpledge,
                  //     tileText: toTitleCase("Unpledge"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.unpledge,
                  //     tileText: toTitleCase("My Inactive Loan"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.share,
                  //     tileText: toTitleCase("Upload TDS certificates"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) => ReferAndEarnScreen()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.share,
                  //     tileText: toTitleCase("Refer & Win"),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: ()=> controller.feedbackClicked(),
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.mail,
                      tileText: "Feedback",
                    ),
                  ),
                  // GestureDetector(
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.phone,
                  //     tileText: toTitleCase("Contact us"),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 ContactUsScreen()));
                  //   },
                  // ),

                  // SizedBox(height: 10),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.unpledge,
                  //     tileText: toTitleCase("Unpledge"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.unpledge,
                  //     tileText: toTitleCase("My Inactive Loan"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.share,
                  //     tileText: toTitleCase("Upload TDS certificates"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) => ReferAndEarnScreen()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.share,
                  //     tileText: toTitleCase("Refer & Win"),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (BuildContext context) => FeedbackScreen()));
                  //   },
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.mail,
                  //     tileText: toTitleCase("Feedback/Rate us"),
                  //   ),
                  // ),
                  GestureDetector(
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.phone,
                      tileText: Strings.contact_us,
                    ),
                    onTap: ()=> controller.contactUsClicked(),
                  ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.settings,
//                      tileText: toTitleCase("Settings"),
//                    ),
//                    onTap: (){
//                      Utility.isNetworkConnection().then((isNetwork) {
//                        if (isNetwork) {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      AccountSettingScreen(userFullName,mobileExist,userEmail,true)));
//                        } else {
//                          Utility.showToastMessage(
//                              Strings.no_internet_message);
//                        }
//                      });
//                    },
//                  ),
                  // GestureDetector(
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.settings,
                  //     tileText: toTitleCase("Settings"),
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 AccountSettingScreen(userFullName,mobileExist,userEmail,true)));
                  //   },
                  // ),
                  GestureDetector(
                    child: ReusableMoreIconTileCard(
                      assetsImagePath: AssetsImagePath.faq,
                      tileText: "FAQ",
                    ),
                    onTap: ()=>controller.fAQClicked() ,
                  ),
                  // GestureDetector(
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.privacy_policy,
                  //     tileText: toTitleCase(Strings.privacy_policy),
                  //   ),
                  //   onTap: () {
                  //     Utility.isNetworkConnection().then((isNetwork) {
                  //       if (isNetwork) {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     CommonWebViewScreen(
                  //                         2, Strings.privacy_policy)));
                  //       } else {
                  //         Utility.showToastMessage(
                  //             Strings.no_internet_message);
                  //       }
                  //     });
                  //   },
                  // ),
                  // GestureDetector(
                  //   child: ReusableMoreIconTileCard(
                  //     assetsImagePath: AssetsImagePath.terms_of_use,
                  //     tileText: toTitleCase(Strings.terms_of_use),
                  //   ),
                  //   onTap: () {
                  //     Utility.isNetworkConnection().then((isNetwork) {
                  //       if (isNetwork) {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     CommonWebViewScreen(
                  //                         3, Strings.terms_of_use)));
                  //       } else {
                  //         Utility.showToastMessage(
                  //             Strings.no_internet_message);
                  //       }
                  //     });
                  //   },
                  // ),
                  SizedBox(height: 10),
                  version(),
                  SizedBox(height: 70),
                ],
              )
                  : shimmerEffect(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerEffect() {
    return Visibility(
      visible: !controller.isAPIRespond.value,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget version() {
    return Center(
      child: Text('Version ${controller.versionName != null ? controller.versionName : ""}'),
    );
  }
}

Future<void> logoutConfirmDialog(MoreController controller) async {
  return Get.dialog<void>(
      barrierDismissible: false, // user must tap button for close dialog!
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: colorWhite,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  headingText(Strings.SignOut),
                  SizedBox(
                    height: 10,
                  ),
                  Text(Strings.message_sign_out,
                      style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text(Strings.alert_button_no,
                            style: TextStyle(color: colorLightAppTheme)),
                        onPressed: ()=> Get.back(result: Strings.alert_button_no),
                      ),
                      TextButton(
                        child: const Text(Strings.alert_button_yes,
                            style: TextStyle(color: colorLightAppTheme)),
                        onPressed: ()=> controller.yesClicked(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
  );
}

class ReusableMoreIconTileCard extends StatelessWidget {
  final String tileText;
  final String assetsImagePath;

  ReusableMoreIconTileCard({required this.tileText, required this.assetsImagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 2.0,
        color: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: IconButton(
            icon: Image.asset(assetsImagePath, width: 25, height: 25, color: colorGrey),
            onPressed: null,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: Text(tileText, style: mediumTextStyle_18_gray_dark)),
              Image.asset(AssetsImagePath.forward, width: 8.54, height: 17.08),
            ],
          ),
        ),
      ),
    );
  }
}