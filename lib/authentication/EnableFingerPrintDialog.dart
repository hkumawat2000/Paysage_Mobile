import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/welcome/NewWelcomeScreen.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../registration/OfflineCustomerScreen.dart';

class EnableFingerPrintDialog extends StatefulWidget {
  bool isForOfflineCustomer;
  int isLoanOpen;

  EnableFingerPrintDialog(this.isForOfflineCustomer, this.isLoanOpen);

  @override
  EnableFingerPrintDialogState createState() => EnableFingerPrintDialogState();
}

class EnableFingerPrintDialogState extends State<EnableFingerPrintDialog>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Utility utility = Utility();
  Preferences preferences = Preferences();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  List<BiometricType> availableBuimetricType = <BiometricType>[];
  var isFingerSupport = false;
  AnimationController? controller;

  @override
  void initState() {
    isFingerPrintSupport();
    _getAvailableSupport();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    super.initState();
  }

  Future<void> isFingerPrintSupport() async {
    isFingerSupport = await utility.getBiometricsSupport();
  }

  Future<void> _getAvailableSupport() async {
    try {
      availableBuimetricType = await _localAuthentication.getAvailableBiometrics();
      printLog("availableBuimetricType ==> $availableBuimetricType");
    } catch (e) {
      printLog(e.toString());
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            color: colorBg,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: SingleChildScrollView(
            child: setFingerPrintBody(),
          ),
        ),
      ),
    );
  }

  setFingerPrintBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Text(Strings.enable_biometric, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appTheme)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Strings.biometric_msg),
            ],
          ),
        ),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 45,
              width: 200,
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 1.0,
                color: appTheme,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (availableBuimetricType.isEmpty) {
                      showSnackBarWithMessage(_scaffoldKey, Strings.biometric_alert_msg);
                    } else {
                      if (isFingerSupport) {
                        firebaseEvent("Biometric_Set", {'Set': true});
                        preferences.setFingerprintEnable(true);
                        preferences.setFingerprintConsent(true);
                        if(widget.isForOfflineCustomer && widget.isLoanOpen == 0){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => RegistrationSuccessfulScreen()));
                        }
                      } else {
                        showSnackBarWithMessage(_scaffoldKey, Strings.biometric_alert_msg);
                      }
                    }
                  },
                  child: Text(
                    Strings.enable,
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 45,
              width: 140,
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 1.0,
                color: appTheme,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    firebaseEvent("Biometric_Set", {'Set': false});
                    if(widget.isForOfflineCustomer && widget.isLoanOpen == 0){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (BuildContext context) => RegistrationSuccessfulScreen()));
                    }
                  },
                  child: Text(
                    Strings.skip,
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
