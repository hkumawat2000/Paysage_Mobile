import 'dart:async';
import 'package:lms/login/LoginScreen.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/splash/JailBreakScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import '../util/strings.dart';
import 'TutorialScreen.dart';
import 'TutorialScreenBloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Preferences? preferences = Preferences();
  String? versionName;
  bool _jailBroken = false;
  TutorialScreenBloc tutorialScreenBloc = TutorialScreenBloc();


  @override
  void initState() {
    getVersionInfo();
    initPlatformState();
    startTime();
    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      _jailBroken = await SafeDevice.isJailBroken;
    } on PlatformException {
      _jailBroken = true;
    }
    if (!mounted){
      return;
    } else {
      setState(() {
      });
    }
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, autoLogin);
  }

  Future<void> getVersionInfo() async {
    String version = await Utility.getVersionInfo();
    setState(() {
      versionName = version;
    });
  }

  Future<void> autoLogin() async {
    String? mobileExist = await preferences!.getMobile();
    String emailExist = await preferences!.getEmail();
    String? isVisitTutorial = await preferences!.isVisitTutorial();

    if(_jailBroken){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => JailBreakScreen()));
    } else {
      if (mobileExist != null && emailExist != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => PinScreen(false)));
      } else {
        if (isVisitTutorial != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
        } else {
          getDetails();
        }
      }
    }
  }


  getDetails(){
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        tutorialScreenBloc.getOnBoardingData().then((value) {
          if (value.isSuccessFull!) {
            if (value.onBoardingData != null) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => TutorialScreen(value.onBoardingData!)));
            }
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 172,
                height: 141,
                child: Logo(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text('Version ${versionName ?? ""}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
