import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/more/data/models/loan_details_response_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/common_response_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/payment_response_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/payment_request_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/razor_pay_request_model.dart';

abstract class PaymentApi {
  Future<LoanDetailsResponseModel> getLoanDetails(LoanDetailsRequestModel getLoanDetailsRequestModel);

  Future<PaymentResponseModel> createOrderID(PaymentRequestModel paymentRequestModel);

  Future<CommonResponseModel> createPaymentRequest(RazorPayRequestModel razorPayRequestModel);

}

class PaymentApiImpl with BaseDio implements PaymentApi {
  @override
  Future<LoanDetailsResponseModel> getLoanDetails(LoanDetailsRequestModel getLoanDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.loanDetails,
          queryParameters: getLoanDetailsRequestModel.toJson());
      if (response.statusCode == 200) {
        return LoanDetailsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<PaymentResponseModel> createOrderID(PaymentRequestModel paymentRequestModel) async {
    Dio dio = await getBaseDioAuth();///todo: razorPay keys adding in getBaseDioAuth
    try {
      final response = await dio.post(Apis.payment,
          data: paymentRequestModel.toJson());
      if (response.statusCode == 200) {
        return PaymentResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CommonResponseModel> createPaymentRequest(RazorPayRequestModel razorPayRequestModel) async{
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.paymentRequest,
          data: razorPayRequestModel.toJson());
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}