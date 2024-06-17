import 'package:lms/additional_account_detail//AdditionalAccountDetailScreen.dart';
import 'package:lms/account_setting//HelpFaqSettingMenu.dart';
import 'package:lms/account_setting//ManageKYCMenu.dart';
import 'package:lms/account_setting/ChangePassword.dart';
import 'package:lms/custom_plugin/AppExpansionTile.dart';
import 'package:lms/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/terms_conditions/TermsConditionWebView.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:local_auth/local_auth.dart';


class ManageSettingScreen extends StatefulWidget {

  bool isKYCCompleted;
  AlertData alertData;

  ManageSettingScreen(this.isKYCCompleted, this.alertData);

  @override
  _ManageSettingScreenState createState() => _ManageSettingScreenState();
}

class _ManageSettingScreenState extends State<ManageSettingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? instrumentType;
  String? loanApplicationStatus;
  String? pledgorBoid;
  String? myCamsEmail;
  String? loanName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(left: 14, right: 14),
        child: Container(
          height: (MediaQuery.of(context).size.height) - (200),
          width: double.infinity,
          margin: EdgeInsets.only(left: 4, right: 4),
          decoration: new BoxDecoration(
            color: colorWhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: SettingMenu(widget.isKYCCompleted, widget.alertData, 1),
        ),
      ),
    );
  }
}

class SettingMenu extends StatefulWidget {

  bool isKYCCompleted;
  AlertData alertData;
  int isSettingOpen;

  SettingMenu(this.isKYCCompleted, this.alertData, this.isSettingOpen);

