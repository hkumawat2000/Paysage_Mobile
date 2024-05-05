import 'dart:convert';

import 'package:choice/network/requestbean/TermsConditionRequestBean.dart';
import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/network/responsebean/TncResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class TnCDao with BaseDio {
  Future<TnCResponseBean> getTnCList() async {
    Dio dio = await getBaseDio();
    TnCResponseBean wrapper = TnCResponseBean();
    try {
      Response response = await dio.get(
        'api/resource/Terms and Conditions?fields=["tnc"]&filters={"is_active":1}',
      );
      if (response.statusCode == 200) {
        wrapper = TnCResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else if (response.statusCode == 401) {
        wrapper.isSuccessFull = false;
      } else if (response.statusCode == 504) {
        wrapper.isSuccessFull = false;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }

  Future<TermsConditionResponse> saveTnCList(TermsConditionRequestBean termsConditionRequestBean) async {
    Dio dio = await getBaseDio();
    TermsConditionResponse wrapper = TermsConditionResponse();
    try {
      Response response = await dio.post(Constants.termsConditions, data: termsConditionRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = TermsConditionResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = Strings.something_went_wrong;
        }
      }
    }
    return wrapper;
  }
}
