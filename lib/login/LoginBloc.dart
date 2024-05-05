import 'package:choice/login/LoginRepository.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/network/responsebean/AuthResponse/GetTermsandPrivacyResponse.dart';
import 'package:choice/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:choice/network/responsebean/OTPResponseBean.dart';
import 'package:choice/network/responsebean/RegistrationResponseBean.dart';
import 'package:choice/network/responsebean/LoginResponseBean.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'LoginValidationBloc.dart';

class LoginBloc{
  final loginRepository = LoginRepository();

  Future<AuthLoginResponse> loginSubmit(mobileNumber, firebase_token,acceptTerms) async {
    AuthLoginResponse wrapper = await loginRepository.loginSubmit(mobileNumber,firebase_token,acceptTerms);
    return wrapper;
  }

  Future<AuthLoginResponse> otpVerify(mobileNumber,otp,firebase_token) async {
    AuthLoginResponse wrapper = await loginRepository.otpVerify(mobileNumber, otp,firebase_token);
    printLog("success otp");
    return wrapper;
  }

  Future<GetTermsandPrivacyResponse> getTermsPrivacyURL() async {
    GetTermsandPrivacyResponse wrapper = await loginRepository.getTermsPrivacyURL();
    return wrapper;
  }

  Future<GetProfileSetAlertResponseBean> getProfileSetAlert(int isForAlert, int percentage, int amount) async {
    GetProfileSetAlertResponseBean wrapper = await loginRepository.getProfileSetAlert(isForAlert, percentage, amount);
    return wrapper;
  }

}