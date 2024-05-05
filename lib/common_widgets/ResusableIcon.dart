import 'package:flutter/material.dart';

import 'constants.dart';

class ReusableIconTextContainerCard extends StatelessWidget {
  ReusableIconTextContainerCard(
      {required this.cardText, required this.cardIcon, required this.circleColor});
  final String cardText;
  final Image cardIcon;
  final Color circleColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: cardIcon,
            ),
            Text(
              cardText, style: subHeading
            ),
          ],
        ),
      ),
    );
  }
}
