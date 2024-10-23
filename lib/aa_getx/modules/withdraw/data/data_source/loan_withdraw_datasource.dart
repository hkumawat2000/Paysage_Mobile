import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/common_response_model.dart';
import 'package:lms/aa_getx/modules/withdraw/data/models/loan_withdraw_response_model.dart';
import 'package:lms/aa_getx/modules/withdraw/data/models/request/withdraw_loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/withdraw/data/models/request/withdraw_otp_request_model.dart';

abstract class LoanWithdrawDatasource {
  Future<LoanWithdrawResponseModel> getWithdrawDetails(
      WithdrawLoanDetailsRequestModel withdrawLoanDetails);

  Future<CommonResponseModel> requestLoanWithDrawOTP();

  Future<CommonResponseModel> createWithDrawRequest(
      WithdrawOtpRequestModel withdrawOtpRequestDataModel);
}

class LoanWithdrawDatasourcecDataSourceImpl
    with BaseDio
    implements LoanWithdrawDatasource {
  Future<LoanWithdrawResponseModel> getWithdrawDetails(
      WithdrawLoanDetailsRequestModel withdrawLoanDetails) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
        Apis.withdrawDetails,
        data: withdrawLoanDetails.toJson(),
      );
      if (response.statusCode == 200) {
        return LoanWithdrawResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<CommonResponseModel> requestLoanWithDrawOTP() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.withdrawOtp,
      );
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

   Future<CommonResponseModel> createWithDrawRequest(
      WithdrawOtpRequestModel withdrawOtpRequestDataModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.consentDetails,
        data: withdrawOtpRequestDataModel.toJson(),
      );
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
