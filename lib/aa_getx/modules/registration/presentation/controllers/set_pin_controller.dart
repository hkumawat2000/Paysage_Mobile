import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/set_pin_usecase.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:local_auth/local_auth.dart';

class SetPinController extends GetxController {
  Preferences preferences = new Preferences();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController confirmPinController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  //String errorMessage = "";
  //bool? isArrowVisible;
  FocusNode confirmPinFocus = FocusNode();
  RxBool pinVisible = true.obs;
  RxBool cnfPinVisible = true.obs;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;
  final SetPinUseCase setPinUseCase;
  final ConnectionInfo _connectionInfo;

  //SetPinArgs setPinArgs = Get.arguments; todo: uncomment this after previous pages are done and comment below line
  SetPinArgs setPinArgs = SetPinArgs(); //Get.arguments;
  SetPinController(this.setPinUseCase, this._connectionInfo);

  @override
  void onInit() {
    _getBiometricsSupport();
    super.onInit();
  }

  Future<void> _getBiometricsSupport() async {
    try {
      _hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
      debugPrint("hasFingerPrintSupport ==> $_hasFingerPrintSupport");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setPin() async {
    String email = await preferences.getEmail();
    String? mobile = await preferences.getMobile();
    if (pinController.text.length == 0) {
      Utility.showToastMessage(Strings.enter_pin);
    } else if (confirmPinController.text.length == 0) {
      Utility.showToastMessage(Strings.re_enter_pin);
    } else if (pinController.text != confirmPinController.text) {
      Utility.showToastMessage(Strings.confirm_enter_pin);
    } else if (pinController.text.length != 4 ||
        confirmPinController.text.length != 4) {
      Utility.showToastMessage(Strings.pin_length);
    } else {
      SetPinParams setPinParams = SetPinParams(pin: confirmPinController.text);
      // RegistrationBloc().setPin(confirmPinController.text).then((value) {
      if (await _connectionInfo.isConnected) {
        showDialogLoading(Strings.please_wait);
        DataState<AuthLoginResponseEntity> response =
            await setPinUseCase.call(setPinParams);
        Get.back(); //pop dialog
        debugPrint("response block");
        debugPrint("response   ${response.data}");
        if (response is DataSuccess) {
          if (response.data != null) {
            preferences.setPin(confirmPinController.text);
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.email] = email;
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.pin_set, parameter);
            if (_hasFingerPrintSupport) {
              Get.toNamed(
                fingerPrintView,
                arguments: SetPinArgs(
                  isLoanOpen: setPinArgs.isLoanOpen,
                  isForOfflineCustomer: setPinArgs.isForOfflineCustomer,
                ),
              );
            } else {
              if (setPinArgs.isForOfflineCustomer! &&
                  setPinArgs.isLoanOpen == 0) {
                Get.offAllNamed(offlineCustomerView);
              } else {
                Get.offNamed(registrationSuccessfulView);
              }
            }
          }
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
            debugPrint(
                "response.error!.statusCode  ${response.error!.statusCode}");
          } else {
            Utility.showToastMessage(response.error!.message);
            debugPrint("response.error!.message  ${response.error!.message}");
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
        debugPrint(
            "Strings.no_internet_message  ${Strings.no_internet_message}");
      }
    }
  }

  void changeCnfVisibility() {
    cnfPinVisible.value = !cnfPinVisible.value;
  }

  void changePinVisibility() {
    pinVisible.value = !pinVisible.value;
  }

  void unFocus(String text) {
    if (text.length == 4) {
      //FocusScope.of(context).requestFocus(FocusNode());
      Get.focusScope!.unfocus();
    }
  }

  String? validConfirmPin(String? val) {
    if (val!.isEmpty) {
      return null;
    } else if (val != pinController.text) return 'Pin Not Match';
    return null;
  }

  void focusToConfirmPin(String? text) {
    if (text!="" && text!.length == 4) {
      confirmPinFocus.requestFocus();
    }
  }
}

class SetPinArgs {
  bool? isForOfflineCustomer;
  int? isLoanOpen;

  SetPinArgs({this.isForOfflineCustomer, this.isLoanOpen});
}
