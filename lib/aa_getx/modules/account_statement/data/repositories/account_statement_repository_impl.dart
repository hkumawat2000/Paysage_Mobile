import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/account_statement/data/data_sources/account_statement_data_source.dart';
import 'package:lms/aa_getx/modules/account_statement/data/models/request/loan_statement_request_model.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/repositories/account_statement_repository.dart';

class AccountStatementRepositoryImpl extends AccountStatementRepository{
  final AccountStatementDataSource accountStatementDataSource;
  AccountStatementRepositoryImpl(this.accountStatementDataSource);

  @override
  ResultFuture<LoanStatementResponseEntity> submitLoanStatements(LoanStatementRequestEntity loanStatementRequestEntity) async{
    try {
      LoanStatementRequestModel loanStatementRequestModel =
      LoanStatementRequestModel.fromEntity(
          loanStatementRequestEntity);
      final submitLoanStatementsResponse =
          await accountStatementDataSource.submitLoanStatements(loanStatementRequestModel);
      return DataSuccess(submitLoanStatementsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<LoanStatementResponseEntity> getLoanStatements(LoanStatementRequestEntity loanStatementRequestEntity) async {
    try {
      LoanStatementRequestModel loanStatementRequestModel =
      LoanStatementRequestModel.fromEntity(
          loanStatementRequestEntity);
      final getLoanStatementsResponse =
      await accountStatementDataSource.getLoanStatements(
          loanStatementRequestModel);
      return DataSuccess(getLoanStatementsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}