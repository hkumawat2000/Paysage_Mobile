import 'dart:async';

import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/LoanStatementResponseBean.dart';
import 'package:choice/network/responsebean/RecentTransactionResponseBean.dart';
import 'package:choice/account_statement/LoanStatementRepository.dart';
import 'package:choice/widgets/WidgetCommon.dart';

class LoanStatementBloc {
  LoanStatementBloc();

  final loanStatementRepository = LoanStatementRepository();

  final loanStatementController = StreamController<List<LoanTransactionList>>.broadcast();
  final recentTransactionsController = StreamController<List<PledgedSecuritiesTransactions>>.broadcast();

  get withdrawLoan => loanStatementController.stream;
  get transactions => recentTransactionsController.stream;

  Future<LoanStatementResponseBean> getLoanStatements(LoanStatementRequestBean loanStatementRequestBean) async {
    LoanStatementResponseBean wrapper = await loanStatementRepository.getLoanStatements(loanStatementRequestBean);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      loanStatementController.sink.add(wrapper.loanData!.loanTransactionList!);
    } else {
      printLog("-----FAIL-----");
      if (wrapper.errorCode == 403) {
        loanStatementController.sink.addError(wrapper.errorCode.toString());
      } else {
        loanStatementController.sink.addError(wrapper.errorMessage!);
      }
    }
    return wrapper;
  }

  Future<LoanStatementResponseBean> submitLoanStatements(LoanStatementRequestBean loanStatementRequestBean) async {
    LoanStatementResponseBean wrapper = await loanStatementRepository.submitLoanStatements(loanStatementRequestBean);
    return wrapper;
  }

  Future<RecentTransactionResponseBean> getRecentTransactions(LoanStatementRequestBean loanStatementRequestBean) async {
    RecentTransactionResponseBean wrapper = await loanStatementRepository.getRecentTransactions(loanStatementRequestBean);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      recentTransactionsController.sink.add(wrapper.loanData!.pledgedSecuritiesTransactions!);
    } else {
      printLog("-----FAIL-----");
      if(wrapper.errorCode == 403) {
        recentTransactionsController.sink.addError(wrapper.errorCode.toString());
      } else {
        recentTransactionsController.sink.addError(wrapper.errorMessage!);
      }
    }
    return wrapper;
  }


  dispose() {
    loanStatementController.close();
    recentTransactionsController.close();
  }
}
