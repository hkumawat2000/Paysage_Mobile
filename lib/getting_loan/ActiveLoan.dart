import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveLoan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActiveLoanState();
  }
}

class ActiveLoanState extends State<ActiveLoan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15),
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.blueAccent, //remove color to make it transpatent
                  border: Border.all(style: BorderStyle.solid, color: Colors.white),
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Total Active Loans",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
//                      height: MediaQuery.of(context).size.height / 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Collateral Value"),
                          ),
                          Expanded(
                            child: Text("Rs.4,30,000"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Interest due amount \n(3rd March 2020)",
                            ),
                          ),
                          Expanded(
                            child: Text("Rs.4,30,000"),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Pay Now",
                                  style: TextStyle(fontSize: 9, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text("Margin Shortfall"),
                          ),
                          Expanded(
                            child: Text("Rs.4,30,000"),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Take Action",
                                  style: TextStyle(fontSize: 9, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
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
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
