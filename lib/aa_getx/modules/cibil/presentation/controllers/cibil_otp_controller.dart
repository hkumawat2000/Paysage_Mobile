import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CibilOtpController extends GetxController{
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = true.obs;
  final TextEditingController otpTextController = TextEditingController();
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;


}