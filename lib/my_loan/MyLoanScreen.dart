import 'package:lms/my_loan/MyAdtiveLoanScreen.dart';
import 'package:lms/my_loan/MyInActiveLoanScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoanScreen extends StatefulWidget{
  @override
  MyLoanScreenState createState() => MyLoanScreenState();

}
class MyLoanScreenState extends State<MyLoanScreen> with SingleTickerProviderStateMixin{

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
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorTabBg,
          elevation: 0,
          title: Text(
            'My Loans',
            style: TextStyle(fontWeight: FontWeight.bold,color: appTheme,fontSize: 30),
          ),
          bottom: TabBar(
            labelColor: red,
            indicatorColor: red,
            unselectedLabelColor: appTheme,
            indicatorWeight: 1.0,
            labelStyle: TextStyle(fontSize: 14),
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: 'Active'),
              Tab(text: 'Inactive '),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MyActiveLoanScreen(),
            MyInActiveLoanScreen(),
          ],
        ),
      ),
    );
  }
}
