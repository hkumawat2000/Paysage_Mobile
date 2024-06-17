import 'dart:io';

import 'package:lms/loan_withdraw/LoanWithdrawScreen.dart';
import 'package:lms/account_statement/LoanStatement.dart';
import 'package:lms/util/Colors.dart';
import 'package:flutter/material.dart';

class AccountStatementList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountStatementListtScreenState();
  }
}

class AccountStatementListtScreenState extends State<AccountStatementList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: appTheme,
            size: 40.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          loanAccountDetails(),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            child: Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 120,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 80,
                      color: appTheme,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Rs." + "50,000",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Outstanding Limit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Rs." + "1,000,00",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Overdraft Limit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoanWithdrawScreen("")));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              child: Text("Statement"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoanStatementScreen(
                                                "", "", "", "")));
                              },
                            ),
                            verticalDivider(),
                            Text("Increase loan"),
                            verticalDivider(),
                            Text("Pay now"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: activeLoanList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Recent Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Flexible(child: recentTransactionList()),
        ],
      ),
    );
  }

  Widget verticalDivider() {
    return Container(
      width: 1.5,
      height: 20,
      color: Colors.grey,
    );
  }

  Widget loanAccountDetails() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Text('Loan Account no.\n SPA1234'),
        ],
      ),
    );
  }

  Widget activeLoanList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return activeLoanItem();
        },
      ),
    );
  }

  Widget recentTransactionList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return recentTransactionItem();
        },
      ),
    );
  }

  Widget activeLoanItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            child: ClipOval(),
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Collateral Value",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Rs.1,000,00",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 70,
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                               // co: appTheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Pay Now",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentTransactionItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 60,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "29 June 2020",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "UPI/02568/vikas@okicici",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text('Rs. 1000'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Cr'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
