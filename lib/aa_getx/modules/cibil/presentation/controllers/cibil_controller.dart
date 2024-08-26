import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_send_otp_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_otp_view.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_result_view.dart';

class CibilController extends GetxController {
  final ConnectionInfo _connectionInfo;

  CibilArgs cibilArgs = Get.arguments;
  String? cibilScore;
  String? hitID;
  String? cibilScoreDate;
  String emptyStr = "";

  final CibilSendOtpUsecase cibilSendOtpUsecase;

  CibilController(this._connectionInfo, this.cibilSendOtpUsecase);


  @override
  void onInit() {
    getArgumentData();
    super.onInit();
  }

  getArgumentData(){
    cibilScore = cibilArgs.cibilScore!;
    cibilScoreDate = cibilArgs.cibilScoreDate!;
    hitID = cibilArgs.hitId!;
    print("Hit ID ====>> $hitID");
    // if(hitID!.isNotEmpty){
    //   Get.offNamed(cibilResultView, arguments: CibilResultArgs(
    //     hitId: hitID,
    //     cibilScore: cibilScore,
    //     cibilScoreDate: cibilScoreDate
    //   ));
    // }
  }

  Future<void> cibilCheckOTPApi() async {
    if (await _connectionInfo.isConnected) {
      DataState<CibilSendOtpResponseEntity> response = await cibilSendOtpUsecase.call();
      if (response is DataSuccess) {
        if (response.data!.cibilOtpDataEntity != null) {
          if(response.data!.cibilOtpDataEntity!.otpGenerationStatus == "1"){
            Get.bottomSheet(
              backgroundColor: Colors.transparent,
              enableDrag: false,
              isDismissible: false,
              isScrollControlled: true,
              CibilOtpView(
                hitID,
                cibilScore,
                response.data!.cibilOtpDataEntity!.stdOneHitID!,
                response.data!.cibilOtpDataEntity!.stdTwoHitId!,
              ),
            );
          } else {
            Utility.showToastMessage(response.data!.cibilOtpDataEntity!.errorMessage!);
          }
        }
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

}

class CibilArgs {
  String? hitId;
  String? cibilScore;
  String? cibilScoreDate;

  CibilArgs({this.hitId, this.cibilScore, this.cibilScoreDate});
}