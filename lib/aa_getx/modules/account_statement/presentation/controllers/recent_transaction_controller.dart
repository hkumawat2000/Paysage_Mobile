
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/recent_transactions_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_loan_statements_usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_recent_transactions.dart';

class RecentTransactionController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetLoanStatementsUseCase _getLoanStatementsUseCase;
  final GetRecentTransactionsUseCase _getRecentTransactionsUseCase;

  RecentTransactionController(this._connectionInfo, this._getLoanStatementsUseCase, this._getRecentTransactionsUseCase);

  Preferences preferences = Preferences();
  String? mobile, email;
  var isComingFrom;
  var loanName;
  RxList<LoanTransactionListEntity> loanTransactionList = <LoanTransactionListEntity>[].obs;
  RxList<PledgedSecuritiesTransactionsEntity> pledgedSecuritiesTransactionList = <PledgedSecuritiesTransactionsEntity>[].obs;
  // String? loanType;

  @override
  void onInit() {
      getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isComingFrom == Strings.loan_statement) {
        getLoanStatements();
      } else if(isComingFrom == Strings.recent_transactions) {
        getRecentTransactions();
      }
    });
    super.onInit();
  }

  getData() async {
    mobile = await preferences.getMobile();
    email = await preferences.getEmail();
  }

  Future<void> getLoanStatements() async {
    if (await _connectionInfo.isConnected) {
      LoanStatementRequestEntity loanStatementRequestEntity = LoanStatementRequestEntity(
          loanName: loanName,
          type: "Account Statement",
          duration: null,
          fileFormat: "",
          fromDate: null,
          toDate: null,
          isEmail: 0,
          isDownload: 0);

      showDialogLoading(Strings.please_wait);
      DataState<LoanStatementResponseEntity> response =
      await _getLoanStatementsUseCase.call(LoanStatementParams(
          loanStatementRequestEntity: loanStatementRequestEntity));
      Get.back();

      if (response is DataSuccess) {
        if (response.data != null) {
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = loanName;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.view_loan_statement, parameter);

          loanTransactionList.value = response.data!.loanData!.loanTransactionList!;
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void getRecentTransactions() async{
    if (await _connectionInfo.isConnected) {
      LoanStatementRequestEntity loanStatementRequestEntity = LoanStatementRequestEntity(
          loanName: loanName,
          type: "Pledged Securities Transactions",
          duration: null,
          fileFormat: "",
          fromDate: null,
          toDate: null,
          isEmail: 0,
          isDownload: 0);

      showDialogLoading(Strings.please_wait);
      DataState<RecentTransactionResponseEntity> response =
      await _getRecentTransactionsUseCase.call(LoanStatementParams(
          loanStatementRequestEntity: loanStatementRequestEntity));
      Get.back();

      if (response is DataSuccess) {
        if (response.data != null) {
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = loanName;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.view_pledge_statement, parameter);
          pledgedSecuritiesTransactionList.value = response.data!.loanData!.pledgedSecuritiesTransactions!;
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

}