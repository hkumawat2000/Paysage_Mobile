import 'package:lms/margin_shortfall_details/MarginActiveLoanDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarginInActiveLoan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarginInActiveLoanState();
  }
}

class MarginInActiveLoanState extends State<MarginInActiveLoan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Text(
                "Loans",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Expanded(child: activeLoanList()),
      ],
    );
  }

  Widget activeLoanList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
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
            child: Container(
//              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Loan Account no.\n SPA1234",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Overdraft Balance",
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Rs.1,000,00",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Text(
                    "View loan statement",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => MarginActiveLoanDetails()));
            },
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
