import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/LoanStatementResponseBean.dart';
import 'package:choice/network/responsebean/RecentTransactionResponseBean.dart';
import 'package:choice/account_statement//LoanStatementBloc.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/ErrorMessageWidget.dart';
import 'package:choice/widgets/LoadingWidget.dart';
import 'package:choice/widgets/NoDataWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class RecentTransactionViewScreen extends StatefulWidget {
  final loanName;
  final loanType;
  final isComingFrom;
  TabController tabController;

  @override
  State<StatefulWidget> createState() {
    return RecentTransactionViewState();
  }

  RecentTransactionViewScreen(this.loanName, this.isComingFrom, this.tabController, this.loanType);
}

class RecentTransactionViewState extends State<RecentTransactionViewScreen> {
  final loanStatementBloc = LoanStatementBloc();
  Preferences preferences = Preferences();
  String? mobile, email;
  // String? loanType;

  @override
  void initState() {
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
    super.initState();
  }

  getData() async {
    mobile = await preferences.getMobile();
    email = await preferences.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: widget.isComingFrom == Strings.loan_statement
          ? getTransactionList()
          : getPledgeSecuritiesTransactions(),
    );
  }

  Widget getPledgeSecuritiesTransactions(){
    return StreamBuilder(
      stream: loanStatementBloc.transactions,
      builder: (context, AsyncSnapshot<List<PledgedSecuritiesTransactions>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.length == 0) {
            return _buildNoDataWidget();
          } else {
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = widget.loanName;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.view_pledge_statement, parameter);
            return pledgeSecuritiesTransactionList(snapshot);
          }
        } else if (snapshot.hasError) {
          if(snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return _buildErrorWidget(Strings.session_timeout);
          }
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget pledgeSecuritiesTransactionList(AsyncSnapshot<List<PledgedSecuritiesTransactions>> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
      child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 14) {
                return downloadStatementMore();
              } else {
                return recentSecuritiesTransactionItem(snapshot.data!, index);
              }
            },
          ),
    );
  }

  Widget recentSecuritiesTransactionItem(List<PledgedSecuritiesTransactions> transactionList, index) {
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

  Widget getTransactionList() {
    return StreamBuilder(
      stream: loanStatementBloc.withdrawLoan,
      builder: (context, AsyncSnapshot<List<LoanTransactionList>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.length == 0) {
            return _buildNoDataWidget();
          } else {
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = widget.loanName;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.view_loan_statement, parameter);
            return transactionList(snapshot);
          }
        } else if (snapshot.hasError) {
          if(snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return _buildErrorWidget(Strings.session_timeout);
          }
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget transactionList(AsyncSnapshot<List<LoanTransactionList>> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 4.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return recentTransactionItem(snapshot.data!, index);
        },
      ),
    );
  }

  Widget recentTransactionItem(List<LoanTransactionList> transactionList, index) {
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

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }
}
