import 'package:choice/margin_shortfall_details/MarginActiveLoan.dart';
import 'package:choice/margin_shortfall_details/MarginInactiveLoan.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class MarginLoan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarginLoanState();
  }
}

class MarginLoanState extends State<MarginLoan> with SingleTickerProviderStateMixin {
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
            icon: NavigationBackImage(),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: appTheme,
            indicatorColor: appTheme,
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
            MarginActiveLoan(),
            MarginInActiveLoan(),
          ],
        ),
      ),
    );
  }
}
