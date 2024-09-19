import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/modules/mf_central/data/models/request/fetch_mutual_fund_request_model.dart';
import 'package:lms/aa_getx/modules/mf_central/data/models/response/fetch_mutual_fund_response_model.dart';
import 'package:lms/aa_getx/modules/mf_central/data/models/response/mf_send_otp_response_model.dart';

import '../../../../core/network/base_dio.dart';

abstract class MfCentralDataSource {

  Future<MutualFundSendOtpResponseModel> mutualFundOtpSend();

  Future<FetchMutualFundResponseModel> fetchMutualFund(FetchMutualFundRequestModel fetchMutualFundRequestModel);

}

class MfCentralDataSourceImpl with BaseDio implements MfCentralDataSource {

  @override
  Future<MutualFundSendOtpResponseModel> mutualFundOtpSend() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.mutualFundSendOtp);
      if (response.statusCode == 200) {
        return MutualFundSendOtpResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<FetchMutualFundResponseModel> fetchMutualFund(FetchMutualFundRequestModel fetchMutualFundRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.fetchMutualFund, data: fetchMutualFundRequestModel.toJson());
      if (response.statusCode == 200) {
        return FetchMutualFundResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}