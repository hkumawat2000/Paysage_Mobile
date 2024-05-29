import 'package:lms/common_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import '../account_statement/DownloadStatementView.dart';
import '../account_statement/RecentTransactionView.dart';


class MyPledgeTransactionScreen extends StatefulWidget {
  final loanName, loanBalance, drawingPower, loanType;

  MyPledgeTransactionScreen(this.loanName, this.loanBalance, this.drawingPower, this.loanType);

  @override
  _MyPledgeTransactionScreenState createState() => _MyPledgeTransactionScreenState();
}

class _MyPledgeTransactionScreenState extends State<MyPledgeTransactionScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          widget.loanName,
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
          recentTransactionCard(),
          Expanded(child: RecentTransactionScreenTab(widget.loanName, widget.loanType)),
        ],
      ),
    );
  }

  Widget recentTransactionCard() {
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


class RecentTransactionScreenTab extends StatefulWidget {
  final loanName;
  final loanType;

  RecentTransactionScreenTab(this.loanName, this.loanType);

  @override
  _RecentTransactionScreenTabState createState() => _RecentTransactionScreenTabState();
}

class _RecentTransactionScreenTabState extends State<RecentTransactionScreenTab>
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
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              RecentTransactionViewScreen(widget.loanName, Strings.recent_transactions , _tabController!, widget.loanType),
              DownloadStatementView(widget.loanName, Strings.recent_transactions, _tabController!),
            ],
          ),
        ),
      ],
    );
  }
}
