import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  static double screenWidth = Get.width;
  static double screenHeight = Get.height;
  static double statusBarHeight = Get.statusBarHeight;
  // static double bottomNotchHeight = Get.bottomBarHeight;
  static double bottomNotchHeight = MediaQuery.of(Get.context!).padding.bottom;

 
}
