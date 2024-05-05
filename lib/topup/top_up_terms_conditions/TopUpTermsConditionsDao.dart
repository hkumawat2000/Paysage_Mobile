import 'dart:convert';

import 'package:choice/network/responsebean/LoginResponseBean.dart';
import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/network/responsebean/TncResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TopUpTermsConditionsDao with BaseDio {
  Future<TermsConditionResponse> getTopUpTermsCondition(loan_name, double topup_amount) async {
    Dio dio = await getBaseDio();
    TermsConditionResponse wrapper = TermsConditionResponse();
    try {
      Response response =
      await dio.post('api/method/lms.cart.get_tnc', data: {"cart_name": "","loan_name":loan_name , "topup_amount": topup_amount});
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
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }
}
