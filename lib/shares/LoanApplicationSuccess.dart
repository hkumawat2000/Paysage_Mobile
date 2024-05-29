import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../new_dashboard/NewDashboardScreen.dart';

class LoanApplicationSuccess extends StatefulWidget {
  String loanNo;
  String? loanFor;

  @override
  _LoanApplicationSuccessState createState() => _LoanApplicationSuccessState();

  LoanApplicationSuccess(this.loanNo, this.loanFor);
}

class _LoanApplicationSuccessState extends State<LoanApplicationSuccess> {
  Preferences preferences = new Preferences();

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: _onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                //verifyEmail(),
                Image(
                  image: AssetImage(AssetsImagePath.tutorial_4),
                  height: 265.0,
                  width: 265.0,
                ),
                Text("You are almost there!", style: extraBoldTextStyle_30, textAlign: TextAlign.center),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Text(
                    widget.loanFor == Strings.loanRenewal ? "Your loan renewal application has been successfully received and under approval by our lending partner.You shall receive a confirmation message shortly."
                        : "Your loan application has been successfully received and under approval by our lending partner.You shall receive a confirmation message shortly.",
                    style: mediumTextStyle_14_gray,
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
                    border: Border.all(color: Colors.white, width: 3.0),
                    // set border width
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
                          SizedBox(height: 10),
                          Text("Application Number",
                              style: mediumTextStyle_14_gray),
                          SizedBox(height: 5),
                          Text(widget.loanNo,
                              style: semiBoldTextStyle_18_gray_dark),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                        color: colorBg,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        elevation: 1.0,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (BuildContext context) => DashBoard()));
                          },
                          child: Text(
                            'Home',
                            style: buttonTextRed,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dottedLineWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: DottedLine(
        lineLength: 30,
        dashColor: appTheme,
        dashLength: 0.8,
      ),
    );
  }

  Widget inProgressWidget() {
    return ReusableProcessBar(
      processBarIcon: Icon(
        Icons.brightness_1,
        size: 10.0,
        color: appTheme,
      ),
    );
  }

  Widget checkedWidget() {
    return ReusableProcessCheckedBar(
      processBarIcon: Icon(
        Icons.check,
        size: 18.0,
        color: appTheme,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return onBackPressDialog(0,Strings.back_btn_disable);
      },
    ) ?? false;
  }
}
