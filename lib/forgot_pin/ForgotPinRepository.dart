import 'package:lms/forgot_pin/ForgotPinDao.dart';
import 'package:lms/network/requestbean/ForgotPinRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';

class ForgotPinRepository {
  final forgotPinDao = ForgotPinDao();

  Future<AuthLoginResponse> forgotOtpRequest(String email) => forgotPinDao.forgotOtpRequest(email);

  Future<AuthLoginResponse> forgotPin(ForgotPinRequestBean forgotPinRequestBean) => forgotPinDao.forgotPin(forgotPinRequestBean);
}