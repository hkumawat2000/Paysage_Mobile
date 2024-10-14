import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/bank/data/models/atrina_bank_response_model.dart';
import 'package:lms/aa_getx/modules/bank/data/models/bank_master_response_model.dart';
import 'package:lms/aa_getx/modules/bank/data/models/fund_acc_validation_response_model.dart';
import 'package:lms/aa_getx/modules/bank/data/models/request/bank_details_request_model.dart';
import 'package:lms/aa_getx/modules/bank/data/models/request/validate_bank_request_model.dart';

abstract class BankDataSource {
  Future<AtrinaBankResponseModel> getBankDetails();

  Future<BankMasterResponseModel> getIfscBankDetails(BankDetailsRequestModel bankDetailsRequestModel);

  Future<FundAccValidationResponseModel> validateBank(ValidateBankRequestModel validateBankRequestModel);
}

class BankDataSourceImpl with BaseDio implements BankDataSource {
  @override
  Future<AtrinaBankResponseModel> getBankDetails() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.atrinaBank,
      );
      if (response.statusCode == 200) {
        return AtrinaBankResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<BankMasterResponseModel> getIfscBankDetails(BankDetailsRequestModel bankDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
          Apis.bankMaster, queryParameters: bankDetailsRequestModel.toJson());
      if (response.statusCode == 200) {
        return BankMasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<FundAccValidationResponseModel> validateBank(ValidateBankRequestModel validateBankRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.auPennyDrop, data: validateBankRequestModel.toJson());
      if (response.statusCode == 200) {
        return FundAccValidationResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }


}