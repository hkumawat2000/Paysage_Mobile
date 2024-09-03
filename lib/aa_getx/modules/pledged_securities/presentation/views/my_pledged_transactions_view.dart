

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/arguments/loan_statement_arguments.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/views/download_statement_view.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/views/recent_transactions_view.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/controllers/recent_transactions_screen_tab_controller.dart';

class MyPledgedTransactionsView extends StatelessWidget{

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    LoanStatementArguments loanStatementArguments = Get.arguments;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: NavigationBackImage(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          loanStatementArguments.loanName!,
          style: mediumTextStyle_18_gray_dark,
        ),
        backgroundColor: colorBg,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: headingText(Strings.recent_transactions),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          recentTransactionCard(loanStatementArguments),
          Expanded(child: RecentTransactionScreenTab(loanStatementArguments.loanName, loanStatementArguments.loanType)),
        ],
      ),
    );
  }

  Widget recentTransactionCard(LoanStatementArguments loanStatementArguments) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
            decoration: BoxDecoration(
              color: colorLightBlue,
              border: Border.all(color: colorLightBlue, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              children:  <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(loanStatementArguments.loanBalance! < 0
                          ? negativeValue(double.parse(loanStatementArguments.loanBalance.toString().replaceAll(",", "")))
                          : '₹${numberToString(loanStatementArguments.loanBalance!.toStringAsFixed(2))}',
                        style: boldTextStyle_18.copyWith(
                            color: loanStatementArguments.loanBalance! < 0 ? colorGreen : appTheme
                        ),
                      ),
                      Text(Strings.loan_balance, style : subHeading),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Container(
                    height: 40.0,
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(loanStatementArguments.drawingPower! < 0
                          ? negativeValue(double.parse(loanStatementArguments.drawingPower.toString().replaceAll(",", "")))
                          : '₹${numberToString(loanStatementArguments.drawingPower!.toStringAsFixed(2))}',
                        style: boldTextStyle_18,
                      ),
                      Text(Strings.drawing_power, style : subHeading),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}


class RecentTransactionScreenTab extends GetView<RecentTransactionScreenTabController>  {
  final loanName;
  final loanType;

  RecentTransactionScreenTab(this.loanName, this.loanType);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RecentTransactionScreenTabController());
    controller.loanName.value = loanName;
    controller.loanType.value = loanType;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: DefaultTabController(
            length: 2,
            child: TabBar(
              controller: controller.tabController,
              labelColor: red,
              indicatorColor: red,
              unselectedLabelColor: appTheme,
              indicatorWeight: 1.0,
              labelStyle: TextStyle(fontSize: 11.5),
              tabs: <Widget>[
                Tab(text: 'Recent Transactions'),
                Tab(text: 'Download Statement'),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: <Widget>[
              RecentTransactionView(controller.loanName.value, Strings.recent_transactions , controller.tabController!, controller.loanType.value),
              DownloadStatementView(controller.loanName.value, Strings.recent_transactions, controller.tabController!),
            ],
          ),
        ),
      ],
    );
  }
}