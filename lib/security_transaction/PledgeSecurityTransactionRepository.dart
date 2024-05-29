// PledgeSecurityTransactionDao
import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';
import 'package:lms/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'PledgeSecurityTransactionDao.dart';

class PledgeSecurityTransactionRepository {
  final pledgeSecurityTransactionDao = PledgeSecurityTransactionDao();

  Future<PledgeSecurityTransactionResponseBean> getPledgeSecurityTransaction(LoanStatementRequestBean loanStatementRequestBean) => pledgeSecurityTransactionDao.getPledgeSecurityTransaction(loanStatementRequestBean);
}