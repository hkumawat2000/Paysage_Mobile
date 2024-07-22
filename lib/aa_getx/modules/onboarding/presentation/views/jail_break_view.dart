import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class JailBreakView extends GetView{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsImagePath.warning_notification, height: 80, width: 80),
            SizedBox(height: 100),
            headingText("Security Alert"),
            SizedBox(height: 10),
            Text(Strings.jailBreak_text, style: subHeading.copyWith(fontSize: 18), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}