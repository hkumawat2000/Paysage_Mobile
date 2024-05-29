import 'dart:convert';

import 'package:lms/network/requestbean/RegistrationRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/AuthResponse/GetTermsandPrivacyResponse.dart';
import 'package:lms/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/network/responsebean/RegistrationResponseBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as Platform;

class LoginDao with BaseDio {
  Preferences preferences = new Preferences();

  Future<AuthLoginResponse> loginSubmit(mobileNumber, firebase_token, acceptTerms) async {
    Dio dio = await getBaseDioVersionPlatform();
    String? deviceInfo = await getDeviceInfo();
    String versionName = await Utility.getVersionInfo();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.logIn,
          data: {ParametersConstants.mobile: mobileNumber, ParametersConstants.firebaseToken: firebase_token, ParametersConstants.acceptTerms:acceptTerms, ParametersConstants.platform: deviceInfo,
            ParametersConstants.appVersion: versionName});
//      List<String> rawCookies = response.headers['set-cookie'];
//      var email;
//      for (var i = 0; i < rawCookies.length; i++) {
//        if (rawCookies[i].contains("%40")) {
//          email = rawCookies[i];
//        }
//      }

      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
//        if (wrapper.message.status == 200) {
//          wrapper.isSuccessFull = true;
//        } else if (wrapper.message.status == 422) {
//          wrapper.isSuccessFull = false;
//        }
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["errors"]["mobile"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<AuthLoginResponse> otpVerify(mobileNumber, otp, firebase_token) async {
    Dio dio = await getBaseDioVersionPlatform();
    String? deviceInfo = await getDeviceInfo();
    String versionName = await Utility.getVersionInfo();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.otpVerify,
          data: {ParametersConstants.mobile: mobileNumber, ParametersConstants.otp: otp, ParametersConstants.firebaseToken: firebase_token, ParametersConstants.platform: deviceInfo,
            ParametersConstants.appVersion: versionName});
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        preferences.setToken(wrapper.data!.token!);
        // List<String> logins = await preferences.getLogins();
        // if (logins.length == 0) {
        //   List<String> logins = [];
        //   logins.add(wrapper.message!);
        //   preferences.setLogins(logins);
        // } else {
        //   if (logins.length > 5) {
        //     logins.removeAt(0);
        //   }
        // }
        wrapper.isSuccessFull = true;

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
        printLog("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<GetTermsandPrivacyResponse> getTermsPrivacyURL() async {
    Dio dio = await getBaseDio();
    var cookieJar=CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    GetTermsandPrivacyResponse wrapper = GetTermsandPrivacyResponse();
    try {
      Response response = await dio.get(Constants.termsOfUse);
      if (response.statusCode == 200) {
        wrapper = GetTermsandPrivacyResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        printLog("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["error"]["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<GetProfileSetAlertResponseBean> getProfileSetAlert(int isForAlert, int percentage, int amount) async {
    Dio dio = await getBaseDio();
    GetProfileSetAlertResponseBean wrapper = GetProfileSetAlertResponseBean();
    try {
      Response response = await dio.get(Constants.getProfileSetAlert,
          queryParameters: {ParametersConstants.isForAlert: isForAlert, ParametersConstants.percentage: percentage, ParametersConstants.amount: amount});
      if (response.statusCode == 200) {
        wrapper = GetProfileSetAlertResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }
}

