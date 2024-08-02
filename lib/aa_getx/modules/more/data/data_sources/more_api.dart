
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/more/data/models/get_profle_set_alert_response_model.dart';
import 'package:lms/aa_getx/modules/more/data/models/loan_details_response_model.dart';
import 'package:lms/aa_getx/modules/more/data/models/my_loans_response_model.dart';
import 'package:lms/aa_getx/modules/more/data/models/request/get_loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/more/data/models/request/get_profile_set_alert_request_model.dart';

abstract class MoreApi {
  Future<MyLoansResponseModel> getMyActiveLoans();

  Future<LoanDetailsResponseModel> getLoanDetails(GetLoanDetailsRequestModel getLoanDetailsRequestModel);

  Future<GetProfileSetAlertResponseModel> getProfileSetAlert(GetProfileSetAlertRequestModel getProfileSetAlertRequestModel);
}

class MoreApiImpl with BaseDio implements MoreApi {
  @override
  Future<MyLoansResponseModel> getMyActiveLoans() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.myLoan);
      if (response.statusCode == 200) {
        return MyLoansResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<LoanDetailsResponseModel> getLoanDetails(GetLoanDetailsRequestModel getLoanDetailsRequestModel) async {
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
  Future<GetProfileSetAlertResponseModel> getProfileSetAlert(GetProfileSetAlertRequestModel getProfileSetAlertRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.getProfileSetAlert,
          queryParameters: getProfileSetAlertRequestModel.toJson());
      if (response.statusCode == 200) {
        return GetProfileSetAlertResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}