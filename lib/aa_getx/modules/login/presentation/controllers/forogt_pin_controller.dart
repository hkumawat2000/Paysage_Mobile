import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/forgot_pin_usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_forgot_pin_usecase.dart';
import 'package:lms/util/Preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ForgotPinController extends GetxController with CodeAutoFill {
  final ForgotPinUsecase _forgotPinUsecase;
  final VerifyForgotPinUsecase _verifyForgotPinUsecase;
  final ConnectionInfo _connectionInfo;

  ForgotPinController(this._forgotPinUsecase, this._verifyForgotPinUsecase,
      this._connectionInfo);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController newPinController = TextEditingController();
  TextEditingController receivePinController = TextEditingController();
  Preferences _preferences = Preferences();
  RxBool receivePinVisible = true.obs;
  RxBool newPinVisible = true.obs;
  FocusNode newPinFocusNode = FocusNode();
  RxString emailID = "".obs;
  RxString mobileNumber = "".obs;
  RxString signature = "".obs;

  @override
  void onInit() {
    listenForCode();
    autoFetchPreferenceValues();
    super.onInit();
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    super.onClose();
  }

  @override
  void codeUpdated() {
    if (RegExp(r'^[0-9]+$').hasMatch(code!)) {
      receivePinController.text = code ?? "";
    }
  }

  void toChangePinVisibility() {
    newPinVisible.value = !newPinVisible.value;
  }

  void toChangeReceivePinVisibility() {
    receivePinVisible.value = !receivePinVisible.value;
  }

  void toRequestFocus(bool isNewPin) {
    if (newPinController.text.length == 4 && isNewPin) {
      //TODO : Request Focus
      //FocusScope.of(context).requestFocus(FocusNode());
    } else if (receivePinController.text.length == 4) {
      //TODO
      //FocusScope.of(context).requestFocus(newPinFocus);
    }
  }

  Future<void> autoFetchPreferenceValues() async {
    if (await _connectionInfo.isConnected) {
      emailID(await _preferences.getEmail());
      mobileNumber(await _preferences.getMobile());
      print('=====EMAIL===== > ${emailID.value}');
      if (emailID.value.isNotEmpty) {
        requestForgotOtp(emailID.value);
      } else {
        print('EMAIL not found');
        //TODO Call Common Dialog
        //commonDialog(context, Strings.something_went_wrong_try, 3);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> requestForgotOtp(String emailId) async {
    if (await _connectionInfo.isConnected) {
      //TODO : Add Loading Indicator
      ForgotPinRequestEntity forgotPinRequestDataEntity =
          ForgotPinRequestEntity(emailId: emailId);

      DataState<AuthLoginResponseEntity> response =
          await _forgotPinUsecase.call(
        ForgotPinOtpParams(
          forgotPinRequestEntity: forgotPinRequestDataEntity,
        ),
      );
      //TODO: TO add Get.back to pop loading
      if (response is DataSuccess) {
        showSnackBarWithMessage(scaffoldKey, Strings.forgot_pin_toast);
      } else if (response is DataFailed) {}
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> setPin() async {
    if (receivePinController.text.trim().length <= 3) {
      Utility.showToastMessage(Strings.invalid_received_pin);
    } else if (newPinController.text.trim().length <= 3) {
      Utility.showToastMessage(Strings.invalid_new_pin);
    } else {
      if (await _connectionInfo.isConnected) {
        //TODO
        //LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        VerifyForgotPinRequestEntity verifyForgotPinRequestDataEntity =
            VerifyForgotPinRequestEntity(
          email: emailID.value,
          otp: receivePinController.text.toString(),
          newPin: newPinController.text.toString(),
          retypePin: newPinController.text.toString(),
        );

        DataState<AuthLoginResponseEntity> response =
            await _verifyForgotPinUsecase.call(
          VerifyForgotPinOtpParams(
            verifyForgotPinRequestEntity: verifyForgotPinRequestDataEntity,
          ),
        );
        //TODO Get.back
        if (response is DataSuccess) {
          _preferences.setPin(newPinController.text);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobileNumber.value;
          parameter[Strings.email] = emailID.value;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.forgot_pin_success, parameter);

          Utility.showToastMessage(response.data!.message!);
          //TODO why is this used
          //Navigator.pop(context);
        } else if (response is DataFailed) {
          receivePinController.clear();
          Utility.showToastMessage(response.error!.message);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobileNumber.value;
          parameter[Strings.email] = emailID.value;
          parameter[Strings.error_message] = response.error!.message;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.forgot_pin_failed, parameter);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }
}
