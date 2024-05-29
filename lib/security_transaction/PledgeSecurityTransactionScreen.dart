import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';
import 'package:lms/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'package:lms/security_transaction/PledgeSecurityTransactionBloc.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class PledgeSecurityTransactionScreen extends StatefulWidget {
  final loanName;

  @override
  State<StatefulWidget> createState() {
    return PledgeSecurityTransactionScreenState();
  }

  PledgeSecurityTransactionScreen(this.loanName);
}

class PledgeSecurityTransactionScreenState extends State<PledgeSecurityTransactionScreen> {
  final pledgeSecurityTransactionBloc = PledgeSecurityTransactionBloc();

  @override
  void initState() {
    LoanStatementRequestBean loanStatementRequestBean = LoanStatementRequestBean(
        loanName: widget.loanName, type: "Pledged Securities Transactions");
    pledgeSecurityTransactionBloc.getPledgeSecurityTransaction(loanStatementRequestBean);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                subHeadingText("Pledge Security Transaction"),
              ],
            ),
          ),
          Expanded(child: getTransactionList()),
        ],
      ),
    );
  }

  Widget getTransactionList() {
    return StreamBuilder(
      stream: pledgeSecurityTransactionBloc.pledgeSecurityTransaction,
      builder: (context, AsyncSnapshot<List<PledgedSecuritiesTransactions>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.length == 0) {
            return _buildNoDataWidget();
          } else {
            return transactionList(snapshot);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget transactionList(AsyncSnapshot<List<PledgedSecuritiesTransactions>> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(snapshot.data![index].securityName!),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(snapshot.data![index].amount.toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
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
