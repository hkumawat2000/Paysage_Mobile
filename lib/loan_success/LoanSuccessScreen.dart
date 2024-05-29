
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';

class LoanSuccessScreen extends StatefulWidget {
  String loanNo;
  @override
  _LoanSuccessScreenState createState() => _LoanSuccessScreenState();
  LoanSuccessScreen(this.loanNo);
}

class _LoanSuccessScreenState extends State<LoanSuccessScreen> {
  Preferences preferences = new Preferences();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                colors: [const Color(0xFFFEFEFE), const Color(0xFFFEFEFE)],
//              ),
            ),
            child: ListView(children: <Widget>[
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 60,
                      ),
                      onPressed: () {}),
                  SizedBox(
                    height: 40,
                  ),
                  Text(Strings.loan_success,
                      style: TextStyle(fontSize: 13)),
                  Text(Strings.success_received,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Application Number : ",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey)),
                      Text(widget.loanNo, style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text("Note:",
                      style:
                      TextStyle(fontSize: 15, color: Colors.black)),
                  Text(
                      "We Shall notify you once the OD limit is \napproved by our bank partner",
                      style:
                      TextStyle(fontSize: 15, color: Colors.black)),
                  SizedBox(height: 60),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 170,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: red)),
                          elevation: 1.0,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              // preferences.setESign(false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
                            },
                            child: Text(
                              'Go to Home',
                              style: TextStyle(color: red, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 45,
                        width: 170,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {},
                            child: Text(
                              'Track Application',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),

            ])));

//    return Scaffold(
//        body: Column(
//      children: <Widget>[
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            IconButton(
//                icon: Icon(
//                  Icons.arrow_back_ios,
//                  color: Colors.black,
//                  size: 15,
//                ),
//                onPressed: () {}),
//          ],
//        ),
//        SizedBox(height: 20),
//        Container(
//          alignment: Alignment.center,
//          height: MediaQuery.of(context).size.height / 4,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              IconButton(
//                  icon: Icon(
//                    Icons.check_circle,
//                    color: Colors.black,
//                    size: 30,
//                  ),
//                  onPressed: () {}),
//            ],
//          ),
//        ),
//        Column(
//          children: <Widget>[
//            Text(Strings.loan_success, style: TextStyle(fontSize: 12)),
//            Text(Strings.success_received,
//                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//            SizedBox(height: 20),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text("Application Number : ",
//                    style: TextStyle(fontSize: 12, color: Colors.grey)),
//                Text("25458795", style: TextStyle(fontSize: 12)),
//              ],
//            ),
//            SizedBox(height: 20),
//            Text("Note:", style: TextStyle(fontSize: 12)),
//            Text(
//                "We Shall notify you once the OD limit is approved by our bank partner",
//                style: TextStyle(fontSize: 12)),
//            SizedBox(height: 20),
//          ],
//        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 20),
//              height: 45,
//              //width: 150,
//              child: Material(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(35)),
//                elevation: 1.0,
//                color: Colors.grey.shade400,
//                child: MaterialButton(
//                  //minWidth: MediaQuery.of(context).size.width,
//                  onPressed: () async {},
//                  child: Text(
//                    "Go to Home",
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 15),
//              height: 45,
//              //width: 150,
//              child: Material(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(35)),
//                elevation: 1.0,
//                color: appTheme,
//                child: MaterialButton(
//                  //minWidth: MediaQuery.of(context).size.width,
//                  onPressed: () async {},
//                  child: Text(
//                    "Track Application",
//                    style: TextStyle(
//                        color: Colors.white, fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//        SizedBox(height: 10),
//      ],
//    ));
  }
}
