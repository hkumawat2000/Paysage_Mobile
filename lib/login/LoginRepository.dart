import 'package:lms/login/LoginDao.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/AuthResponse/GetTermsandPrivacyResponse.dart';
import 'package:lms/network/responsebean/GetProfileSetAlertResponseBean.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/network/responsebean/RegistrationResponseBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';

class LoginRepository{
  final loginDao = LoginDao();
  Future<AuthLoginResponse> loginSubmit(mobileNumber,firebase_token,acceptTerms) =>
      loginDao.loginSubmit(mobileNumber, firebase_token,acceptTerms);

  Future<AuthLoginResponse> otpVerify( mobileNumber,  otp,firebase_token) =>
      loginDao.otpVerify(mobileNumber, otp,firebase_token);

  Future<GetTermsandPrivacyResponse> getTermsPrivacyURL() =>
      loginDao.getTermsPrivacyURL();

  Future<GetProfileSetAlertResponseBean> getProfileSetAlert(int isForAlert, int percentage, int amount) =>
      loginDao.getProfileSetAlert(isForAlert, percentage, amount);


}