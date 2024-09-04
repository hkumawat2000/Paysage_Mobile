import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MutualFundOtpController extends GetxController {
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = false.obs;
  final TextEditingController otpTextController = TextEditingController();
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;

}