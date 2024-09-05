import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/request/fetch_mutual_fund_request_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/usecases/mutual_fund_fetch_usecase.dart';

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
  final MutualFundFetchUsecase mutualFundFetchUsecase;

  MutualFundOtpController(this._connectionInfo, this.mutualFundFetchUsecase);

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
      DataState<FetchMutualFundResponseEntity> response = await mutualFundFetchUsecase.call(
          FetchMutualFundParams(
              fetchMutualFundRequestEntity: FetchMutualFundRequestEntity(
                otp: mfOtpTextController.text.toString(),
                reqId: mutualFundSendOtpDataEntity.reqId,
                otpRef: mutualFundSendOtpDataEntity.otpRef,
                userSubjectReference: mutualFundSendOtpDataEntity.userSubjectReference,
                clientRefno: mutualFundSendOtpDataEntity.clientRefNo,
              )
          )
      );
      Get.back();
      if (response is DataSuccess) {
        List<FetchMutualFundResponseDataEntity> fetchMutualFundResponseData
        = response.data!.fetchMutualFundResponseData!;
      Get.offNamed(fetchMutualFundView, arguments: fetchMutualFundResponseData);
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}