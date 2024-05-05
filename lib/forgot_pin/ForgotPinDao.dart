import 'package:choice/network/requestbean/ForgotPinRequestBean.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';
import 'package:choice/util/base_dio.dart';

class ForgotPinDao with BaseDio{

  Future<AuthLoginResponse> forgotOtpRequest(String email) async {
    Dio dio = await getBaseDio();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.forgotPinOtp, data: {"email": email});
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }
      else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        if(e.response!.statusCode == 403) {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        }
      }
    }
    return wrapper;
  }

  Future<AuthLoginResponse> forgotPin(ForgotPinRequestBean forgotPinRequestBean) async {
    Dio dio = await getBaseDio();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.forgotPinVerify, data: forgotPinRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }
      else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        if(e.response!.statusCode == 403) {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        }
      }
    }
    return wrapper;
  }

}