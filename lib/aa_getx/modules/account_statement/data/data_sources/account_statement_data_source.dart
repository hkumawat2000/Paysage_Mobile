
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/account_statement/data/models/loan_statement_response_model.dart';
import 'package:lms/aa_getx/modules/account_statement/data/models/recent_transactions_response_model.dart';
import 'package:lms/aa_getx/modules/account_statement/data/models/request/loan_statement_request_model.dart';

abstract class AccountStatementDataSource {
  Future<LoanStatementResponseModel> submitLoanStatements(LoanStatementRequestModel loanStatementRequestModel);

  Future<LoanStatementResponseModel> getLoanStatements(LoanStatementRequestModel loanStatementRequestModel);

  Future<RecentTransactionResponseModel> getRecentTransactions(LoanStatementRequestModel loanStatementRequestModel);
}

class AccountStatementDataSourceImpl with BaseDio implements AccountStatementDataSource{

  @override
  Future<LoanStatementResponseModel> submitLoanStatements(LoanStatementRequestModel loanStatementRequestModel) async{
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.submitOrGetLoanStatement,
          queryParameters: loanStatementRequestModel.toJson());
      if (response.statusCode == 200) {
        return LoanStatementResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<LoanStatementResponseModel> getLoanStatements(LoanStatementRequestModel loanStatementRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.submitOrGetLoanStatement,
          queryParameters: loanStatementRequestModel.toJson());
      if (response.statusCode == 200) {
        return LoanStatementResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<RecentTransactionResponseModel> getRecentTransactions(LoanStatementRequestModel loanStatementRequestModel)  async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.submitOrGetLoanStatement,
          queryParameters: loanStatementRequestModel.toJson());
      if (response.statusCode == 200) {
        return RecentTransactionResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}