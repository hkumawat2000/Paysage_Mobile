
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/recent_transactions_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/repositories/account_statement_repository.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_loan_statements_usecase.dart';

class GetRecentTransactionsUseCase extends UsecaseWithParams<RecentTransactionResponseEntity, LoanStatementParams>{
  final AccountStatementRepository accountStatementRepository;

  GetRecentTransactionsUseCase(this.accountStatementRepository);

  @override
  ResultFuture<RecentTransactionResponseEntity> call(LoanStatementParams params) async{
    return await accountStatementRepository.getRecentTransactions(params.loanStatementRequestEntity);
  }

}
