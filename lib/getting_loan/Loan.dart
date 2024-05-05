import 'package:choice/getting_loan/ActiveLoan.dart';
import 'package:choice/getting_loan/InactiveLoan.dart';
import 'package:flutter/material.dart';

class Loan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoanState();
  }
}

class LoanState extends State<Loan> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.blueGrey,
              size: 40.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.blueGrey,
            indicatorColor: Colors.blueGrey,
            indicatorWeight: 5.0,
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: 'Active Loan'),
              Tab(text: 'InActive Loan'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ActiveLoan(),
            InActiveLoan(),
          ],
        ),
      ),
    );
  }
}