  @override
  _SettingMenuState createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {

  bool isPaymentExpansion = false;
  bool isSecurityExpansion = false;
  bool isAccountExpansion = false;
  bool isReminderExpansion = false;
  bool isAddressExpansion = false;
  bool isKYCExpansion = false;
  bool isHelpFaqExpansion = false;
  bool isSignOutExpansion = false;
  Utility utility = Utility();
  Preferences preferences = Preferences();
  var pinExist,
      panExist,
      mobileExist,
      userDOB;
  bool? isUserEnableFingerprint;
  var isFingerSupport = false;
  final GlobalKey<AppExpansionTileState> expansionTileSecurity = new GlobalKey();
  final GlobalKey<AppExpansionTileState> expansionTileAccount = new GlobalKey();
  final GlobalKey<AppExpansionTileState> expansionTileKYC = new GlobalKey();
  final GlobalKey<AppExpansionTileState> expansionTileFAQ = new GlobalKey();
  bool isFingerEnable = false;
  List<BiometricType> availableBiometricType = <BiometricType>[];
  String? instrumentType;
  String? loanApplicationStatus;
  String? pledgorBoid;
  String? myCamsEmail;
  String? loanName;

  @override
  void initState() {
    autoFetchData();
    super.initState();
  }

  autoFetchData() async { //fetch data from preference
    pinExist = await preferences.getPin();
    printLog("pin:::$pinExist");
    // panExist = await preferences.getPAN();
    // printLog("panExist:::$panExist");
    mobileExist = await preferences.getMobile();
    printLog("mobileExist:::$mobileExist");
    // userDOB = await preferences.getDOB();
    // printLog("userDOB:::$userDOB");
    isFingerSupport = await utility.getBiometricsSupport();
    printLog("isFingerSupport:::$isFingerSupport");
    isUserEnableFingerprint = await preferences.getFingerprintEnable();
    printLog("isUserEnableFingerprint:::$isUserEnableFingerprint");

    availableBiometricType = await utility.getAvailableSupport();
    isFingerEnable = await preferences.getFingerprintEnable();
    setState((){
      if(availableBiometricType.isEmpty){
        isFingerEnable = false;
        preferences.setFingerprintEnable(false);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
          body: Column(
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
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              if(widget.isSettingOpen == 0) {
                                var value = await showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return ManageSettingScreen(
                                        widget.isKYCCompleted,
                                        widget.alertData);
                                  },
                                );
                                autoFetchData();
                              }
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Image(
                          image: AssetImage(AssetsImagePath.manage_settings_icon),
                          width: 23,
                          height: 23,
                          color: red
                        ),
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
                      AppExpansionTile(
                        key: expansionTileSecurity,
                        // maintainState: false,
                        leading: Image(
                          image: AssetImage(AssetsImagePath.security_settings_icon),
                          width: 23,
                          height: 23,
                        ),
                        trailing: isSecurityExpansion ? Image(
                          image: AssetImage(AssetsImagePath.down_arrow_imageicon),
                        ) : Image(
                          image: AssetImage(AssetsImagePath.right_arrow_imageicon),
                        ),
                        title: Text(
                          Strings.security_setting,
                          style: TextStyle(color: isSecurityExpansion?red:appTheme, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          isSecurityExpansion ? Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: colorGrey),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image(image: AssetImage(AssetsImagePath.signout_icon), width: 23, height: 23, color: colorGreen),
                                        SizedBox(width: 10),
                                        Text('Change Pin',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return ChangePassword();  // change pin popup
                                      },
                                    );
                                  },
                                ),
                                isFingerSupport ? Divider(color: colorGrey) : SizedBox(),
                                isFingerSupport ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image(image: AssetImage(AssetsImagePath.biometric),
                                          width:23, height:23, color: colorGreen),
                                      SizedBox(width: 10),
                                      Text(Strings.biometric,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          if(availableBiometricType.isEmpty){
                                            commonDialog(context, Strings.ac_setting_biometric_alert_msg, 0);
                                          }
                                        },
                                        child: AbsorbPointer(
                                          absorbing: availableBiometricType.isEmpty ? true : false,
                                          child: Container(
                                            height: 26,
                                            width: 65,
                                            child: FlutterSwitch( // biometric toggle
                                              value: isFingerEnable,
                                              activeColor: colorGreen,
                                              showOnOff: true,
                                              // activeText: "On",
                                              activeTextColor: colorWhite,
                                              // inactiveText: "Off",
                                              inactiveTextColor: colorWhite,
                                              onToggle: (value) async {
                                                String email = await preferences.getEmail();
                                                String? mobile = await preferences.getMobile();
                                                if (availableBiometricType.isEmpty) {
                                                  commonDialog(context, Strings.ac_setting_biometric_alert_msg, 0);
                                                  setState(() {
                                                    isFingerEnable = false;
                                                    preferences.setFingerprintEnable(false);
                                                  });
                                                } else {
                                                  bool consentForBiometric = await preferences.getFingerprintConsent();
                                                  if(consentForBiometric){
                                                    var isAuthenticated = await utility.authenticateMe();
                                                    if(isAuthenticated){
                                                      Map<String, dynamic> parameters = new Map<String, dynamic>();
                                                      parameters[Strings.mobile_no] = mobile;
                                                      parameters[Strings.email] = email;
                                                      parameters[Strings.date_time] = getCurrentDateAndTime();
                                                      if(value) {
                                                        firebaseEvent(Strings.touch_id_enable, parameters);
                                                      } else {
                                                        firebaseEvent(Strings.touch_id_disable, parameters);
                                                      }
                                                      setState(() {
                                                        isFingerEnable = value;
                                                        preferences.setFingerprintEnable(value);
                                                      });
                                                    }
                                                  }else{
                                                    allowBiometricDialog(context, value);
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ): SizedBox(),
                              ],
                            ),
                          ) : SizedBox(),
                        ],
                        onExpansionChanged: (value){ //if any one tile is expanded, other tiles will collapse
                          setState(() {
                            isSecurityExpansion = value;
                            if(isSecurityExpansion){
                              isHelpFaqExpansion = false;
                              expansionTileFAQ.currentState!.collapse();
                              isAccountExpansion = false;
                              expansionTileAccount.currentState!.collapse();
                              if(widget.isKYCCompleted) {
                                isKYCExpansion = false;
                                expansionTileKYC.currentState!.collapse();
                              }
                            }
                          });
                        }, backgroundColor: colorBg,
                      ),
                      AppExpansionTile(
                        key: expansionTileAccount,
                        // maintainState: false,
                        leading: Image(
                          image: AssetImage(AssetsImagePath.account_details),
                          width: 23,
                          height: 23,
                        ),
                        trailing: isAccountExpansion ? Image(
                          image: AssetImage(AssetsImagePath.down_arrow_imageicon),
                        ) : Image(
                          image: AssetImage(AssetsImagePath.right_arrow_imageicon),
                        ),
                        title: Text(
                          Strings.account_detail,
                          style: TextStyle(color: isAccountExpansion?red:appTheme, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          isAccountExpansion ? Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
                            child: Column(
                              children: [
                                Divider(color: colorGrey),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image(image: AssetImage(AssetsImagePath.cams_email_id), width: 23, height: 23, color: colorGreen),
                                        SizedBox(width: 10),
                                        Text('Cams Email ID',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    loanApplicationStatus = widget.alertData.loanApplicationStatus;
                                    instrumentType = widget.alertData.instrumentType;
                                    loanName = widget.alertData.loanName;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdditionalAccountDetailScreen(4, loanApplicationStatus, loanName, instrumentType))); // Cams email screen
                                  },
                                ),
                              ],
                            ),
                          ) : SizedBox(),
                        ],
                        onExpansionChanged: (value){
                          setState(() {
                            isAccountExpansion = value;
                            if(isAccountExpansion){
                              isSecurityExpansion = false;
                              expansionTileSecurity.currentState!.collapse();
                              isHelpFaqExpansion = false;
                              expansionTileFAQ.currentState!.collapse();
                              if(widget.isKYCCompleted) {
                                isKYCExpansion = false;
                                expansionTileKYC.currentState!.collapse();
                              }
                            }

                          });
                        }, backgroundColor: colorBg,
                      ),
                      widget.isKYCCompleted ? AppExpansionTile(
                        backgroundColor: colorBg,
                        key: expansionTileKYC,
                        // maintainState: false,
                        leading: Image(
                          image: AssetImage(AssetsImagePath.manage_kyc_icon),
                          width: 23,
                          height: 23,
                        ),
                        trailing: isKYCExpansion ? Image(
                          image: AssetImage(AssetsImagePath.down_arrow_imageicon),
                        ) : Image(
                          image: AssetImage(AssetsImagePath.right_arrow_imageicon),
                        ),
                        title: Text(
                          Strings.manage_kyc,
                          style: TextStyle(color: isKYCExpansion ? red:appTheme, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          isKYCExpansion ? Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
                            child: ManageKYCMenu(widget.alertData), //KYC tiles
                          ) : SizedBox(),
                        ],
                        onExpansionChanged: (value){
                          setState(() {
                            isKYCExpansion = value;
                            if(isKYCExpansion){
                              isSecurityExpansion = false;
                              expansionTileSecurity.currentState!.collapse();
                              isHelpFaqExpansion = false;
                              expansionTileFAQ.currentState!.collapse();
                              isAccountExpansion = false;
                              expansionTileAccount.currentState!.collapse();
                            }
                          });
                        },
                      ) : SizedBox(),
                      AppExpansionTile(
                        backgroundColor: colorBg,
                        key: expansionTileFAQ,
                        // maintainState: false,
                        leading: Image(
                          image: AssetImage(AssetsImagePath.faq),
                          width: 23,
                          height: 23,
                          color: red,),
                        trailing: isHelpFaqExpansion ? Image(
                          image: AssetImage(AssetsImagePath.down_arrow_imageicon),
                        ) : Image(
                          image: AssetImage(AssetsImagePath.right_arrow_imageicon),
                        ),
                        title: Text(
                          Strings.terms_and_privacy,
                          style: TextStyle(color: isHelpFaqExpansion ? red:appTheme, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          isHelpFaqExpansion ? Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
                            child: HelpFaqSettingMenu(), // FAQ Web view screen
                          ) : SizedBox(),
                        ],
                        onExpansionChanged: (value){
                          setState(() {
                            isHelpFaqExpansion = value;
                            if(isHelpFaqExpansion){
                              isSecurityExpansion = false;
                              expansionTileSecurity.currentState!.collapse();
                              isAccountExpansion = false;
                              expansionTileAccount.currentState!.collapse();
                              if(widget.isKYCCompleted) {
                                isKYCExpansion = false;
                                expansionTileKYC.currentState!.collapse();
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
    );
  }

  Future<bool> allowBiometricDialog(BuildContext context, bool value) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text("Biometric Access", style: boldTextStyle_16),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Why is Spark.Loans asking for use of Biometric Authentication?\n\nUse biometric login with your fingerprint or face for faster and easier access to your account.\n\nPermission can be changed at anytime from the device setting.\n\nIn case of any doubts, please visit our ',style: regularTextStyle_12_gray_dark),
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
                                  preferences.setFingerprintConsent(true);
                                  preferences.setBiometricConsent(true);
                                  String email = await preferences.getEmail();
                                  String? mobile = await preferences.getMobile();
                                  var isAuthenticated = await utility.authenticateMe();
                                  if(isAuthenticated){
                                    Map<String, dynamic> parameters = new Map<String, dynamic>();
                                    parameters[Strings.mobile_no] = mobile;
                                    parameters[Strings.email] = email;
                                    parameters[Strings.date_time] = getCurrentDateAndTime();
                                    if(value) {
                                      firebaseEvent(Strings.touch_id_enable, parameters);
                                    } else {
                                      firebaseEvent(Strings.touch_id_disable, parameters);
                                    }
                                    preferences.setFingerprintEnable(true);
                                    setState(() {
                                      isFingerEnable = value;
                                    });
                                  } else {
                                    preferences.setFingerprintEnable(false);
                                  }
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

  Future<void> logoutConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.SignOut),
          content: const Text(
            Strings.message_sign_out,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(Strings.alert_button_no),
              onPressed: () {
                Navigator.of(context).pop(Strings.alert_button_no);
              },
            ),
            TextButton(
              child: const Text(Strings.alert_button_yes),
              onPressed: () {
                preferences.clearPreferences();
                preferences.setMobile(mobileExist);
                preferences.setPin(pinExist);
                // preferences.setLoggedOut("true");
                // preferences.setPAN(panExist);
                // preferences.setDOB(userDOB);
                if (isFingerSupport) {
                  if (isUserEnableFingerprint!) {
                    preferences.setFingerprintEnable(true);
                  }
                }
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PinScreen(false),
                  ),
                      (route) => false,
                );
                //userLogout(context);
              },
            )
          ],
        );
      },
    );
  }
}