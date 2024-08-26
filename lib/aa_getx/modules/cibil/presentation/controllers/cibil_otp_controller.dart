import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_otp_verification_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';

class CibilOtpController extends GetxController{
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = false.obs;
  final TextEditingController otpTextController = TextEditingController();
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;

  final CibilOtpVerificationUsecase cibilOtpVerificationUsecase;

  CibilOtpController(this.cibilOtpVerificationUsecase);

  otpVerify(String stdOneId, String stdTwoId) async {
    DataState<CibilOtpVerificationResponseEntity> response =
    await cibilOtpVerificationUsecase.call(
      CibilOtpVerificationParams(
        cibilOtpVerificationRequestEntity: CibilOtpVerificationRequestEntity(
          oneID: stdOneId,
          twoId: stdTwoId,
          otp: otpTextController.text.toString(),
          type: "CUSTOM",
        ),
      ),
    );

    if (response is DataSuccess) {
      if (response.data!.otpVerityDataEntity != null) {
        Get.offNamed(cibilResultView,
            arguments: CibilResultArgs(
              hitId: stdOneId,
              cibilScore: response.data!.otpVerityDataEntity!.cibilScore!.toString(),
              cibilScoreDate: response.data!.otpVerityDataEntity!.cibilScoreDate!.toString(),
            )
        );
      }
    } else if (response is DataFailed) {
      Utility.showToastMessage(response.error!.message);
    }
  }

}