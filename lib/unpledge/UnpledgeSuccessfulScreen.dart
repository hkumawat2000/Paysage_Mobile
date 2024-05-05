import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class UnpledgeSuccessfulScreen extends StatefulWidget {
  String loanType;
  UnpledgeSuccessfulScreen(this.loanType);

  @override
  UnpledgeSuccessfulScreenState createState() => UnpledgeSuccessfulScreenState();
}

class UnpledgeSuccessfulScreenState extends State<UnpledgeSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: colorBg,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            //verifyEmail(),
            Image(
              image: AssetImage(AssetsImagePath.tutorial_4),
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Strings.success_received,
              style: TextStyle(color: appTheme, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Text(widget.loanType == Strings.shares ? Strings.unpledge_success : Strings.revoke_success,
                style: TextStyle(
                  color: colorLightGray,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 130,
                    color: colorBg,
                    child: Material(
                      color: colorBg,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), side: BorderSide(color: red)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
                        },
                        child: Text(
                          Strings.home,
                          style: TextStyle(color: red),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => onBackPressDialog(0,Strings.back_btn_disable),
    ) ?? false;
  }
}
