import 'dart:io';

import 'package:lms/network/requestbean/MFSchemeRequest.dart';
import 'package:lms/network/responsebean/MFSchemeResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class MFSchemeDao extends BaseDio {
  Future<MFSchemeResponse> getSchemesList(MFSchemeRequest request) async {
    Dio dio = await getBaseDio();
    MFSchemeResponse wrapper = MFSchemeResponse();
    try {
      Response response = await dio.get(Constants.getScheme,
          queryParameters: request.toJson());
      if (response.statusCode == 200) {
        wrapper = MFSchemeResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    }on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}
