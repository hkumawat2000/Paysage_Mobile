import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';
import 'package:lms/network/responsebean/LoanStatementResponseBean.dart';
import 'package:lms/network/responsebean/RecentTransactionResponseBean.dart';
import 'package:lms/account_statement/LoanStatementDao.dart';

class LoanStatementRepository {
  final loanStatementDao = LoanStatementDao();

  Future<LoanStatementResponseBean> getLoanStatements(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.getLoanStatements(loanStatementRequestBean);
  Future<LoanStatementResponseBean> submitLoanStatements(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.submitLoanStatements(loanStatementRequestBean);
  Future<RecentTransactionResponseBean> getRecentTransactions(LoanStatementRequestBean loanStatementRequestBean) => loanStatementDao.getRecentTransactions(loanStatementRequestBean);

}