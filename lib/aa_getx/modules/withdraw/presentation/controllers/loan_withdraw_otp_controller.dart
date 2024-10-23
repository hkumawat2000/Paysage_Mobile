import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/create_withdraw_request_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/request_loan_withdraw_otp_usecase.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoanWithdrawOtpController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final CreateWithdrawRequestUsecase _createWithdrawRequestUsecase;
  final GetLoanWithdrawOTPUsecase _getLoanWithdrawOTPUsecase;

  LoanWithdrawOtpController(this._connectionInfo,
      this._createWithdrawRequestUsecase, this._getLoanWithdrawOTPUsecase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  RxInt start = 120.obs;
  String? otpValue;
  Preferences _preferences = Preferences();
  String? mobileExist, firebase_token;
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = true.obs;
  RxBool retryAvailable = false.obs;
  final TextEditingController otpTextController = TextEditingController();

  @override
  void onInit() {
    initSmsListener();
    startTime();
    super.onInit();
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();

    super.onClose();
  }

  Future<void> initSmsListener() async {
    String signature = await SmsAutoFill().getAppSignature;
    print("signature ==> $signature");
  }

  Future startTime() async {
    isResendOTPClickable.value = false;
    start.value = 120;

    Timer.periodic(const Duration(seconds: 1), (_timer) {
      start--;
      if (start.value == 0) {
        _timer.cancel();
        isResendOTPClickable.value = true;
      }
    });
  }

  String get timerString {
    Duration duration = Duration(seconds: start.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future<void> createWithdrawRequest(
      String bankAccountHolderName, amount, loanName) async {
    if (await _connectionInfo.isConnected) {
      var bankName;
      String? mobile = await _preferences.getMobile();
      String? email = await _preferences.getEmail();

      if (bankAccountHolderName.isNotEmpty) {
        bankName = bankAccountHolderName;
      } else {
        bankName = "";
      }

      if (otpValue!.isEmpty) {
        Utility.showToastMessage(Strings.message_valid_OTP);
      } else if (otpValue!.length < 4) {
        Utility.showToastMessage(Strings.message_valid_OTP);
      } else {
        showDialogLoading(Strings.please_wait);
        WithdrawOtpRequestEntity withdrawOtpRequestEntity =
            WithdrawOtpRequestEntity(
          loanName: loanName,
          bankAccountName: bankName,
          amount: amount,
          otp: otpValue!,
        );

        DataState<CommonResponseEntity> response =
            await _createWithdrawRequestUsecase.call(
          CreateWithdrawRequestParams(
            createWithdrawRequestDataEntity: withdrawOtpRequestEntity,
          ),
        );
        Get.back();
        if (response is DataSuccess) {
          retryAvailable.value = false;
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = loanName;
          parameter[Strings.withdraw_amount] = amount;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.withdraw_success, parameter);

          Utility.showToastMessage(Strings.payment_successful);

//TODO Navigate to Success screen
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => LoanWithdrawSuccess(
          //             value.data!.loanTransactionName!,
          //             widget.amount,
          //             value.message!)));
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            otpTextController.clear();
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = loanName;
            parameter[Strings.withdraw_amount] = amount;
            parameter[Strings.error_message] = response.error!.message;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.withdraw_failed, parameter);

            Utility.showToastMessage(response.error!.message);
          }
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> resendOtpClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        otpTextController.clear();
        requestWithdrawOtpOnRetry();
        start.value = 120;
        retryAvailable.value = false;
        isResendOTPClickable.value = true;
      } else {
        showSnackBar(scaffoldKey);
      }
    });
  }

  Future<void> requestWithdrawOtpOnRetry() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      DataState<CommonResponseEntity> response =
          await _getLoanWithdrawOTPUsecase.call();
      Get.back();
      if (response is DataSuccess) {
        Utility.showToastMessage(Strings.otp_sent_success);
        startTime();
      } else if (response is DataFailed) {
        if(response.error!.statusCode == 403){
          commonDialog(Strings.session_timeout, 4);
        }else{
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
