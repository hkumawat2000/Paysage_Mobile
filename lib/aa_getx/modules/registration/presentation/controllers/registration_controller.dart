import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/registration_request_bean_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/submit_registration_usecase.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RegistrationController extends GetxController {
  static const platform = const MethodChannel('samples.flutter.io/email');
  RxList<dynamic> emailList = <dynamic>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences? preferences;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();
  TextEditingController emailFacebookController = TextEditingController();
  RxBool isClickableGoogleButton = false.obs;
  RxBool isClickableFacebookButton = false.obs;
  String errorMessage = "";
  var firbase_token;
  RxString? versionName;
  RxString? platformName;
  String? deviceInfo;
  bool showEmailList = false;

  // String? emailConsent;
  RegistrationArguments registrationArguments =  Get.arguments;   ///todo uncomment the arguments after merge
  final FocusNode focusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  // var facebookLogin = FacebookLogin();

  String? name;
  String? email;
  String? imageUrl;
  Rx<OverlayEntry>? overlayEntry;

  final LayerLink layerLink = LayerLink();

  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  String? dummyMobileNo;
  bool? emailDialogConsent;
  final SubmitRegistrationUseCase submitRegistrationUseCase;
  final ConnectionInfo connectionInfo;

  RegistrationController(this.submitRegistrationUseCase, this.connectionInfo);

  void getPrefereceData() async {
    firbase_token = await preferences!.getFirebaseToken();
    dummyMobileNo = await preferences!.getDummyUserMobile();
    // emailConsent = await preferences!.getConsentForEmail();
  }

  @override
  void onInit() {
    preferences = new Preferences();
    getVersionInfo();
    _getEmails();
    getPrefereceData();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController =
        TextEditingController(text: registrationArguments.mobileNumber);
    pinController = TextEditingController();
    referCodeController = TextEditingController();
    emailFacebookController = TextEditingController();

    focusNode.addListener(() {
      if (Platform.isAndroid) {
        if (focusNode.hasFocus) {
          this.overlayEntry!.value = this.createOverlayEntry();
          Overlay.of(Get.context!).insert(this.overlayEntry!.value);
        } else {
          if (overlayEntry == null && this.overlayEntry!.value.mounted) {
            this.overlayEntry!.value.remove();
          }
        }
      }
    });
    super.onInit();
  }

  Future<void> getVersionInfo() async {
    deviceInfo = await getDeviceInfo();
    String version = await Utility.getVersionInfo();
    versionName?.value = version;
    platformName?.value = Platform.operatingSystem;
  }

  Future<void> _getEmails() async {
    emailDialogConsent = await preferences!.getEmailDialogConsent();
    if (Platform.isAndroid) {
      if (emailDialogConsent == false) {
        permissionDialog();
      } else {
        var status = await Permission.contacts.request();
        if (status.isRestricted) {
          await Permission.contacts.request();
        }
        try {
          var list = await platform.invokeMethod('getEmailList');
          if (list != null) {
            debugPrint("getEmailList::$list");
            emailList = list;
          }
        } on PlatformException catch (e) {
          debugPrint(e.message);
        }
      }
    }
  }

  OverlayEntry createOverlayEntry() {
    RenderBox? renderBox = Get.context!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 60,
        height: emailList.length == 0 ? 0 : emailList.length * 56.0 + 50 + 32,
        child: CompositedTransformFollower(
          link: this.layerLink,
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
                            debugPrint('${emailList[index]}');
                            emailController.text = emailList[index];
                            if (this.overlayEntry!.value.mounted)
                              this.overlayEntry!.value.remove();
                          },
                        );
                      }),
            ),
          ),
        ),
      ),
    );
  }

  void appleSignIn() async {
    Get.focusScope!.unfocus();
    AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    String? lastName, firstName, email;
    if (credential.email == null) {
      email = await FlutterKeychain.get(key: "email");
      firstName = await FlutterKeychain.get(key: "firstname");
      lastName = await FlutterKeychain.get(key: "lastname");
      if (email != null) {
        emailController.text = email.trim().toString();
        firstNameController.text = firstName.toString();
        lastNameController.text = lastName.toString();
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
      if (email != null) {
        emailController.text = email.trim().toString();
        firstNameController.text = firstName.toString();
        lastNameController.text = lastName.toString();
      } else {
        Utility.showToastMessage(Strings.something_went_wrong);
      }
    }
  }

  Widget version() {
    return Center(
      child: Text('Version ${versionName != null ? versionName : ""}'),
    );
  }

  Future<void> registartion(var firstName, var lastName, var emailID,
      var versionName, var deviceInfo, event) async {
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
      RegistrationRequestBeanEntity registrationRequestBeanEntity = RegistrationRequestBeanEntity(
          firstName.toString().trim(),
          lastName.toString().trim(),
          registrationArguments.mobileNumber!,
          emailID.toString().trim(),
          firbase_token,
          versionName!,
          deviceInfo!);
      debugPrint("requestReg: ${json.encode(registrationRequestBeanEntity)}");

      if (await connectionInfo.isConnected) {
        showDialogLoading(Strings.please_wait);
        DataState<AuthLoginResponseEntity> response =
            await submitRegistrationUseCase.call(RegistrationRequestBeanParams(registrationRequestBeanEntity: registrationRequestBeanEntity));
        Get.back(); //pop dialog
        debugPrint("response block");
        debugPrint("response   ${response.data}");
        if (response is DataSuccess) {
          if (response.data != null) {
            //preferences!.setMobile(response.data!.customer!.phone!);
            preferences!
                .setMobile(response.data!.registerData!.customer!.phone!);
            preferences!.setFullName(
                response.data!.registerData!.customer!.firstName! +
                    " " +
                    response.data!.registerData!.customer!.lastName!);
            // preferences!.setCustomer(value.data);
            preferences!.setEmail(response.data!.registerData!.customer!.user!);
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.first_name_prm] = firstName.toString().trim();
            parameter[Strings.last_name_prm] = lastName.toString().trim();
            parameter[Strings.mobile_no] = registrationArguments.mobileNumber;
            parameter[Strings.email] = emailID.toString().trim();
            parameter[Strings.date_time] = getCurrentDateAndTime();
            if (event == Strings.register_with_email) {
              firebaseEvent(Strings.register_with_email, parameter);
            } else if (event == Strings.register_with_google) {
              firebaseEvent(Strings.register_with_google, parameter);
            } else if (event == Strings.register_with_facebook) {
              firebaseEvent(Strings.register_with_facebook, parameter);
            }
            var dummy_user = "";
            debugPrint("dummyAccountList:: ${dummyMobileNo}");
            if (dummyMobileNo == registrationArguments.mobileNumber) {
              debugPrint("number == ${dummy_user}");
              Get.toNamed(setPinView,
                  arguments: SetPinArgs(
                      isForOfflineCustomer: false,
                      isLoanOpen:
                          response.data!.registerData!.customer!.loanOpen!));
            } else {
              commonDialog(Strings.email_verification_link, 2);
            }

            // Firebase Event
            Map<String, dynamic> parameters = new Map<String, dynamic>();
            parameters[Strings.email] = emailID.toString().trim();
            parameters[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.email_verification_sent, parameters);
          }
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
            debugPrint(
                "response.error!.statusCode  ${response.error!.statusCode}");
          } else if (response.error!.statusCode == 422) {
            Utility.showToastMessage(response.error!.message);
            // Utility.showToastMessage(Strings.email_mobile_already_taken);
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.first_name_prm] = firstName.toString().trim();
            parameter[Strings.last_name_prm] = lastName.toString().trim();
            parameter[Strings.mobile_no] = registrationArguments.mobileNumber;
            parameter[Strings.email] = emailID.toString().trim();
            parameter[Strings.error_message] =
                Strings.email_mobile_already_taken;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.register_failed, parameter);
            isClickableFacebookButton.value = false;
            isClickableGoogleButton.value = false;
          } else {
            debugPrint("response.error!.message  ${response.error!.message}");

            isClickableFacebookButton.value = false;
            isClickableGoogleButton.value = false;
            Utility.showToastMessage(response.error!.message);
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.first_name_prm] = firstName.toString().trim();
            parameter[Strings.last_name_prm] = lastName.toString().trim();
            parameter[Strings.mobile_no] = registrationArguments.mobileNumber;
            parameter[Strings.email] = emailID.toString().trim();
            parameter[Strings.error_message] = response.error!.message;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.register_failed, parameter);
            debugPrint("Registration failed");
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
        debugPrint(
            "Strings.no_internet_message  ${Strings.no_internet_message}");
      }
    }
  }

  void loginWithGoogle() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        showDialogLoading(Strings.please_wait);
        signInGoogle().then((value) {
          Get.back();
          if (value != "") {
            autoReg(Strings.register_with_google);
            _logoutGoogle();
            isClickableFacebookButton.value = true;
          } else {
            debugPrint("Google Null");
            isClickableFacebookButton.value = false;
            isClickableGoogleButton.value = false;
          }
        }).catchError((onError) {
          Get.back();
          debugPrint(onError.toString());
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

  Future<void> autoReg(String event) async {
    var fullNameGoogle = await preferences!.getFullName();
    String fullName = fullNameGoogle.toString();
    var names = fullName.split(' ');
    debugPrint("names :: $names");
    var firstName = names[0];
    var lastName = names[1];
    var emailID = await preferences!.getEmail();
    registartion(firstName, lastName, emailID, versionName, deviceInfo, event);
  }

  void _logoutGoogle() async {
    debugPrint("Logged out");
    signOutGoogle();
  }

  Future getEmailList() async {
    if (Platform.isAndroid) {
      // if(emailConsent != null){
      var status = await Permission.contacts.request();
      if (status.isRestricted) {
        await Permission.contacts.request();
      }
      try {
        var list = await platform.invokeMethod('getEmailList');
        if (list != null) {
          debugPrint("getEmailList::$list");
          emailList = list;
        }
      } on PlatformException catch (e) {
        debugPrint(e.message);
      }
      // }
    }
  }

  Future<String> signInGoogle() async {
    String email;
    try {
      email = await signInWithGoogle();
    } catch (e) {
      email = "";
    }
    return email;
  }

  Future<String> signInWithGoogle() async {
    try {
      debugPrint("======> Start....");
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      debugPrint("======> Google sign in end....");

      if (googleSignInAccount != null) {
        debugPrint("======> Google sign not null....");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential googleUserCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

//    final AuthResult authResult = await _auth.signInWithCredential(credential);
        final user = googleUserCredential.user;

        // Checking if email and name is null
        assert(user!.email != null);
        assert(user!.displayName != null);
        assert(user!.photoURL != null);

        name = user!.displayName;
        email = user.email;
        imageUrl = user.photoURL;

        preferences!.setEmail(email!);

        preferences!.setFullName(name!);
        debugPrint("Name::$name");
        debugPrint("Email::$email");
        debugPrint("Image::$imageUrl");

        // Only taking the first part of the name, i.e., First Name
        if (name!.contains(" ")) {
          name = name!.substring(0, name!.indexOf(" "));
        }

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final currentUser = googleUserCredential.user;
        assert(user.uid == currentUser!.uid);
        return 'signInWithGoogle succeeded: $user';
      } else {
        debugPrint("======> signInWithGoogle failed....");
        return '';
      }
    } catch (e) {
      debugPrint("======> Google sign Exception....${e.toString()}");
      return '';
    }
  }

  Future<bool> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    return true;
  }

  void removeOverlay() {
    //FocusScope.of(context).unfocus();
    Get.focusScope!.unfocus();
    if (focusNode.hasFocus && overlayEntry!.value.mounted) {
      overlayEntry!.value.remove();
    }
  }

  Future googleSignClicked() async {
    Get.focusScope!.unfocus();
    loginWithGoogle();
    if (Platform.isAndroid) {
      if (focusNode.hasFocus && overlayEntry!.value.mounted) {
        overlayEntry!.value.remove();
      }
    }
  }

  void emailOnChanged(String val) {
    if (Platform.isAndroid) {
      if (val.length == 0) {
        if (focusNode.hasFocus) {
          overlayEntry!.value = createOverlayEntry();
          Overlay.of(Get.context!).insert(overlayEntry!.value);
        }
      } else {
        if (overlayEntry!.value.mounted) overlayEntry!.value.remove();
      }
    }
  }

  Future<void> privacyPolicyClicked() async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        String privacyPolicyUrl = await preferences!.getPrivacyPolicyUrl();
        debugPrint("privacyPolicyUrl ==> $privacyPolicyUrl");
        // todo change below code with Get.toNamed after merge
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future denyClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.back();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future allowClicked() async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        Get.back();
        preferences!.setEmailDialogConsent(true);

        var status = await Permission.contacts.request();
        if (status.isRestricted) {
          await Permission.contacts.request();
        }
        try {
          var list = await platform.invokeMethod('getEmailList');
          if (list != null) {
            debugPrint("getEmailList::$list");
            emailList = list;
          }
        } on PlatformException catch (e) {
          debugPrint(e.message);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }


  Future<bool> permissionDialog() async {
    return await Get.dialog(
      barrierDismissible: false,
        AlertDialog(
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
                      TextSpan(
                          text:
                          'Why is LMS asking for Get Account Access?\n\nThis will help us to locate YOU in the contact for easy registration and gather some generic information about the device.\n\nPermission can be changed at anytime from the device setting.\n\nIn case of any doubts, please visit our ',
                          style: regularTextStyle_12_gray_dark),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()=> privacyPolicyClicked(),
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
                            minWidth: Get.width,
                            onPressed: ()=> denyClicked(),
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
                            minWidth: Get.width,
                            onPressed: ()=> allowClicked(),
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
        )
    ) ??
        false;
  }
}

class RegistrationArguments {
  String? mobileNumber;
  String? otp;

  RegistrationArguments({this.mobileNumber, this.otp});
}
