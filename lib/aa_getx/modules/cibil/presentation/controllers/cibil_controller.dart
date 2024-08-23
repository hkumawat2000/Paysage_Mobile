import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_otp_view.dart';

class CibilController extends GetxController {
  final ConnectionInfo _connectionInfo;

  CibilController(this._connectionInfo);


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> cibilCheckOTPApi() async {
    if (await _connectionInfo.isConnected) {
      Get.bottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        CibilOtpView(),
      );
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }


}