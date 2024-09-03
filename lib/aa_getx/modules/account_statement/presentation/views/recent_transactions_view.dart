import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/recent_transactions_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_loan_statements_usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/get_recent_transactions.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/controllers/recent_transaction_controller.dart';
import 'package:lms/aa_getx/modules/account_statement/data/data_sources/account_statement_data_source.dart';
import 'package:lms/aa_getx/modules/account_statement/data/repositories/account_statement_repository_impl.dart';

class RecentTransactionView extends StatefulWidget {
  final loanName;
  final loanType;
  final isComingFrom;
  TabController tabController;

  @override
  State<StatefulWidget> createState() {
    return RecentTransactionViewState(loanName,isComingFrom, tabController, loanType);
  }

  RecentTransactionView(this.loanName, this.isComingFrom, this.tabController, this.loanType);
}

class RecentTransactionViewState extends State<RecentTransactionView> {
  final RecentTransactionController controller =
  Get.put(
    RecentTransactionController(
      Get.put(
        ConnectionInfoImpl(Connectivity()),
      ),
      Get.put(
        GetLoanStatementsUseCase(
            Get.put(AccountStatementRepositoryImpl(Get.put(AccountStatementDataSourceImpl())))),
      ),
      Get.put(
        GetRecentTransactionsUseCase(
            Get.put(AccountStatementRepositoryImpl(Get.put(AccountStatementDataSourceImpl())))),
      ),
    ),
  );
  final loanName;
  final loanType;
  final isComingFrom;
  TabController tabController;
  RecentTransactionViewState(this.loanName, this.isComingFrom, this.tabController, this.loanType);

  @override
  Widget build(BuildContext context) {
    controller.loanName = loanName;
    controller.isComingFrom = isComingFrom;
    return Obx(()=>Scaffold(
      backgroundColor: colorBg,
    body: widget.isComingFrom == Strings.loan_statement
          ? controller.loanTransactionList.isBlank! ? Container() : transactionList(controller.loanTransactionList)
          : controller.pledgedSecuritiesTransactionList.isBlank! ? Container() : pledgeSecuritiesTransactionList(controller.pledgedSecuritiesTransactionList),
    ));
  }

  Widget pledgeSecuritiesTransactionList(List<PledgedSecuritiesTransactionsEntity> pledgedSecuritiesTransactionList) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: pledgedSecuritiesTransactionList.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 14) {
            return downloadStatementMore();
          } else {
            return recentSecuritiesTransactionItem(pledgedSecuritiesTransactionList, index);
          }
        },
      ),
    );
  }

  Widget recentSecuritiesTransactionItem(List<PledgedSecuritiesTransactionsEntity> transactionList, index) {
    var displayDate = transactionList[index].creation;
    var displayDateFormatter = new DateFormat.yMMMd();
    var date = DateTime.parse(displayDate!);
    String formattedDate = displayDateFormatter.format(date);
    return Card(
      color: colorWhite,
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(15, 2, 15, 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                formattedDate,
                style: TextStyle(fontSize: 18, color: appTheme)
            ),
            SizedBox(height: 5),
            Text(widget.loanType == Strings.shares
                ? transactionList[index].securityName!
                : "${transactionList[index].securityName!} [${transactionList[index].folio}]",
                style: TextStyle(fontSize: 16, color: appTheme,fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 2),
            Text("${transactionList[index].securityCategory!} (LTV: ${transactionList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                style: TextStyle(fontSize: 10, color: appTheme)),
            SizedBox(height: 2),
            Text(
                transactionList[index].isin!,
                style: TextStyle(fontSize: 10, color: appTheme)
            ),
            SizedBox(height: 2),
            Row(
              children: <Widget>[
                Text(widget.loanType == Strings.shares ?
                'QTY : ${transactionList[index].quantity!.toInt()}':
                'Units : ${transactionList[index].quantity!.toString()}',
                    style: TextStyle(fontSize: 14, color: appTheme)
                ),
                Spacer(),
                Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: transactionList[index].requestType.toString() == "Pledge" || transactionList[index].requestType.toString() == "Lien"
                          ? colorLightRed
                          : transactionList[index].requestType.toString() == "Unpledge" || transactionList[index].requestType.toString() == Strings.revoke
                          ? colorLightGreen
                          : transactionList[index].requestType.toString() == "Sell Collateral" || transactionList[index].requestType.toString() == Strings.invoke
                          ? colorLightGray
                          : colorLightAppTheme,
                    ),
                    child: Text(getRequestType(transactionList[index].requestType.toString()),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: semiBold,
                          color: transactionList[index].requestType.toString() == "Pledge" || transactionList[index].requestType.toString() == "Lien"
                              ? red
                              : transactionList[index].requestType.toString() == "Unpledge" || transactionList[index].requestType.toString() == Strings.revoke
                              ? colorGreen
                              : transactionList[index].requestType.toString() == "Sell Collateral" || transactionList[index].requestType.toString() == Strings.invoke
                              ? colorGrey
                              : appTheme,
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getRequestType(String requestType) {
    if(widget.loanType == Strings.shares){
      if(requestType == "Pledge"){
        return "Pledge";
      } else if(requestType == "Unpledge"){
        return "Unpledge";
      } else{
        return "Sell Collateral";
      }
    } else {
      if(requestType == "Pledge"){
        return "Lien";
      } else if(requestType == "Unpledge"){
        return Strings.revoke;
      } else{
        return Strings.invoke;
      }
    }
  }
  Widget transactionList(List<LoanTransactionListEntity> loanTransactionList) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 4.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: loanTransactionList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return recentTransactionItem(loanTransactionList, index);
        },
      ),
    );
  }

  Widget recentTransactionItem(List<LoanTransactionListEntity> transactionList, index) {
    var displayDate = transactionList[index].time;
    var displayDateFormatter = new DateFormat.yMMMd();
    var date = DateTime.parse(displayDate!);
    String formattedDate = displayDateFormatter.format(date);
    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color: colorWhite,
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(15, 2, 15, 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          formattedDate,
                          style: semiBoldTextStyle_18,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(transactionList[index].transactionType)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          // child: Text('₹${transactionList[index].amount.toString()}',
                          //     style: extraBoldTextStyle_18_gray_dark),
                          child: Text(double.parse(transactionList[index].amount.toString().replaceAll(",", "")) < 0
                              ? negativeValue(double.parse(transactionList[index].amount.toString().replaceAll(",", "")))
                              : '₹${transactionList[index].amount.toString()}',
                              style: extraBoldTextStyle_18_gray_dark),
                        ),
                        SizedBox(width: 5),
                        Container(
                            alignment: Alignment.center,
                            height: 26,
                            width: 26,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: transactionList[index].recordType.toString() == "DR"
                                  ? colorLightRed
                                  : colorLightGreen,
                            ),
                            child: Text(transactionList[index].recordType!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                    color: transactionList[index].recordType.toString() == "DR"
                                        ? red
                                        : colorGreen))),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget downloadStatementMore() {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              widget.tabController.animateTo((widget.tabController.index + 1) % 2);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => DownloadStatementView(widget.loanName, widget.isComingFrom)));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Download Statement for More", style: TextStyle(fontWeight: FontWeight.bold),),
            )),
      ],
    );
  }

}