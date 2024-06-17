import 'package:lms/network/requestbean/PaymentRequest.dart';
import 'package:lms/network/requestbean/RazorPayRequest.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/PaymentResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaymentDao extends BaseDio {
  Future<PaymentResponse> createOrderID(PaymentRequest request) async {
    Dio dio = await getBaseDioAuth();
    PaymentResponse wrapper = PaymentResponse();
    try {
      Response response = await dio.post(Constants.payment,
         data: request.toJson());
      if (response.statusCode == 200) {
        wrapper = PaymentResponse.fromJson(response.data);
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
        printLog("error${e.response!.data["error"]["description"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["error"]["description"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> createPaymentRequest(RazorPayRequest request) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.paymentRequest,
         data: request.toJson());
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        printLog("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> createInterestPaymentRequest(RazorPayRequest request) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.paymentRequest,
          data: request.toJson());
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        printLog("error${e.response!.data["message"]}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<LoanDetailsResponse> getLoanDetails(loanName) async {
    Dio dio = await getBaseDio();
    LoanDetailsResponse wrapper = LoanDetailsResponse();
    try {
      Response response = await dio.get(Constants.loanDetails,
          queryParameters: {ParametersConstants.loanName: loanName});
      printLog("loanNameloanNameloanName${loanName}");
      if (response.statusCode == 200) {
        wrapper = LoanDetailsResponse.fromJson(response.data);
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
        printLog("error${e.response!.data}");
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage;
        }

      }
    }
    return wrapper;
  }
}