// PledgeSecurityTransactionDao
import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'PledgeSecurityTransactionDao.dart';

class PledgeSecurityTransactionRepository {
  final pledgeSecurityTransactionDao = PledgeSecurityTransactionDao();

  Future<PledgeSecurityTransactionResponseBean> getPledgeSecurityTransaction(LoanStatementRequestBean loanStatementRequestBean) => pledgeSecurityTransactionDao.getPledgeSecurityTransaction(loanStatementRequestBean);
}