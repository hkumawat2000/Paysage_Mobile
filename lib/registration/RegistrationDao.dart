import 'package:lms/util/Utility.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../network/ModelWrapper.dart';
import '../network/requestbean/RegistrationRequestBean.dart';
import '../network/responsebean/AuthResponse/AuthLoginResponse.dart';
import '../util/Preferences.dart';
import '../util/constants.dart';
import '../util/strings.dart';
import 'dart:io' as Platform;

class RegistrationDao with BaseDio {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  // var facebookLogin = FacebookLogin();
  Preferences preferences = new Preferences();

  String? name;
  String? email;
  String? imageUrl;

  Future<String> signInWithGoogle() async {
    try {
      printLog("Start....");
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      printLog("Google sign in end....");

      if (googleSignInAccount != null) {
        printLog("Google sign not null....");
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

        preferences.setEmail(email!);

        preferences.setFullName(name!);
        printLog("Name::$name");
        printLog("Email::$email");
        printLog("Image::$imageUrl");

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
        printLog("signInWithGoogle failed....");
        return '';
      }
    } catch (e) {
      printLog("Google sign Exception....${e.toString()}");
      return '';
    }
  }

  Future<bool> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    return true;
  }

  // Future<bool> signOutFacebook() async {
  //   // await facebookLogin.logOut();
  //   await FacebookAuth.instance.logOut();
  //   await _auth.signOut();
  //   return true;
  // }

  // Future<ModelWrapper> signInWithFacebook() async {
  //   final fb = FacebookLogin();
  //
  //   final res = await fb.expressLogin();
  //
  //    var facebookLoginResult = await facebookLogin.logIn(['email']);
  //   var firebaseAuth = FirebaseAuth.instance;
  //   ModelWrapper wrapper = ModelWrapper();
  //    switch (facebookLoginResult.status) {
  //      case FacebookLoginStatus.error:
  //        printLog("Error");
  //        wrapper.errorCode = 0;
  //        break;
  //      case FacebookLoginStatus.cancelledByUser:
  //        printLog("CancelledByUser");
  //        wrapper.errorCode = 1;
  //        break;
  //      case FacebookLoginStatus.loggedIn:
  //        printLog("LoggedIn");
  //        var graphResponse = await http.get(
  //            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}'));
  //
  //        final facebookAuthCred =
  //            FacebookAuthProvider.credential(facebookLoginResult.accessToken.token);
  //       final user = await firebaseAuth.signInWithCredential(facebookAuthCred);
  //
  //       printLog("user:: ${user.user.isEmailVerified}");
  //        wrapper.errorCode = 2;
  //        wrapper.data = graphResponse.body;
  //        break;
  //    }
  //   return wrapper;
  // }
  // Future<ModelWrapper> signInWithFacebook() async {
  //   printLog("Attempting");
  //
  //   // final fb = FacebookLogin();
  //   // final FacebookLoginResult res = await fb.expressLogin();
  //   // printLog("res::$res");
  //   //
  //   // if (res.status == FacebookLoginStatus.success) {
  //   //   final FacebookAccessToken? accessToken = res.accessToken;
  //   //   printLog('Access token: ${accessToken!.token}');
  //   // }
  //   ModelWrapper wrapper = ModelWrapper();
  //   try {
  //     final LoginResult result = await FacebookAuth.instance
  //         .login(permissions: ['public_profile', 'email']);
  //     printLog("FACEBOOK :: $result");
  //
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AccessToken accessToken = result.accessToken!;
  //         printLog("SUCCESS :: $accessToken");
  //         final userData = await FacebookAuth.instance.getUserData();
  //         printLog("userData :: $userData");
  //         wrapper.errorCode = 2;
  //         wrapper.data = userData;
  //         break;
  //       case LoginStatus.cancelled:
  //         printLog("Cancelled By User");
  //         wrapper.errorCode = 1;
  //         break;
  //       case LoginStatus.failed:
  //         printLog("Error Failed");
  //         wrapper.errorCode = 0;
  //         break;
  //       case LoginStatus.operationInProgress:
  //         printLog("Operation In Progress");
  //         break;
  //     }
  //   } catch (ex) {
  //     printLog(ex.toString());
  //   }
  //   return wrapper;
  // }

  Future<AuthLoginResponse> registartion(
      RegistartionRequestBean requestBean) async {
    Dio dio = await getBaseDioVersionPlatform();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response =
      await dio.post(Constants.registration, data: requestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
        preferences.setToken(wrapper.data!.token!);
      } else {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data["errors"] == null){
          wrapper.errorMessage = e.response!.data["message"] ?? Strings.something_went_wrong;
        } else {
          if(e.response!.data["errors"]["first_name"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["first_name"];
          } else if(e.response!.data["errors"]["mobile"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["mobile"];
          } else if(e.response!.data["errors"]["email"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["email"];
          } else if(e.response!.data["errors"]["firebase_token"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["firebase_token"];
          } else {
            wrapper.errorMessage = Strings.something_went_wrong;
          }
        }
      }
    }
    return wrapper;
  }

  Future<AuthLoginResponse> setPin(String pin) async {
    Dio dio = await getBaseDio();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio
          .post(Constants.setPin, data: {ParametersConstants.pin: pin});
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        printLog("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.data["message"];
      }
    }
    return wrapper;
  }

  Future<AuthLoginResponse> getPin(mobileNumber, pin, firebase_token) async {
    String versionName = await Utility.getVersionInfo();
    mobileNumber = await preferences.getMobile();
    String? deviceInfo = await getDeviceInfo();
    Dio dio = await getBaseDioVersionPlatform();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.logIn, data: {
        ParametersConstants.mobile: mobileNumber,
        ParametersConstants.pin: pin,
        ParametersConstants.acceptTerms: 1,
        ParametersConstants.firebaseToken: firebase_token,
        ParametersConstants.platform: deviceInfo,
        ParametersConstants.appVersion: versionName
      });
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else if (response.statusCode == 401) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data["errors"] == null){
          wrapper.errorMessage = e.response!.data["message"] ?? Strings.something_went_wrong;
        } else {
         if(e.response!.data["errors"]["mobile"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["mobile"];
          } else if(e.response!.data["errors"]["pin"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["pin"];
          } else if(e.response!.data["errors"]["firebase_token"] != null){
            wrapper.errorMessage = e.response!.data["errors"]["firebase_token"];
          } else {
            wrapper.errorMessage = Strings.something_went_wrong;
          }
        }
      }
    }
    return wrapper;
  }
}
