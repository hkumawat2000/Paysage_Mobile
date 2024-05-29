import 'package:lms/common_widgets/constants.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class OfflineCustomerScreen extends StatefulWidget {
  const OfflineCustomerScreen({Key? key}) : super(key: key);

  @override
  State<OfflineCustomerScreen> createState() => _OfflineCustomerScreenState();
}

class _OfflineCustomerScreenState extends State<OfflineCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsImagePath.app_icon, height: 80, width: 80),
              SizedBox(height: 60),
              // headingText("Under process"),
              Center(
                child: Text("Your loan application is under process.",
                    style: subHeading.copyWith(fontSize: 18), textAlign: TextAlign.center),
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
      builder: (BuildContext context) => onBackPressDialog(1,Strings.exit_app),
    ) ?? false;
  }

}
