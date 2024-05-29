import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/network/requestbean/RegistrationRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/network/responsebean/RegistrationResponseBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/registration/RegistrationDao.dart';

class RegistrationRepository {
  final registerDao = RegistrationDao();

  Future<String> signInWithGoogle() => registerDao.signInWithGoogle();

  Future<bool> signOutWithGoogle() => registerDao.signOutGoogle();

  // Future<ModelWrapper> signInWithFacebook() => registerDao.signInWithFacebook();

  // Future<bool> signOutWithFacebook() => registerDao.signOutFacebook();

  Future<AuthLoginResponse> registartion(RegistartionRequestBean requestBean) =>
      registerDao.registartion(requestBean);

  Future<AuthLoginResponse> setPin( String pin) =>
      registerDao.setPin( pin);

  Future<AuthLoginResponse> getPin(mobile, pin,firebase_token) =>
      registerDao.getPin(mobile, pin,firebase_token);
}
