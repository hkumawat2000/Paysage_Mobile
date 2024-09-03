import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/repositories/account_statement_repository.dart';

class SubmitLoanStatementUseCase extends UsecaseWithParams<LoanStatementResponseEntity, LoanStatementParams>{
  final AccountStatementRepository accountStatementRepository;

  SubmitLoanStatementUseCase(this.accountStatementRepository);

  @override
  ResultFuture<LoanStatementResponseEntity> call(LoanStatementParams params) async{
    return await accountStatementRepository.submitLoanStatements(params.loanStatementRequestEntity);
  }

}

class LoanStatementParams {
  final LoanStatementRequestEntity loanStatementRequestEntity;

  LoanStatementParams({required this.loanStatementRequestEntity});
}