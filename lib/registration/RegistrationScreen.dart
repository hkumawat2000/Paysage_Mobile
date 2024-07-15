import 'dart:convert';
import 'package:lms/login/LoginValidationBloc.dart';
import 'package:lms/network/requestbean/RegistrationRequestBean.dart';
import 'package:lms/registration/RegistrationBloc.dart';
import 'package:lms/registration/SetPinscreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

import '../terms_conditions/TermsConditionWebView.dart';

class RegistrationScreen extends StatefulWidget {
  String mobileNumber, otp;

  @override
  RegistrationScreenState createState() => RegistrationScreenState();

  RegistrationScreen(this.mobileNumber, this.otp);
}

class RegistrationScreenState extends State<RegistrationScreen> {
  static const platform = const MethodChannel('samples.flutter.io/email');
  List<dynamic> emailList = <dynamic>[];
  final registerBloc = RegistrationBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginValidatorBloc = LoginValidatorBloc();
  Preferences? preferences;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? mobileController;
  TextEditingController? pinController;
  TextEditingController? referCodeController;
  TextEditingController? emailFacebookController;
  bool isClickableGoogleButton = false;
  bool isClickableFacebookButton = false;
  String errorMessage = "";
  var firbase_token;
  String? versionName;
  String? platformName;
  String? deviceInfo;
  bool showEmailList = false;
  // String? emailConsent;

  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  String? dummyMobileNo;
  bool? emailDialogConsent;

  void getPrefereceData() async {
    firbase_token = await preferences!.getFirebaseToken();
    dummyMobileNo = await preferences!.getDummyUserMobile();
    // emailConsent = await preferences!.getConsentForEmail();
  }

  @override
  void dispose() {
    _loginValidatorBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    preferences = new Preferences();
    getVersionInfo();
    _getEmails();
    super.initState();
    getPrefereceData();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController(text: widget.mobileNumber);
    pinController = TextEditingController();
    referCodeController = TextEditingController();
    emailFacebookController = TextEditingController();

    _focusNode.addListener(() {
      if(Platform.isAndroid){
        if (_focusNode.hasFocus) {
          this._overlayEntry = this._createOverlayEntry();
          Overlay.of(context)!.insert(this._overlayEntry!);
        } else {
          if (_overlayEntry == null && this._overlayEntry!.mounted) {
            this._overlayEntry!.remove();
          }
        }
      }
    });
  }

  Future<void> getVersionInfo() async {
    deviceInfo = await getDeviceInfo();
    String version = await Utility.getVersionInfo();
    setState(() {
      versionName = version;
      platformName = Platform.operatingSystem;
    });
  }

