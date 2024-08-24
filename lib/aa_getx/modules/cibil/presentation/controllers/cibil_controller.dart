import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_otp_view.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_result_view.dart';

class CibilController extends GetxController {
  final ConnectionInfo _connectionInfo;

  CibilArgs cibilArgs = Get.arguments;
  String? cibilScore;
  String? hitID;
  String emptyStr = "";
  CibilController(this._connectionInfo);


  @override
  void onInit() {
    getArgumentData();
    super.onInit();
  }

  getArgumentData(){
    cibilScore = cibilArgs.cibilScore!;
    hitID = cibilArgs.hitId!;
    if(hitID!.isNotEmpty){
      Get.offNamed(cibilResultView, arguments: CibilResultArgs(
        hitId: hitID,
        cibilScore: cibilScore
      ));
    }
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

class CibilArgs {
  String? hitId;
  String? cibilScore;

  CibilArgs({this.hitId, this.cibilScore});
}