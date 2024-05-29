import 'dart:async';
import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';
import 'package:lms/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'package:lms/security_transaction/PledgeSecurityTransactionRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class PledgeSecurityTransactionBloc {
  PledgeSecurityTransactionBloc();

  final pledgeSecurityTransactionRepository = PledgeSecurityTransactionRepository();
  final pledgeSecurityTransactionController =
      StreamController<List<PledgedSecuritiesTransactions>>.broadcast();

  get pledgeSecurityTransaction => pledgeSecurityTransactionController.stream;

  Future<PledgeSecurityTransactionResponseBean> getPledgeSecurityTransaction(
      LoanStatementRequestBean loanStatementRequestBean) async {
    PledgeSecurityTransactionResponseBean wrapper = await pledgeSecurityTransactionRepository
        .getPledgeSecurityTransaction(loanStatementRequestBean);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      pledgeSecurityTransactionController.sink.add(wrapper.data!.pledgedSecuritiesTransactions!);
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  dispose() {
    pledgeSecurityTransactionController.close();
  }
}
