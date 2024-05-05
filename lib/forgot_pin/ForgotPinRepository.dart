import 'package:choice/forgot_pin/ForgotPinDao.dart';
import 'package:choice/network/requestbean/ForgotPinRequestBean.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';

class ForgotPinRepository {
  final forgotPinDao = ForgotPinDao();

  Future<AuthLoginResponse> forgotOtpRequest(String email) => forgotPinDao.forgotOtpRequest(email);

  Future<AuthLoginResponse> forgotPin(ForgotPinRequestBean forgotPinRequestBean) => forgotPinDao.forgotPin(forgotPinRequestBean);
}