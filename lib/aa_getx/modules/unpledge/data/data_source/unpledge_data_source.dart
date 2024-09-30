
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/common_response_model.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/unpledge/data/models/request/unpledge_request_req_model.dart';
import 'package:lms/aa_getx/modules/unpledge/data/models/unpledge_details_response_model.dart';
import 'package:lms/aa_getx/modules/unpledge/data/models/unpledge_request_response_model.dart';

abstract class UnpledgeDataSource {
  Future<UnpledgeDetailsResponseModel> getUnpledgeDetails(LoanDetailsRequestModel loanDetailsRequestModel);

  Future<CommonResponseModel> requestUnpledgeOtp();

  Future<UnpledgeRequestResponseModel> unpledgeRequest(UnpledgeRequestReqModel unpledgeRequestReqModel);
}

class UnpledgeDataSourceImpl with BaseDio implements UnpledgeDataSource {
  @override
  Future<UnpledgeDetailsResponseModel> getUnpledgeDetails(LoanDetailsRequestModel loanDetailsRequestModel) async{
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.unpledgeDetails,
          queryParameters: loanDetailsRequestModel.toJson());
      if (response.statusCode == 200) {
        return UnpledgeDetailsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CommonResponseModel> requestUnpledgeOtp() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.unpledgeOtp);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<UnpledgeRequestResponseModel> unpledgeRequest(UnpledgeRequestReqModel unpledgeRequestReqModel) async{
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.unpledgeRequest, data: unpledgeRequestReqModel.toJson());
      if (response.statusCode == 200) {
        return UnpledgeRequestResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}