
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/controllers/enable_fingerprint_dialog_controller.dart';

/// todo EnableFingerPrintDialog(this.isForOfflineCustomer, this.isLoanOpen);
class EnableFingerPrintDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    EnableFingerPrintController controller = EnableFingerPrintController();
    return Scaffold(
      key: controller.scaffoldKey,
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
            child: setFingerPrintBody(controller),
          ),
        ),
      ),
    );
  }

  setFingerPrintBody(EnableFingerPrintController controller){
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
                  minWidth: Get.width,
                  onPressed: ()=> controller.enableClicked(),
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
                  minWidth: Get.width,
                  onPressed: ()=> controller.skipClicked(),
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
