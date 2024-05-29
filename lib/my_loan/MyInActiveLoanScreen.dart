import 'package:lms/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInActiveLoanScreen extends StatefulWidget{
  @override
  MyInActiveLoanScreenState createState() => MyInActiveLoanScreenState();

}

class MyInActiveLoanScreenState extends State<MyInActiveLoanScreen>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: colorBg,
    body: Column(
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Text(
                'Loans(2)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(child: recentTransactionList())
      ],
    ),
  );
  }

  Widget recentTransactionList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return recentTransactionItem();
      },
    );
  }

  Widget recentTransactionItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Acc No.",
                          style:
                          TextStyle(fontSize: 12, color: appTheme),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "SPA1234",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black,fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sanctioned Limit",
                          style:
                          TextStyle(fontSize: 12, color: appTheme),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "₹ 1,00,000",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black,fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.filter_frames,
                            color: appTheme,
                            size: 15,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
//                        Container(
//                          padding: const EdgeInsets.all(5),
//                          color: Colors.red.shade50,
//                          child: Text('Cr'),
//                        ),
//                        SizedBox(
//                          width: 10,
//                        ),
//                        Text('Rs. 1000'),
                      ],
                    )
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