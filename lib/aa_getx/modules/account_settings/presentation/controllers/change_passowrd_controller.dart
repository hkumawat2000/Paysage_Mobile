import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/usecases/account_settings_usecases.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';

class ChangePassowrdController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final AccountSettingsUseCase _accountSettingsUseCase;

  ChangePassowrdController(this._connectionInfo, this._accountSettingsUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool currentPasswordVisible = true.obs;
  RxBool newPasswordVisible = true.obs;
  RxBool reTypePasswordVisible = true.obs;

  TextEditingController currentPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  TextEditingController reTypePin = TextEditingController();

  FocusNode currentPinFocus = FocusNode();
  FocusNode newPinFocus = FocusNode();
  FocusNode confirmPinFocus = FocusNode();
  Preferences preferences = Preferences();

  void toChangePasswordVisibility() {
    currentPasswordVisible.value = !currentPasswordVisible.value;
  }

  void toChangeNewPasswordVisibility() {
    newPasswordVisible.value = !newPasswordVisible.value;
  }

  void toChangeReTypePasswordVisibility() {
    reTypePasswordVisible.value = !reTypePasswordVisible.value;
  }

  Future<void> onChangePinSubmit() async {
    if (await _connectionInfo.isConnected) {
      String email = await preferences.getEmail();
      String? mobile = await preferences.getMobile();
      if (currentPin.text.length < 4) {
        commonDialog('Please enter valid current pin', 0);
      } else if (newPin.text.length < 4) {
        commonDialog('Please enter valid new pin', 0);
      } else if (reTypePin.text.length < 4) {
        commonDialog('Please enter valid retype pin', 0);
      } else {
        showDialogLoading(Strings.please_wait);
        UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity =
            UpdateProfileAndPinRequestEntity(
          isForUpdatePin: 1,
          isForProfilePic: 0,
          oldPin: currentPin.text.trim().toString(),
          newPin: newPin.text.trim().toString(),
          retypePin: reTypePin.text.trim().toString(),
          image: "",
        );
        DataState<UpdateProfileAndPinResponseEntity> response =
            await _accountSettingsUseCase.call(
          UpdateProfileAndPinRequestParams(
              updateProfileAndPinRequestEntity:
                  updateProfileAndPinRequestEntity),
        );
        Get.back();
        if (response is DataSuccess) {
          preferences.setPin(newPin.text.trim().toString());
          // Firebase Event
          Map<String, dynamic> parameters = new Map<String, dynamic>();
          parameters[Strings.mobile_no] = mobile;
          parameters[Strings.email] = email;
          parameters[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.change_pin, parameters);
          commonDialog(response.data!.message, 3);
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            Map<String, dynamic> parameters = new Map<String, dynamic>();
            parameters[Strings.mobile_no] = mobile;
            parameters[Strings.email] = email;
            parameters[Strings.error_message] = response.data!.message;
            parameters[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.change_pin_failed, parameters);
            commonDialog(response.error!.message, 0);
          }
        }
        // Call API on submit to store the pin in the backend
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
