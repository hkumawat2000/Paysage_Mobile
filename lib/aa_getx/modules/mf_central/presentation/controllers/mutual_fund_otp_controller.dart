import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/utility.dart';

class MutualFundOtpController extends GetxController {
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = false.obs;
  late TextEditingController mfOtpTextController;
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;
  final ConnectionInfo _connectionInfo;

  MutualFundOtpController(this._connectionInfo);

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

  submitOTP(MutualFundSendOtpDataEntity mutualFundSendOtpDataEntity) async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      // DataState<MutualFundSendOtpResponseEntity> response = await mutualFundOtpSendUsecase.call();
      Get.back();
      // if (response is DataSuccess) {
      //   MutualFundSendOtpDataEntity mutualFundSendOtpDataEntity
      //   = response.data!.mutualFundSendOtpData!;
      //   Get.bottomSheet(
      //     backgroundColor: Colors.transparent,
      //     enableDrag: false,
      //     isDismissible: false,
      //     isScrollControlled: true,
      //     MutualFundOtpView(mutualFundSendOtpDataEntity),
      //   );
      // } else if (response is DataFailed) {
      //   Utility.showToastMessage(response.error!.message);
      // }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}