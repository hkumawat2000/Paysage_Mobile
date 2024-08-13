import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/pledge_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/request_pledge_otp_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_pledge_otp_controller.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/margin_shortfall_pledge_otp_view.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';

class MarginShortfallEligibleDialogController extends GetxController{
  final loanApplicationBloc = LoanApplicationBloc();
  Preferences preferences = new Preferences();
  MarginShortfallEligibleArguments pageArguments = Get.arguments;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final ConnectionInfo _connectionInfo;
  final RequestPledgeOtpUseCase _requestPledgeOtpUseCase;

  MarginShortfallEligibleDialogController(this._connectionInfo, this._requestPledgeOtpUseCase);

  void pledgeOTP() async {
    if(await _connectionInfo.isConnected){
      showDialogLoading(Strings.please_wait);
      PledgeOTPRequestEntity pledgeOTPRequestEntity = PledgeOTPRequestEntity(instrumentType: pageArguments.loanType);
      DataState<CommonResponseEntity> response = await _requestPledgeOtpUseCase.call(PledgeOtpParams(pledgeOTPRequestEntity: pledgeOTPRequestEntity));
      Get.back();
      if(response is DataSuccess){
        if(response.data != null){
          Utility.showToastMessage(Strings.success_otp_sent);
          if(pageArguments.loanType == Strings.shares){
            Get.bottomSheet(MarginShortfallPledgeOTPView(),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                settings: RouteSettings(
                    arguments: MarginShortfallPledgeOtpArguments(
                        cartName: pageArguments.cartName,
                        fileId: pageArguments.fileId,
                        pledgorBoid: pageArguments.pledgorBoid,
                        instrumentType: pageArguments.loanType)));
          } else {
            ///todo: add LoanOTPVerification screen in bottomSheet after completed
            // showModalBottomSheet(
            //     backgroundColor: Colors.transparent,
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (BuildContext bc) {
            //       return LoanOTPVerification(pageArguments.cartName,pageArguments.fileId, "", pageArguments.loanType, "", pageArguments.loanName);
            //     });
          }
        }
      } else if(response is DataFailed){
        if (response.error!.statusCode! == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}

class MarginShortfallEligibleArguments{
  String? cartName,fileId,pledgorBoid,loanName, loanType;
  double? eligibleLoan, selectedSecuritiesValue;

  MarginShortfallEligibleArguments(
  {required this.cartName,required  this.fileId,required  this.pledgorBoid,required  this.loanName,
    required this.loanType,required  this.eligibleLoan, required this.selectedSecuritiesValue});
}