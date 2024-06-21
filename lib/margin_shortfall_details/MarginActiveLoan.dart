import 'package:lms/margin_shortfall_details/MarginActiveLoanDetails.dart';
import 'package:lms/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MarginShortFallScreen.dart';

class MarginActiveLoan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarginActiveLoanState();
  }
}

class MarginActiveLoanState extends State<MarginActiveLoan> with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            elevation: 5,
            child: Container(
              width: double.infinity,
              height: 280,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      color: appTheme, //remove color to make it transpatent
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
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Margin Shortfall",
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info_outline,color: Colors.blue,),
                                      iconSize: 15,
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext bc) {
                                              return CustomBottom();
                                            });
                                      },
                                    ),
                                  ],
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
                                      backgroundColor: appTheme,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext bc) {
                                            return CustomBottomLoanTakeAction();
                                          });
                                    },
                                    child: Text(
                                      "Take Action",
                                      style: TextStyle(fontSize: 8, color: Colors.white),
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
            child: Card(
              elevation: 5,
              child: Container(
                height: 100,
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
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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

class CustomBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 260,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.account_balance,
                  size: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Required collateral value"),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Rs.7,80,000"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Required collateral value"),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Rs.7,50,000"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Shortfall"),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Rs.30,000"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 120,
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomLoanTakeAction extends StatefulWidget {
  @override
  CustomBottomLoanTakeActionState createState() => new CustomBottomLoanTakeActionState();
}

class CustomBottomLoanTakeActionState extends State<CustomBottomLoanTakeAction> {
  String radioItem = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 300,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Select Account",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RadioListTile(
                  groupValue: radioItem,
                  title: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Account no.SPA1234",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Rs.15,000",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  value: 'Item 1',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RadioListTile(
                  groupValue: radioItem,
                  title: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Account no.SPA1234",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Rs.15,000",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  value: 'Item 2',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 200,
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => MarginActiveLoanDetails()));
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
