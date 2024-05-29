import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class ApplicationSuccess extends StatefulWidget{
  String loanNo;
  @override
  ApplicationSuccessState createState() => ApplicationSuccessState();
  ApplicationSuccess(this.loanNo);
}

class ApplicationSuccessState extends State<ApplicationSuccess> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: SingleChildScrollView(
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
                  largeHeadingText(Strings.thank_you),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Strings.application_success_text,
                    style: mediumTextStyle_14_gray,
                  ),
                  SizedBox(
                    height: 5,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Application Number", style: mediumTextStyle_14_gray),
                              SizedBox(height: 5),
                              Text(widget.loanNo, style: semiBoldTextStyle_18_gray_dark),
                              SizedBox(height: 15,),
//                        Text("Note", style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                        SizedBox(height: 5),
//                        Text("We'll notify you once the OD limit is", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//                        Text("approved by the banking partner", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 140,
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
                              style: TextStyle(color: red),
                            ),
                          ),
                        ),
                      ),
//                SizedBox(
//                  width: 15,
//                ),
//                Container(
//                  height: 45,
//                  width: 145,
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
//                        style: TextStyle(color: Colors.white),
//                      ),
//                    ),
//                  ),
//                )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return onBackPressDialog(0, Strings.back_btn_disable);
      },
    );
  }
}