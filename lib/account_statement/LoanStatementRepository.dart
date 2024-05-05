import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/LoanStatementResponseBean.dart';
import 'package:choice/network/responsebean/RecentTransactionResponseBean.dart';
import 'package:choice/account_statement/LoanStatementDao.dart';

class LoanStatementRepository {
  final loanStatementDao = LoanStatementDao();

  Future<LoanStatementResponseBean> getLoanStatements(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.getLoanStatements(loanStatementRequestBean);
  Future<LoanStatementResponseBean> submitLoanStatements(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.submitLoanStatements(loanStatementRequestBean);
  Future<RecentTransactionResponseBean> getRecentTransactions(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.getRecentTransactions(loanStatementRequestBean);

}