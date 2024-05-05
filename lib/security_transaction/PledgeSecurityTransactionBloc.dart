import 'dart:async';
import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'package:choice/security_transaction/PledgeSecurityTransactionRepository.dart';
import 'package:choice/widgets/WidgetCommon.dart';

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
