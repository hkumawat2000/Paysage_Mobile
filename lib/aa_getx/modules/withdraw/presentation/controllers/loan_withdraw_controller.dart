import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/get_withdraw_details_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/request_loan_withdraw_otp_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/arguments/loan_withdraw_arguments.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/views/loan_withdraw_otp_view.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';

class LoanWithdrawController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final GetWithdrawDetailsUsecase _getWithdrawDetailsUsecase;
  final GetLoanWithdrawOTPUsecase _getLoanWithdrawOTPUsecase;
  LoanWithdrawController(this._connectionInfo, this._getWithdrawDetailsUsecase,
      this._getLoanWithdrawOTPUsecase);

  RxBool isSubmitBtnClickable = true.obs;
  RxBool isLoanDataAvailable = false.obs;
  RxDouble availableAmount = 0.0.obs;
  RxDouble loanBalance = 0.0.obs;
  RxString drawingPower = "".obs;
  RxString bankName = "".obs;
  RxString accountNumber = "".obs;
  RxString bankAccountName = "".obs;

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController amountController = new TextEditingController();
  TextEditingController? bankAccController = new TextEditingController();

  LoanWithdrawArguments loanWithdrawArguments = Get.arguments;

  Rx<LoanWithDrawDetailDataResponseEntity>
      loanWithDrawDetailDataResponseEntity =
      LoanWithDrawDetailDataResponseEntity().obs;

  Preferences preferences = Preferences();

  @override
  void onInit() {
    getLoanWithdrawDetails();
    super.onInit();
  }

  Future<void> getLoanWithdrawDetails() async {
    if (await _connectionInfo.isConnected) {
      WithdrawLoanDetailsRequestEntity withdrawLoanDetailsRequestDataEntity =
          WithdrawLoanDetailsRequestEntity(
        loanName: loanWithdrawArguments.loanName,
      );

      DataState<LoanWithdrawResponseEntity> response =
          await _getWithdrawDetailsUsecase.call(
        GetWithdrawParams(
            withdrawLoanDetailsRequestEntity:
                withdrawLoanDetailsRequestDataEntity),
      );
      isLoanDataAvailable(true);
      if (response is DataSuccess) {
        if (response.data!.loanWithDrawDetailDataResponseEntity != null) {
          loanWithDrawDetailDataResponseEntity.value = response.data!.loanWithDrawDetailDataResponseEntity!;
          availableAmount.value = roundDouble(response.data!.loanWithDrawDetailDataResponseEntity!.loanDataResponseEntity!.amountAvailableForWithdrawal!.toDouble(), 2);
          loanBalance.value = response.data!.loanWithDrawDetailDataResponseEntity!.loanDataResponseEntity!.balance!.toDouble();
          drawingPower.value = response.data!.loanWithDrawDetailDataResponseEntity!.loanDataResponseEntity!.drawingPowerStr.toString();

          if (response.data!.loanWithDrawDetailDataResponseEntity!.banks != null && response.data!.loanWithDrawDetailDataResponseEntity!.banks!.length != 0) {
            bankName.value = response.data!.loanWithDrawDetailDataResponseEntity!.banks![0].bank!;
            accountNumber.value = response.data!.loanWithDrawDetailDataResponseEntity!.banks![0].accountNumber!;
            bankAccountName.value = response.data!.loanWithDrawDetailDataResponseEntity!.banks![0].name!;
          }
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> requestLoanwithdrawOtp() async {
    if (await _connectionInfo.isConnected) {
      String? mobile = await preferences.getMobile();
      String email = await preferences.getEmail();
      if (amountController.text.isEmpty) {
        Utility.showToastMessage(Strings.enter_amount);
      } else if (double.parse(amountController.value.text) >
          availableAmount.toDouble()) {
        Utility.showToastMessage(
            "Amount should be less than ${availableAmount}");
      } else {
        showDialogLoading(Strings.please_wait);
        DataState<CommonResponseEntity> response =
            await _getLoanWithdrawOTPUsecase.call();
        Get.back();

        if (response is DataSuccess) {
          Utility.showToastMessage(response.data!.message!);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = loanWithdrawArguments.loanName;
          parameter[Strings.withdraw_amount] = amountController.text.toString();
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.withdraw_otp_sent, parameter);
          Get.bottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            LoanWithdrawOtpView(
              loanName: loanWithdrawArguments.loanName,
              amount: amountController.text,
              bankAccountName: bankAccountName.value,
              accountNumber: accountNumber.value,
            ),
          );
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(response.error!.message);
          }
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
