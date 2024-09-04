import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MutualFundOtpController extends GetxController {
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = false.obs;
  late TextEditingController mfOtpTextController;
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;

  @override
  void onInit() {
    mfOtpTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    mfOtpTextController.dispose();
    super.dispose();
  }

}