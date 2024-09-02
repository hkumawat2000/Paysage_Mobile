
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';

abstract class AccountStatementRepository{
  ResultFuture<LoanStatementResponseEntity> submitLoanStatements(LoanStatementRequestEntity loanStatementRequestEntity);

  ResultFuture<LoanStatementResponseEntity> getLoanStatements(LoanStatementRequestEntity loanStatementRequestEntity);

}