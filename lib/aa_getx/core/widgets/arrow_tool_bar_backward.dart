import 'package:flutter/material.dart';
import 'package:lms/util/AssetsImagePath.dart';

class ArrowToolbarBackwardNavigation extends StatelessWidget {
  const ArrowToolbarBackwardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImagePath.back_button,
      height: 30,
      width: 18,
      fit: BoxFit.fitHeight,
    );
  }
}