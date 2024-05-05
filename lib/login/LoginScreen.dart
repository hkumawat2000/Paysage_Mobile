import 'package:choice/login/LoginBloc.dart';
import 'package:choice/network/responsebean/AuthResponse/GetTermsandPrivacyResponse.dart';
import 'package:choice/otp/OTPVerificationScreen.dart';
import 'package:choice/terms_conditions/TermsConditionWebView.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final loginBloc = LoginBloc();
  TextEditingController mobileController = TextEditingController();
  Preferences preferences = Preferences();
  var authToken;
  String? versionName;
  bool checkBoxValue = true;
  int acceptTerms = 1;
  TermsOfUseData? termsOfUseData;
  List<String>? dummyAccountList = [];
  FocusNode mobileFocus = new FocusNode();

  @override
  void initState() {
    getPreferences();
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getTermsOfUse();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  void getPreferences() async{
    bool? biometricEnable = await preferences.getFingerprintEnable();
    bool? biometricConsent = await preferences.getFingerprintConsent();
    preferences.clearPreferences();
    preferences.setIsVisitTutorial("true");
    preferences.setFingerprintEnable(biometricEnable);
    preferences.setFingerprintConsent(biometricConsent);
    authToken = await FirebaseMessaging.instance.getToken();
    preferences.setFirebaseToken(authToken);
    String version = await Utility.getVersionInfo();
    setState(() {
      versionName = version;
    });
  }


  void getTermsOfUse() async {
    LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
    loginBloc.getTermsPrivacyURL().then((value) async {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        termsOfUseData = value.data;
        if(termsOfUseData!.dummyAccounts!.length != 0) {
          setState(() {
            dummyAccountList = value.data!.dummyAccounts;
          });
          preferences.setPrivacyPolicyUrl(termsOfUseData!.privacyPolicyUrl!);
          preferences.setDummyAccountList(dummyAccountList);
          FocusScope.of(context).requestFocus(mobileFocus);
        }
      } else {
        termsOfUseData = null;
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorBg,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                AppIcon(),
                SizedBox(
                  height: 34,
                ),
                headingText(Strings.registration),
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: theme.copyWith(primaryColor: appTheme),
                    child: TextField(
                      obscureText: false,
                      autofocus: false,
                      cursorColor: appTheme,
                      maxLength: 10,
                      focusNode: mobileFocus,
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      style: textFiledInputStyle,
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
                        hintText: Strings.mobile,
                        labelText: Strings.mobile,
                        hintStyle: TextStyle(color: colorGrey),
                        labelStyle: TextStyle(color: appTheme),
                        focusColor: Colors.grey,
                      ),
                      onChanged: (text) {
                        if (text.length == 10) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              login();
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: appTheme,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkBoxValue = newValue!;
                              if (checkBoxValue) {
                                acceptTerms = 1;
                              } else {
                                acceptTerms = 0;
                              }
                            });
                          }),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'I agree to accept ',
                            style: mediumTextStyle_14_gray,
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: boldTextStyle_14,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TermsConditionWebView(termsOfUseData!.termsOfUseUrl!, false, Strings.terms_of_use)));
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });
                                  },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: mediumTextStyle_14_gray,
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: boldTextStyle_14,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TermsConditionWebView(
                                                    termsOfUseData!.privacyPolicyUrl!, true, Strings.privacy_policy)));
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 112,
                ),
                Container(
                  height: 45,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Utility.isNetworkConnection().then((isNetwork) async {
                          if (isNetwork) {
                            login();
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                      child: ArrowForwardNavigation(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                version(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget version() {
    return Center(
      child: Text('Version ${versionName != null ? versionName : ""}'),
    );
  }

  Future<void> login() async {
    RegExp myRegExp = RegExp('0');
    if (mobileController.text.startsWith(myRegExp)) {
      Utility.showToastMessage(Strings.message_mobile_no_not_allow_first_zero);
    } else if (mobileController.text.trim().length == 0) {
      Utility.showToastMessage(Strings.message_valid_mobile_no);
    } else if (mobileController.text.trim().length < 10) {
      Utility.showToastMessage(Strings.message_valid_mobile_no_10_digit);
    } else if (acceptTerms == 0) {
      Utility.showToastMessage(Strings.accept_t_and_p);
    } else {
      bool? accountPermission = await preferences.getEmailDialogConsent();
      bool? photoPermission = await preferences.getPhotoConsent();
      bool? biometricConsent = await preferences.getFingerprintConsent();
      bool? biometricPermission = await preferences.getBiometricConsent();
      String? privacyUrl = await preferences.getPrivacyPolicyUrl();
      bool? biometricEnable = await preferences.getFingerprintEnable();
      preferences.clearPreferences();
      preferences.setIsVisitTutorial("true");
      preferences.setEmailDialogConsent(accountPermission!);
      preferences.setPhotoConsent(photoPermission);
      preferences.setBiometricConsent(biometricPermission);
      preferences.setFingerprintConsent(biometricConsent);
      preferences.setFingerprintEnable(biometricEnable);
      preferences.setPrivacyPolicyUrl(privacyUrl);
      preferences.setDummyAccountList(dummyAccountList);
      for( int i = 0; i < dummyAccountList!.length; i++){
        if(dummyAccountList![i] == mobileController.text){
          preferences.setDummyUserMobile(mobileController.text.toString().trim());
        }
      }
      LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
      authToken = await FirebaseMessaging.instance.getToken();
      preferences.setFirebaseToken(authToken);

      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobileController.text.trim();
      parameter[Strings.date_time] = getCurrentDateAndTime();
      firebaseEvent(Strings.login_otp_sent, parameter);

      loginBloc.loginSubmit(mobileController.text.trim(), authToken, acceptTerms).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            enableDrag: false,
            isScrollControlled: true,
            builder: (BuildContext bc) {
              return OTPVerificationScreen(mobileController.text, acceptTerms);
            },
          );
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }
}
