import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:flutter/material.dart';

class ThankYouScreen extends StatefulWidget {
  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FE),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              Image(
                image: AssetImage(AssetsImagePath.tutorial_1),
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(height: 30),
              Text(Strings.thank_you, style: TextStyle(color: appTheme,fontWeight: FontWeight.bold,fontSize: 22)),
              SizedBox(height: 5),
              Text(
                Strings.shortly_touch,
                style:
                    TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                height: 45,
                width: 120,
                child: Material(
                  color: Color(0xFFF8F9FE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: red)),
                  elevation: 1.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: red)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DashBoard()));
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(color: red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return onBackPressDialog(0,Strings.back_btn_disable);
        },
    );
  }
}