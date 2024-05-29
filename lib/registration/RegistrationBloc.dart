import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/network/requestbean/RegistrationRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/network/responsebean/RegistrationResponseBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/registration/RegistrationRepository.dart';

class RegistrationBloc {
  final registerRepository = RegistrationRepository();

  Future<String> signInWithGoogle() async {
    String email;
    try {
      email = await registerRepository.signInWithGoogle();
    } catch (e) {
      email = "";
    }
    return email;
  }

  Future<bool> signOutWithGoogle() async {
    await registerRepository.signOutWithGoogle();
    return true;
  }

  // Future<bool> signOutWithFacebook() async {
  //   await registerRepository.signOutWithFacebook();
  //   return true;
  // }

  Future<AuthLoginResponse> submitRegistartion(RegistartionRequestBean requestBean) async {
    AuthLoginResponse wrapper = await registerRepository.registartion(requestBean);
    return wrapper;
  }

  // Future<ModelWrapper> signInWithFacebook() async {
  //   ModelWrapper isFacebookLoginSuccess = await registerRepository.signInWithFacebook();
  //   return isFacebookLoginSuccess;
  // }

  Future<AuthLoginResponse> setPin(String pin) async {
    AuthLoginResponse wrapper = await registerRepository.setPin(pin);
    return wrapper;
  }

  Future<AuthLoginResponse> getPin(mobile, pin, firebase_token) async {
    AuthLoginResponse wrapper = await registerRepository.getPin(mobile, pin, firebase_token);
    return wrapper;
  }
}
