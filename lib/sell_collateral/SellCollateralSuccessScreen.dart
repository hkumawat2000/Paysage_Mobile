import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class SellCollateralSuccessScreen extends StatefulWidget {
  String loanType;

  SellCollateralSuccessScreen(this.loanType);

  @override
  _SellCollateralSuccessScreenState createState() => _SellCollateralSuccessScreenState();
}

class _SellCollateralSuccessScreenState extends State<SellCollateralSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: colorBg,
              height: 45,
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Material(
                color: colorBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(color: red)),
                elevation: 1.0,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: red)),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DashBoard()));
                  },
                  child: Text(
                    Strings.home,
                    style: buttonTextRed,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage(AssetsImagePath.tutorial_4),
                height: 265.0,
                width: 265.0,
              ),
              SizedBox(height: 14),
              Text(
                Strings.success_received,
                textAlign: TextAlign.center,
                style: boldTextStyle_30,
              ),
              SizedBox(height: 10),
              Text(
                widget.loanType == Strings.shares ? Strings.sell_collateral_success : Strings.invoke_success,
                textAlign: TextAlign.center,
                style: mediumTextStyle_14_gray,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return onBackPressDialog(0,Strings.back_btn_disable);
      },
    ) ?? false;
  }
}