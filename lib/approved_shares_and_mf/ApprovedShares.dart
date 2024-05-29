import 'dart:io';
import 'package:lms/additional_account_detail/AdditionalAccountDetailScreen.dart';
import 'package:lms/demat_detail_screen/DematDetailsBloc.dart';
import 'package:lms/approved_securities/ApprovedSecuritiesScreen.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeSelectionScreen.dart';
import 'package:lms/pledge_eligibility/shares/SecuritySelectionScreen.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart';

class ApprovedSharesScreen extends StatefulWidget {

  @override
  ApprovedSharesScreenState createState() => ApprovedSharesScreenState();
}

class ApprovedSharesScreenState extends State<ApprovedSharesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final loanApplicationBloc = LoanApplicationBloc();
  List<ShareListData> sharesList = [];
  List<String>? stockAt;
  Preferences preferences = new Preferences();
  DematDetailsBloc dematDetailsBloc = DematDetailsBloc();
  bool? isChoiceUser;

  static List<String> mainDataList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{ // fetch data from preference
    isChoiceUser = await preferences.getIsChoiceUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorBg,
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: ArrowToolbarBackwardNavigation(),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    headingText(Strings.pledge_securities),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        Strings.pledge_securities_sub_heading,
                        style: mediumTextStyle_16_gray,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: appTheme,
                          ),
                          width: 157,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 30.95, left: 20),
                                  child: Image.asset(
                                    AssetsImagePath.shares,
                                    width: 34.57,
                                    height: 52.51,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 20.0),
                                  child: Text(
                                    Strings.shares,
                                    style: extraBoldTextStyle_18_white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              if(isChoiceUser!){
                                dematAcDetailsAPI();
                              } else {
                                commonDialog(context, Strings.coming_soon, 0);
                              }
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: red,
                          ),
                          width: 157,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 34.0, left: 21.02),
                                  child: Image.asset(
                                    AssetsImagePath.mutual_fund,
                                    width: 48,
                                    height: 48.01,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 20.0),
                                  child: Text(
                                    Strings.mutual_fund,
                                    style: extraBoldTextStyle_18_white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              String camsEmail = await preferences.getCamsEmail();
                              printLog("CAMS Email => $camsEmail");
                              if(camsEmail.isNotEmpty){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext
                                        context) =>
                                            MFSchemeSelectionScreen()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext
                                        context) =>
                                            AdditionalAccountDetailScreen(3, "", "", "")));
                              }
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        String? mobile = await preferences.getMobile();
                        String email = await preferences.getEmail();
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            // Firebase Event
                            Map<String, dynamic> parameter = new Map<
                                String,
                                dynamic>();
                            parameter[Strings.mobile_no] = mobile;
                            parameter[Strings.email] = email;
                            parameter[Strings.date_time] =
                                getCurrentDateAndTime();
                            firebaseEvent(
                                Strings.approved_securities_opened, parameter);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ApprovedSecuritiesScreen()));
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                    text: Strings.click_here,
                    style: TextStyle(color: Colors.blue),
                    children: [
                      TextSpan(
                        text: Strings.approved_text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> NonEligibleSecuritiesDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 150,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Strings.nonEligibleSecurities,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBoxHeightWidget(8.0),
                    Text("Do you wish to buy them?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBoxHeightWidget(15.0),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 35,
                        width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed:  () async {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  if(Platform.isAndroid) {
                                    Utility.launchURL(Constants.jiffyPlayStore);
                                  }else{
                                    Utility.launchURL(Constants.jiffyAppStore);
                                  }
                                  // Utility.openJiffy(context);
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              Strings.yes,
                              style: buttonTextWhite,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: red)),
                          elevation: 1.0,
                          color: colorBg,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed:  () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              Strings.no,
                              style: buttonTextRed,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  void dematAcDetailsAPI() { // fetch Demat A/C of user from backend
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
        dematDetailsBloc.dematAcDetails().then((value) {
          Navigator.pop(context);
          if (value.isSuccessFull!) {
            if(value.dematAc != null && value.dematAc!.length != 0){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecuritySelectionScreen(value.dematAc!)));
            } else {
              commonDialog(context, Strings.not_fetch, 0);
            }
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}
