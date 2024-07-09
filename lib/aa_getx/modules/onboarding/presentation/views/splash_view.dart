import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/controllers/splash_controller.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class SplashView extends GetView<SplashController> {

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
                child: Text('Version ${controller.versionName.value ?? ""}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}