  Future<void> _getEmails() async {
    emailDialogConsent = await preferences!.getEmailDialogConsent();
    if(Platform.isAndroid) {
      if(emailDialogConsent == false){
        permissionDialog(context);
      }else{
        var status = await Permission.contacts.request();
        if (status.isRestricted) {
          await Permission.contacts.request();
        }
        try {
          var list = await platform.invokeMethod('getEmailList');
          if (list != null && mounted) {
            printLog("getEmailList::$list");
            setState(() {
              emailList = list;
            });
          }
        } on PlatformException catch (e) {
          printLog(e.message);
        }
      }
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 60,
        height: emailList.length == 0 ? 0 : emailList.length * 56.0 + 50 + 32,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          child: Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Material(
              color: colorBg,
              elevation: 4.0,
              child: emailList.isEmpty
                  ? Container()
                  : ListView.builder(
                  shrinkWrap: true,
                  itemCount: emailList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(emailList[index]),
                      onTap: () {
                        printLog('${emailList[index]}');
                        setState(() {
                          emailController!.text = emailList[index];
                          if (this._overlayEntry!.mounted)
                            this._overlayEntry!.remove();
                        });
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (_focusNode.hasFocus && this._overlayEntry!.mounted) {
              this._overlayEntry!.remove();
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: colorBg,
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    AppIcon(),
                    SizedBox(
                      height: 34,
                    ),
                    headingText(Strings.registration),
                    SizedBox(
                      height: 20,
                    ),
                    emailFeild(),
                    SizedBox(
                      height: 20,
                    ),
                    nameFeild(),
                    SizedBox(
                      height: 20,
                    ),
                    lastNameFeild(),
                    SizedBox(
                      height: 20,
                    ),
                    mobileFeild(),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  referCodeFeild(),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Strings.register_with,
                            style: textFiledInputStyle,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Platform.isIOS ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  loginWithGoogle(context);
                                  if(Platform.isAndroid) {
                                    if (_focusNode.hasFocus &&
                                        this._overlayEntry!.mounted) {
                                      this._overlayEntry!.remove();
                                    }
                                  }
                                },
                                child: Image.asset(
                                  AssetsImagePath.login_google,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                             SizedBox(width: 60,),
                             GestureDetector(
                               onTap: () async {
                                 FocusScope.of(context).unfocus();
                                 appleSignIn();
                               },
                               child: Image(image: AssetImage(AssetsImagePath.apple_icon),
                                   width: 42,
                                   height: 42),
                             ),
                            ],
                          ) : GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              loginWithGoogle(context);
                              if(Platform.isAndroid) {
                                if (_focusNode.hasFocus &&
                                    this._overlayEntry!.mounted) {
                                  this._overlayEntry!.remove();
                                }
                              }
                            },
                            child: Image.asset(
                              AssetsImagePath.login_google,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                registartion(firstNameController!.text, lastNameController!.text,
                                    emailController!.text, versionName!,
                                    deviceInfo, context, Strings.register_with_email);
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: ArrowForwardNavigation(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    version(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: _onBackPressed);
  }

  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   return bytes.toString();
  // }


  void appleSignIn() async{
    AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    String? lastName, firstName, email;
    if(credential.email == null){
      email = await FlutterKeychain.get(key: "email");
      firstName = await FlutterKeychain.get(key: "firstname");
      lastName = await FlutterKeychain.get(key: "lastname");
      if(email != null){
        preferences!.setEmail(email);
        preferences!.setFullName("$firstName $lastName");
        autoReg(context, Strings.register_with_apple);
        // emailController!.text = email.trim().toString();
        // firstNameController!.text = firstName.toString();
        // lastNameController!.text = lastName.toString();
      } else {
        Utility.showToastMessage(Strings.something_went_wrong);
      }
    } else {
      await FlutterKeychain.put(key: "email", value: credential.email!);
      await FlutterKeychain.put(key: "firstname", value: credential.givenName!);
      await FlutterKeychain.put(key: "lastname", value: credential.familyName!);
      email = await FlutterKeychain.get(key: "email");
      firstName = await FlutterKeychain.get(key: "firstname");
      lastName = await FlutterKeychain.get(key: "lastname");
      if(email != null){
        preferences!.setEmail(email);
        preferences!.setFullName("$firstName $lastName");
        autoReg(context, Strings.register_with_apple);
        // emailController!.text = email.trim().toString();
        // firstNameController!.text = firstName.toString();
        // lastNameController!.text = lastName.toString();
      } else {
        Utility.showToastMessage(Strings.something_went_wrong);
      }
    }
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          FocusScope.of(context).unfocus();
          if (_focusNode.hasFocus && this._overlayEntry!.mounted) {
            this._overlayEntry!.remove();
          }
          return onBackPressDialog(1,Strings.exit_app);
        })?? false;
  }

  Widget nameFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: firstNameController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          maxLength: 25,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
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
            counterText: "",
            hintText: Strings.first_name,
            labelText: Strings.first_name,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
          keyboardType: TextInputType.name,
        ),
      ),
    );
  }

  Widget lastNameFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: lastNameController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          maxLength: 25,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
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
            counterText: "",
            hintText: Strings.last_name,
            labelText: Strings.last_name,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
          keyboardType: TextInputType.name,
        ),
      ),
    );
  }

  Widget emailFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: CompositedTransformTarget(
          link: this._layerLink,
          child: TextFormField(
            onChanged: (val) {
              if(Platform.isAndroid) {
                if (val.length == 0) {
                  if (_focusNode.hasFocus) {
                    this._overlayEntry = this._createOverlayEntry();
                    Overlay.of(context)!.insert(this._overlayEntry!);
                  }
                } else {
                  if (this._overlayEntry!.mounted)
                    this._overlayEntry!.remove();
                }
              }
            },
            onEditingComplete: () {
              if(Platform.isAndroid) {
                FocusScope.of(context).nextFocus();
                if (this._overlayEntry!.mounted)
                  this._overlayEntry!.remove();
              }
            },
            onFieldSubmitted: (_) {
              if(Platform.isAndroid) {
                if (this._overlayEntry!.mounted)
                  this._overlayEntry!.remove();
              }
            },
            // focus to next
            keyboardType: TextInputType.emailAddress,
            focusNode: this._focusNode,
            obscureText: false,
            controller: emailController,
            style: textFiledInputStyle,
            cursorColor: appTheme,
            onTap: () async {
              if(Platform.isAndroid) {
                // if(emailConsent != null){
                  var status = await Permission.contacts.request();
                  if (status.isRestricted) {
                    await Permission.contacts.request();
                  }
                  try {
                    var list = await platform.invokeMethod('getEmailList');
                    if (list != null && mounted) {
                      printLog("getEmailList::$list");
                      setState(() {
                        emailList = list;
                      });
                    }
                  } on PlatformException catch (e) {
                    printLog(e.message);
                  }
                // }
              }
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
              hintText: Strings.email,
              labelText: Strings.email,
              hintStyle: TextStyle(color: colorGrey),
              labelStyle: TextStyle(color: appTheme),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          enabled: false,
          controller: mobileController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appTheme),
            ),
            disabledBorder: OutlineInputBorder(
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
            hintText: Strings.mobile,
            labelText: Strings.mobile,
            hintStyle: TextStyle(color: colorGrey),
            labelStyle: TextStyle(color: appTheme),
          ),
        ),
      ),
    );
  }

  Widget referCodeFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          obscureText: false,
          enabled: true,
          maxLength: 10,
          controller: referCodeController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
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
            hintText: Strings.refer_code,
            hintStyle: textFiledHintStyle,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Future<bool> permissionDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text("Account Access", style: boldTextStyle_16),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Why is LMS asking for Get Account Access?\n\nThis will help us to locate YOU in the contact for easy registration and gather some generic information about the device.\n\nPermission can be changed at anytime from the device setting.\n\nIn case of any doubts, please visit our ',style: regularTextStyle_12_gray_dark),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  String privacyPolicyUrl = await preferences!.getPrivacyPolicyUrl();
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
                                  preferences!.setEmailDialogConsent(true);

                                  var status = await Permission.contacts.request();
                                  if (status.isRestricted) {
                                    await Permission.contacts.request();
                                  }
                                  try {
                                    var list = await platform.invokeMethod('getEmailList');
                                    if (list != null && mounted) {
                                      printLog("getEmailList::$list");
                                      setState(() {
                                        emailList = list;
                                      });
                                    }
                                  } on PlatformException catch (e) {
                                    printLog(e.message);
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

  Widget version() {
    return Center(
      child: Text('Version ${versionName != null ? versionName : ""}'),
    );
  }

  void registartion(var firstName, var lastName, var emailID, var versionName, var deviceInfo, BuildContext context, event) {
    RegExp nameRegExp = RegExp(RegexValidator.nameRegex);
    if (emailID.trim().length == 0) {
      Utility.showToastMessage(Strings.message_valid_mail);
    } else if (!emailRegex.hasMatch(emailID)) {
      Utility.showToastMessage(Strings.message_valid_mail);
    } else if (firstName.trim().length == 0) {
      Utility.showToastMessage(Strings.message_valid_firstName);
    } else if (firstName.trim().length > 25) {
      Utility.showToastMessage(Strings.message_valid_length_firstName);
    } else if (!nameRegExp.hasMatch(firstName)) {
      Utility.showToastMessage(Strings.validate_only_char_firstname);
    } else if (lastName.trim().length == 0) {
      Utility.showToastMessage(Strings.message_valid_lastName);
    } else if (lastName.trim().length > 25) {
      Utility.showToastMessage(Strings.message_valid_length_lastName);
    } else if (!nameRegExp.hasMatch(lastName)) {
      Utility.showToastMessage(Strings.validate_only_char_lastname);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      RegistartionRequestBean requestBean = RegistartionRequestBean(
          firstName.toString().trim(),
          lastName.toString().trim(),
          widget.mobileNumber,
          emailID.toString().trim(),
          firbase_token,
          versionName!,
          deviceInfo!
      );
      printLog("requestReg: ${json.encode(requestBean)}");
      registerBloc.submitRegistartion(requestBean).then((value) {
        Navigator.pop(context); //pop dialog
        if (value.isSuccessFull!) {
          preferences!.setMobile(value.data!.customer!.phone!);
          preferences!.setFullName(value.data!.customer!.firstName! + " " + value.data!.customer!.lastName!);
          // preferences!.setCustomer(value.data);
          preferences!.setEmail(value.data!.customer!.user!);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.first_name_prm] = firstName.toString().trim();
          parameter[Strings.last_name_prm] = lastName.toString().trim();
          parameter[Strings.mobile_no] = widget.mobileNumber;
          parameter[Strings.email] = emailID.toString().trim();
          parameter[Strings.date_time] = getCurrentDateAndTime();
          if(event == Strings.register_with_email) {
            firebaseEvent(Strings.register_with_email, parameter);
          } else if(event == Strings.register_with_google){
            firebaseEvent(Strings.register_with_google, parameter);
          } else if(event == Strings.register_with_facebook){
            firebaseEvent(Strings.register_with_facebook, parameter);
          }
          var dummy_user = "";
          printLog("dummyAccountList:: ${dummyMobileNo}");
          if(dummyMobileNo == widget.mobileNumber){
            printLog("number == ${dummy_user}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SetPinScreen(false, value.data!.customer!.loanOpen!)));
          }else{
            commonDialog(context, Strings.email_verification_link, 2);
          }

          // Firebase Event
          Map<String, dynamic> parameters = new Map<String, dynamic>();
          parameters[Strings.email] = emailID.toString().trim();
          parameters[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.email_verification_sent, parameters);
        } else if (value.errorCode == 422) {
          Utility.showToastMessage(value.errorMessage!);
          // Utility.showToastMessage(Strings.email_mobile_already_taken);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.first_name_prm] = firstName.toString().trim();
          parameter[Strings.last_name_prm] = lastName.toString().trim();
          parameter[Strings.mobile_no] = widget.mobileNumber;
          parameter[Strings.email] = emailID.toString().trim();
          parameter[Strings.error_message] = Strings.email_mobile_already_taken;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.register_failed, parameter);
          isClickableFacebookButton = false;
          isClickableGoogleButton = false;
        } else {
          isClickableFacebookButton = false;
          isClickableGoogleButton = false;
          Utility.showToastMessage(value.errorMessage!);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.first_name_prm] = firstName.toString().trim();
          parameter[Strings.last_name_prm] = lastName.toString().trim();
          parameter[Strings.mobile_no] = widget.mobileNumber;
          parameter[Strings.email] = emailID.toString().trim();
          parameter[Strings.error_message] = value.errorMessage;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.register_failed, parameter);
          printLog("Registration failed");
        }
      });
    }
  }

  void loginWithGoogle(BuildContext context) async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        registerBloc.signInWithGoogle().then((value) {
          Navigator.pop(context);
          if (value != "") {
            autoReg(context, Strings.register_with_google);
            _logoutGoogle();
            setState(() {
              isClickableFacebookButton = true;
            });
          } else {
            setState(() {
              printLog("Google Null");
              isClickableFacebookButton = false;
              isClickableGoogleButton = false;
            });
          }
        }).catchError((onError) {
          Navigator.pop(context);
          printLog(onError.toString());
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

//   void loginWithFacebook(BuildContext context) async {
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
// //        LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//         registerBloc.signInWithFacebook().then((isFacebookLoginSuccessValue) {
//           if (isFacebookLoginSuccessValue.errorCode == 0) {
// //            Navigator.pop(context);
//             printLog("Error");
//             isClickableFacebookButton = false;
//             isClickableGoogleButton = false;
//           } else if (isFacebookLoginSuccessValue.errorCode == 1) {
// //            Navigator.pop(context);
//             printLog("cancelledByUser");
//             isClickableFacebookButton = false;
//             isClickableGoogleButton = false;
//           } else if (isFacebookLoginSuccessValue.errorCode == 2) {
// //            Navigator.pop(context);
//             Map<String, dynamic> profile = Map<String, dynamic>.from(isFacebookLoginSuccessValue.data);
//             printLog("Profile Type ::${profile.runtimeType}");
//             if (profile['email'] == null || profile['email'].toString().isEmpty) {
//               _showDialog(profile, context);
//               FocusScope.of(context).unfocus();
//               if (_focusNode.hasFocus && this._overlayEntry!.mounted) {
//                 this._overlayEntry!.remove();
//               }
//             } else {
//               preferences!.setFullName(profile['name']);
//               preferences!.setEmail(profile['email']);
//               autoReg(context, Strings.register_with_facebook);
//               _logoutFacebook();
//             }
//           }
//         });
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//   }

  Future<void> _showDialog(profile, BuildContext buildContext) async {
    await showDialog(
        context: buildContext,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: const EdgeInsets.all(16.0),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(Strings.facebook_empty_mail),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailFacebookController,
                    autofocus: true,
                    decoration: InputDecoration(labelText: Strings.email, hintText: Strings.email),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                        if (emailFacebookController!.value.text.trim().length == 0) {
                          Utility.showToastMessage(Strings.message_valid_mail);
                        } else if (!emailRegex
                            .hasMatch(emailFacebookController!.value.text.trim())) {
                          Utility.showToastMessage(Strings.message_valid_mail);
                        } else {
                          preferences!.setEmail(emailFacebookController!.value.text.trim());
                          preferences!.setFullName(profile['name']);
                          LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                          var fullNameGoogle = await preferences!.getFullName();
                          String fullName = fullNameGoogle.toString();
                          var names = fullName.split(' ');
                          printLog("names :: $names");
                          var firstName = names[0];
                          var lastName = names[1];
                          RegistartionRequestBean requestBean = RegistartionRequestBean(
                              firstName.toString().trim(),
                              lastName.toString().trim(),
                              widget.mobileNumber,
                              emailFacebookController!.value.text.trim(),
                              firbase_token,
                              versionName!,
                              deviceInfo!);
                          registerBloc.submitRegistartion(requestBean).then((value) {
                            Navigator.pop(context); //pop dialog
                            Navigator.pop(context); //pop dialog
                            if (value.isSuccessFull!) {
                              preferences!.setMobile(value.data!.customer!.phone!);
                              preferences!.setFullName(value.data!.customer!.firstName! +
                                  " " +
                                  value.data!.customer!.lastName!);
                              // preferences!.setCustomer(value.data);
                              preferences!.setEmail(value.data!.customer!.user!);
                              // Firebase Event
                              Map<String, dynamic> parameter = new Map<String, dynamic>();
                              parameter[Strings.first_name_prm] = firstName.toString().trim();
                              parameter[Strings.last_name_prm] = lastName.toString().trim();
                              parameter[Strings.mobile_no] = widget.mobileNumber;
                              parameter[Strings.email] = emailFacebookController!.value.text.trim();
                              parameter[Strings.date_time] = getCurrentDateAndTime();
                              firebaseEvent(Strings.register_with_facebook, parameter);
                              commonDialog(context, Strings.email_verification_link, 2);

                              // Firebase Event
                              Map<String, dynamic> parameters = new Map<String, dynamic>();
                              parameters[Strings.email] = emailFacebookController!.value.text.trim();
                              parameters[Strings.date_time] = getCurrentDateAndTime();
                              firebaseEvent(Strings.email_verification_sent, parameters);
                            } else if (value.errorCode == 422) {
                              // Utility.showToastMessage(Strings.email_mobile_already_taken);
                              Utility.showToastMessage(value.errorMessage!);
                              isClickableFacebookButton = false;
                              isClickableGoogleButton = false;
                            } else {
                              Utility.showToastMessage(Strings.something_went_wrong);
                            }
                          });
                        }
                      },
                      child: Text(
                        Strings.ok,
                        style: buttonTextWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> autoReg(BuildContext context, String event) async {
    var fullNameGoogle = await preferences!.getFullName();
    String fullName = fullNameGoogle.toString();
    var names = fullName.split(' ');
    printLog("names :: $names");
    var firstName = names[0];
    var lastName = names[1];
    var emailID = await preferences!.getEmail();
    registartion(firstName, lastName, emailID,versionName, deviceInfo, context, event);
  }

  void _logoutGoogle() async {
    printLog("Logged out");
    registerBloc.signOutWithGoogle();
  }

// void _logoutFacebook() async {
//   printLog("Logged out");
//   registerBloc.signOutWithFacebook();
// }
}
