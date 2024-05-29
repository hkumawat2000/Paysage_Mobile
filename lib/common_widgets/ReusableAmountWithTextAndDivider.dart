import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ReusableAmountWithTextAndDivider extends StatelessWidget {
  final String leftAmount;
  final String leftText;
  final String rightAmount;
  final String rightText;

  ReusableAmountWithTextAndDivider(
      {required this.leftAmount, required this.leftText, required this.rightAmount, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                subHeadingText(leftAmount),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(leftText, style: subHeading, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            height: 40.0,
            width: 0.5,
            color: Colors.grey,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                subHeadingText(rightAmount),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(rightText, style: subHeading, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
