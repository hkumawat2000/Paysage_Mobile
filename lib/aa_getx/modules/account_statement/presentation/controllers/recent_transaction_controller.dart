
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_loan_statements_usecase.dart';
import 'package:lms/account_statement/LoanStatementBloc.dart';
import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';

class RecentTransactionController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetLoanStatementsUseCase _getLoanStatementsUseCase;

  RecentTransactionController(this._connectionInfo, this._getLoanStatementsUseCase);

  final loanStatementBloc = LoanStatementBloc();
  Preferences preferences = Preferences();
  String? mobile, email;
  var isComingFrom;
  var loanName;
  // String? loanType;

  @override
  void onInit() {

      getData();
      if(widget.isComingFrom == Strings.loan_statement) {
        LoanStatementRequestBean loanStatementRequestBean =
        LoanStatementRequestBean(loanName: widget.loanName, type: "Account Statement");
        loanStatementBloc.getLoanStatements(loanStatementRequestBean);
      } else if(widget.isComingFrom == Strings.recent_transactions) {
        LoanStatementRequestBean loanStatementRequestBean =
        LoanStatementRequestBean(loanName: widget.loanName, type: "Pledged Securities Transactions");
        loanStatementBloc.getRecentTransactions(loanStatementRequestBean);
      }
    super.onInit();
  }

  getData() async {
    mobile = await preferences.getMobile();
    email = await preferences.getEmail();
  }

  Future<void> getLoanStatements() async{
    if(await _connectionInfo.isConnected){
    LoanStatementRequestEntity loanStatementRequestEntity = LoanStatementRequestEntity(
            loanName: loanName,
            type: "Account Statement",
            duration: durationValueSelected.value != "custom_date"
                ? durationValueSelected.value
                : null,
            fromDate: dateFormatFrom.value,
            toDate: dateFormatTo.value,
            fileFormat: currentFormat.value,
            isDownload: isDownloaded.value ? 1 : 0,
            isEmail: !isDownloaded.value ? 1 : 0);

    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }



}