import 'dart:io';

import 'package:lms/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarginActiveLoanDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarginActiveLoanDetailsState();
  }
}

class MarginActiveLoanDetailsState extends State<MarginActiveLoanDetails> {
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
            padding: const EdgeInsets.all(15.0),
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
                                  children: <Widget>[
                                    Text(
                                      "Rs." + "1,00,00",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Outstanding Limit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Rs." + "2,00,00",
                                      style: TextStyle(color: Colors.white),
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
                                  onPressed: () {},
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
                            Text("Statement"),
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
          Expanded(
            child: activeLoanList(),
          ),
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

  Widget activeLoanItem() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                            children: <Widget>[
                              Text(
                                "Collateral Value",
                                style: TextStyle(fontSize: 12, color: Colors.black),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appTheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Pay Now",
                                style: TextStyle(fontSize: 8, color: Colors.white),
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
}
