
import 'package:lms/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SuccessDownloadEmailView extends StatefulWidget {
  @override
  SucessDownloadEmailViewState createState() => new SucessDownloadEmailViewState();
}

class SucessDownloadEmailViewState extends State<SuccessDownloadEmailView>
    with TickerProviderStateMixin {
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
    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 250,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: appTheme,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Download Success',
                style:
                    TextStyle(color: appTheme, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
