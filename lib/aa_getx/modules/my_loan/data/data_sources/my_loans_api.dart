import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/all_loan_names_response_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/common_response_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/lender_response_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/process_cart_response_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/create_loan_application_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/pledge_otp_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/securities_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/securities_response_model.dart';

abstract class MyLoansApi{
  Future<AllLoanNamesResponseModel> getAllLoansNames();

  Future<LendersResponseModel> getLenders();

  Future<SecuritiesResponseModel> getSecurities(SecuritiesRequestModel securitiesRequestModel);

  Future<CommonResponseModel> requestPledgeOTP(PledgeOTPRequestModel pledgeOTPRequestModel);

  Future<ProcessCartResponseModel> createLoanApplication(CreateLoanApplicationRequestModel requestModel);
}

class MyLoansApiImpl with BaseDio implements MyLoansApi{
  @override
  Future<AllLoanNamesResponseModel> getAllLoansNames() async{
    Dio dio = await  getBaseDio();
    try {
      final response = await dio.get(Apis.allLoanName);
      if(response.statusCode == 200) {
        return AllLoanNamesResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e){
      throw handleDioClientError(e);
    }
  }

  @override
  Future<LendersResponseModel> getLenders() async{
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.lenders);
        if(response.statusCode == 200) {
          return LendersResponseModel.fromJson(response.data);
        } else {
          throw ServerException(response.statusMessage);
        }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<SecuritiesResponseModel> getSecurities(SecuritiesRequestModel securitiesRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
          Apis.getSharesSecurities,
          queryParameters: securitiesRequestModel.toJson()
      );
      if (response.statusCode == 200) {
        return SecuritiesResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CommonResponseModel> requestPledgeOTP(PledgeOTPRequestModel pledgeOTPRequestModel) async {
    Dio dio = await getBaseDio();
    try{
       final response = await dio.post(Apis.requestPledgeOtp, data: pledgeOTPRequestModel.toJson());
       if(response.statusCode == 200){
         return CommonResponseModel.fromJson(response.data);
       } else {
         throw ServerException(response.statusMessage);
       }
    } on DioException catch (e){
      throw handleDioClientError(e);
    }
  }

  @override
  Future<ProcessCartResponseModel> createLoanApplication(CreateLoanApplicationRequestModel requestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.cartProcess, data: requestModel.toJson());
      if(response.statusCode == 200){
        return ProcessCartResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}