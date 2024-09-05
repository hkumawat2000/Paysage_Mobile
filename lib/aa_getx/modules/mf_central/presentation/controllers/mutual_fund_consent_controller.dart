import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/usecases/mutual_fund_otp_send_usecase.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/views/mutual_fund_otp_view.dart';

import '../../../../core/constants/strings.dart';

class MutualFundConsentController extends GetxController {

  final ConnectionInfo _connectionInfo;
  final MutualFundOtpSendUsecase mutualFundOtpSendUsecase;

  MutualFundConsentController(this._connectionInfo, this.mutualFundOtpSendUsecase);

  @override
  void onInit() {
    super.onInit();
  }

  getMfCentralOTP() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      DataState<MutualFundSendOtpResponseEntity> response = await mutualFundOtpSendUsecase.call();
      Get.back();
      if (response is DataSuccess) {
        MutualFundSendOtpDataEntity mutualFundSendOtpDataEntity
        = response.data!.mutualFundSendOtpData!;
        Get.bottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          isDismissible: false,
          isScrollControlled: true,
          MutualFundOtpView(mutualFundSendOtpDataEntity),
        );
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}