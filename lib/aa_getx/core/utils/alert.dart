import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';

class Alert{

  static showSnackBar({required String title, String? description, Widget? icon}){
    Get.snackbar(
      title,
      description ?? "",
      colorText: colorWhite,
      backgroundColor: colorBlue,
      icon: icon,
    );
  }

  static showErrorSnackBar({required String title, String? description, Widget? icon}){
    Get.snackbar(
      title,
      description ?? "",
      colorText: colorWhite,
      backgroundColor: colorSnackBarErrorBorder,
      icon: icon,
    );
  }

}