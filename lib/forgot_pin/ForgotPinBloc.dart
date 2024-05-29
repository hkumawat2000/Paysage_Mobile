import 'package:lms/forgot_pin/ForgotPinRepository.dart';
import 'package:lms/network/requestbean/ForgotPinRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';

class ForgotPinBloc {
  ForgotPinBloc();
  final forgotPinRepository = ForgotPinRepository();

  Future<AuthLoginResponse> forgotOtpRequest(String email) async{
    AuthLoginResponse wrapper = await forgotPinRepository.forgotOtpRequest(email);
    return wrapper;
  }

  Future<AuthLoginResponse> forgotPin(ForgotPinRequestBean forgotPinRequestBean) async{
    AuthLoginResponse wrapper = await forgotPinRepository.forgotPin(forgotPinRequestBean);
    return wrapper;
  }
}