
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/registration/data/models/auth_login_response.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/set_pin_usecase.dart';
import 'package:lms/util/constants.dart';

abstract class RegistrationApi {
  Future<AuthLoginResponse> setPin(SetPinParams params);
}

class RegistrationApiImpl with BaseDio implements RegistrationApi{
  @override
  Future<AuthLoginResponse> setPin(SetPinParams params)async {
    Dio dio = await getBaseDio();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio
          //.post(Constants.setPin, data: {ParametersConstants.pin: params});
          .post(Constants.setPin, data: params.toJson());
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        debugPrint("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.data["message"];
      }
    }
    return wrapper;
  }


}