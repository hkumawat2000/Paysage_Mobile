

import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoanWithdrawSuccess extends StatefulWidget {
  String loanName, withdrawAmount,accountNumber;
  @override
  LoanWithdrawSuccessState createState() => new LoanWithdrawSuccessState();
  LoanWithdrawSuccess(this.loanName,this.withdrawAmount,this.accountNumber);
}

class LoanWithdrawSuccessState extends State<LoanWithdrawSuccess> with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

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
                    height: 40,
                  ),
                  Image(
                    image: AssetImage(AssetsImagePath.tutorial_4),
                    height: 200.0,
                    width: 200.0,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "₹ ${widget.withdrawAmount}",
                    style: TextStyle(
                        color: appTheme,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 10),
                    child: Text(
                      widget.accountNumber,
                      style: TextStyle(
                        color: colorLightGray,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
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
                              SizedBox(height: 10),
                              Text("Reference id", style: TextStyle(fontSize: 14, color: colorLightGray)),
                              SizedBox(height: 5),
                              Text("${widget.loanName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: colorDarkGray)),
                              SizedBox(height: 10,),
//                    Text("Note", style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                    SizedBox(height: 5),
//                    Text("We'll notify you once the OD limit is", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//                    Text("approved by the banking partner", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 45,
                    width: 145,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: appTheme,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => DashBoard()
                          ));
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: colorWhite,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
        return onBackPressDialog(0,Strings.back_btn_disable);
      },
    );
  }
}