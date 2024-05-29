import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';

class ApplicationTopUpSuccess extends StatefulWidget{
  @override
  ApplicationTopUpSuccessState createState() => ApplicationTopUpSuccessState();
}

class ApplicationTopUpSuccessState extends State<ApplicationTopUpSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            //verifyEmail(),
            Image(
              image: AssetImage(AssetsImagePath.tutorial_4),
              height: 200.0,
              width: 200.0,
            ),
            Text(
              Strings.success_received,
              style: TextStyle(
                  color: appTheme,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Strings.top_up_success_text,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 11,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 3.0), // set border width
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Reference ID", style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                        SizedBox(height: 5),
                        Text("SP5667", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: 15,),

                      ]),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 130,
                  color: colorBg,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: red)),
                    elevation: 1.0,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => DashBoard()
                        ));
                      },
                      child: Text(
                        'Home',
                        style: TextStyle(color: red,fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                    ),
                  ),
                ),
//                SizedBox(
//                  width: 15,
//                ),
//                Container(
//                  height: 45,
//                  width: 125,
//                  child: Material(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(35)),
//                    elevation: 1.0,
//                    color: appTheme,
//                    child: MaterialButton(
//                      minWidth: MediaQuery.of(context).size.width,
//                      onPressed: () async {
//                      },
//                      child: Text(
//                        'Track',
//                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
//                      ),
//                    ),
//                  ),
//                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}