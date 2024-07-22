
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/registration/data/models/auth_login_response.dart';
import 'package:lms/aa_getx/modules/registration/data/models/request/set_pin_request_model.dart';
import 'package:lms/aa_getx/modules/registration/data/models/request/registration_request_bean_model.dart';
import 'package:lms/util/constants.dart';

abstract class RegistrationApi {
  Future<AuthLoginResponse> setPin(SetPinRequestModel params);

  Future<AuthLoginResponse> submitRegistration(RegistrationRequestBeanModel params);
}

class RegistrationApiImpl with BaseDio implements RegistrationApi{
  @override
  Future<AuthLoginResponse> setPin(SetPinRequestModel params)async {
    Dio dio = await getBaseDio();
    try {
      Response response = await dio
          .post(Constants.setPin, data: params.toJson());
      if (response.statusCode == 200) {
        return AuthLoginResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);

    }
  }

  @override
  Future<AuthLoginResponse> submitRegistration(RegistrationRequestBeanModel params) async {
    Dio dio = await getBaseDioVersionPlatform();
    try {
      Response response =
      await dio.post(Apis.registration, data: params.toJson());
      if (response.statusCode == 200) {
        return AuthLoginResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
      // if (e.response == null) {
      //   wrapper.isSuccessFull = false;
      //   wrapper.errorMessage = Strings.server_error_message;
      //   wrapper.errorCode = Constants.noInternet;
      // } else {
      //   wrapper.isSuccessFull = false;
      //   wrapper.errorCode = e.response!.statusCode;
      //   if(e.response!.data["errors"] == null){
      //     wrapper.errorMessage = e.response!.data["message"] ?? Strings.something_went_wrong;
      //   } else {
      //     if(e.response!.data["errors"]["first_name"] != null){
      //       wrapper.errorMessage = e.response!.data["errors"]["first_name"];
      //     } else if(e.response!.data["errors"]["mobile"] != null){
      //       wrapper.errorMessage = e.response!.data["errors"]["mobile"];
      //     } else if(e.response!.data["errors"]["email"] != null){
      //       wrapper.errorMessage = e.response!.data["errors"]["email"];
      //     } else if(e.response!.data["errors"]["firebase_token"] != null){
      //       wrapper.errorMessage = e.response!.data["errors"]["firebase_token"];
      //     } else {
      //       wrapper.errorMessage = Strings.something_went_wrong;
      //     }
      //   }
      // }
    }
  }


}