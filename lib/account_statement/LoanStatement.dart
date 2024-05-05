import 'package:choice/common_widgets/constants.dart';
import 'package:choice/account_statement//DownloadStatementView.dart';
import 'package:choice/account_statement//RecentTransactionView.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class LoanStatementScreen extends StatefulWidget {
  final loanName, loanBalance, drawingPower, loanType;

  @override
  State<StatefulWidget> createState() {
    return LoanStatementScreenState();
  }

  LoanStatementScreen(this.loanName, this.loanBalance, this.drawingPower, this.loanType);
}

class LoanStatementScreenState extends State<LoanStatementScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: NavigationBackImage(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          widget.loanName,
          style: mediumTextStyle_18_gray_dark,
        ),
        backgroundColor: colorBg,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: headingText('Loan Statement'),
              ),
            ],
          ),
          SizedBox(height: 10),
          loanStatementCard(),
          Expanded(child: LoanStatementScreenTab(widget.loanName, widget.loanType)),
        ],
      ),
    );
  }

  Widget loanStatementCard() {
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
                      Text(widget.loanBalance < 0
                          ? negativeValue(double.parse(widget.loanBalance.toString().replaceAll(",", "")))
                          : '₹${numberToString(widget.loanBalance.toStringAsFixed(2))}',
                        style: boldTextStyle_18.copyWith(
                            color: widget.loanBalance < 0 ? colorGreen : appTheme
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
                      Text(widget.drawingPower < 0
                          ? negativeValue(double.parse(widget.drawingPower.toString().replaceAll(",", "")))
                          : '₹${numberToString(widget.drawingPower.toStringAsFixed(2))}',
                        style: boldTextStyle_18,
                      ),
                      // Text('₹${numberToString(widget.drawingPower.toStringAsFixed(2))}',
                      //   style: boldTextStyle_18,
                      // ),
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

class LoanStatementScreenTab extends StatefulWidget {
  final loanName;
  final loanType;

  LoanStatementScreenTab(this.loanName, this.loanType);

  @override
  State<StatefulWidget> createState() {
    return LoanStatementScreenTabState();
  }
}

class LoanStatementScreenTabState extends State<LoanStatementScreenTab>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                controller: _tabController,
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
            )
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              RecentTransactionViewScreen(widget.loanName, Strings.loan_statement, _tabController!, widget.loanType),
              DownloadStatementView(widget.loanName, Strings.loan_statement, _tabController!),
            ],
          ),
        ),
      ],
    );
  }
}
