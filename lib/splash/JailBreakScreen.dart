import 'package:choice/common_widgets/constants.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class JailBreakScreen extends StatelessWidget {
  const JailBreakScreen({Key? key}) : super(key: key);

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