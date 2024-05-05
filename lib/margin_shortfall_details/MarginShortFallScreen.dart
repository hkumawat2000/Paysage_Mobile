//import 'package:choice/pledgeSecurities/PledgeSecuritiesScreen.dart';
//import 'package:choice/util/Colors.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class MarginShortFallScreen extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => MarginShortFallScreenState();
//}
//
//class MarginShortFallScreenState extends State<MarginShortFallScreen> {
//  String radioItem = '';
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//          backgroundColor: Colors.grey.shade100,
//          body: Column(
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  IconButton(
//                    icon: Icon(
//                      Icons.chevron_left,
//                      size: 25.0,
//                    ),
//                    onPressed: () => Navigator.of(context).pop(),
//                  ),
//                ],
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 15, right: 15),
//                child: ListView(
//                  shrinkWrap: true,
//                  children: <Widget>[
//                    Text(
//                      "Margin ShortFall",
//                      style: TextStyle(
//                          color: AppColor.appTheme,
//                          fontSize: 20,
//                          fontWeight: FontWeight.bold),
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Row(
//                      children: <Widget>[
//                        Text(
//                          "Loan Account No.",
//                          style: TextStyle(
//                              color: AppColor.colorGrey, fontSize: 12),
//                        ),
//                        SizedBox(width: 5,),
//                        Text(
//                          "SPA1234",
//                          style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
//                        )
//                      ],
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Container(
//                      height: 45,
//                      width: 120,
//                      child: Material(
//                          shape: RoundedRectangleBorder(
//                              side: BorderSide(color: Colors.grey.shade100)),
//                          elevation: 1.0,
//                          child: Padding(
//                              padding: const EdgeInsets.all(10),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Text("Margin Shortfall"),
//                                  Text(
//                                    "Rs.15,000",
//                                    style: TextStyle(
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.bold),
//                                  )
//                                ],
//                              ))),
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Text(
//                      "There is margin shortfall in your account due to fall in collateral value. Its advisable to keep 10% buffer margin to avoid regular shortfalls",
//                      style: TextStyle(color: Colors.grey, fontSize: 13),
//                    ),
//                    SizedBox(
//                      height: 30,
//                    ),
//                    Text(
//                      "What would you like to do?",
//                      style: TextStyle(color: Colors.grey, fontSize: 13),
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    RadioListTile(
//                      groupValue: radioItem,
//                      title: Text(
//                        "Pledge more securities",
//                        style: TextStyle(
//                            fontSize: 14,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black),
//                      ),
//                      value: 'Item 1',
//                      onChanged: (val) {
//                        setState(() {
//                          radioItem = val;
//                        });
//                      },
//                    ),
//                    RadioListTile(
//                      groupValue: radioItem,
//                      title: Text(
//                        "Pay shortfall amount",
//                        style: TextStyle(
//                            fontSize: 14,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black),
//                      ),
//                      value: 'Item 1',
//                      onChanged: (val) {
//                        setState(() {
//                          radioItem = val;
//                        });
//                      },
//                    ),
//                    RadioListTile(
//                      groupValue: radioItem,
//                      title: Text(
//                        "Sell Collateral ---->>",
//                        style: TextStyle(
//                            fontSize: 14,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black),
//                      ),
//                      value: 'Item 1',
//                      onChanged: (val) {
//                        setState(() {
//                          radioItem = val;
//                        });
//                      },
//                    ),
//                    SizedBox(height: 60,),
//                    Container(
//                      height: 40,
//                      width: 80,
//                      child: Material(
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                        elevation: 1.0,
//                        color: AppColor.appTheme,
//                        child: MaterialButton(
//                          minWidth: MediaQuery.of(context).size.width,
//                          onPressed: () async {
//                            Navigator.push(context,
//                                MaterialPageRoute(builder: (BuildContext context) => PledgeSecuritiesScreen()));
//                          },
//                          child: Text("Next",style: TextStyle(color: Colors.white,),
//                          ),
//                        ),
//                      ),
//                    ),
//
//                  ],
//                ),
//              )
//            ],
//          )
//
//      ),
//    );
//  }
//}
