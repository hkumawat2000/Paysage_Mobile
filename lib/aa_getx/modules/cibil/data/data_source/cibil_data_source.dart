import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_on_demand_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_otp_verification_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_on_demand_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_otp_verification_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_send_otp_response_model.dart';

abstract class CibilDataSource {
  Future<CibilSendOtpResponseModel> cibilOtpSend();

  Future<CibilOtpVerificationResponseModel> cibilOtpVerification(CibilOtpVerificationRequestModel cibilOtpVerificationRequestModel);

  Future<CibilOnDemandResponseModel> cibilOnDemand(CibilOnDemandRequestModel cibilOnDemandRequestModel);
}

class CibilDataSourceImpl with BaseDio implements CibilDataSource {

  @override
  Future<CibilSendOtpResponseModel> cibilOtpSend() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.cibilOtpSend);
      if (response.statusCode == 200) {
        return CibilSendOtpResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CibilOtpVerificationResponseModel> cibilOtpVerification(CibilOtpVerificationRequestModel cibilOtpVerificationRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.cibilOnDemand, data: cibilOtpVerificationRequestModel.toJson());
      if (response.statusCode == 200) {
        return CibilOtpVerificationResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CibilOnDemandResponseModel> cibilOnDemand(CibilOnDemandRequestModel cibilOnDemandRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.cibilOnDemand, data: cibilOnDemandRequestModel.toJson());
      if (response.statusCode == 200) {
        return CibilOnDemandResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}