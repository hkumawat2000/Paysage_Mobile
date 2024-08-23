import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/usecases/account_settings_usecases.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_profile_and_set_alert_details_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/get_profile_and_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/get_profile_and_set_alert_usecase.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';

class AccountSettingsController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final AccountSettingsUseCase _accountSettingsUseCase;
  final GetProfileAndSetAlertUsecase _getProfileAndSetAlertUsecase;

  AccountSettingsController(this._connectionInfo, this._accountSettingsUseCase,
      this._getProfileAndSetAlertUsecase);

  RxString userName = "".obs;
  RxString userMobileNo = "".obs;
  RxString userEmail = "".obs;
  RxString profileImage = "".obs;
  RxString rxbyteImageString = "".obs;
  File? image;
  RxBool isKYCCompleted = false.obs;
  RxBool isAPIResponse = false.obs;
  Rx<AlertDataResponseEntity> alretDataEntity = AlertDataResponseEntity().obs;
  ImagePicker imagePicker = ImagePicker();
  Preferences preferences = Preferences();

  @override
  void onInit() {
    toGetProfileDetailsAndSetAlert();
    super.onInit();
  }

  Future<void> toGetProfileDetailsAndSetAlert() async {
    if (await _connectionInfo.isConnected) {
      GetProfileAndSetAlertRequestEntity getProfileAndSetAlertRequestEntity =
          GetProfileAndSetAlertRequestEntity(
        isForAlert: 0,
        percentage: 0,
        amount: 0,
      );

      DataState<GetProfileAndSetAlertDetailsResponseEntity> response =
          await _getProfileAndSetAlertUsecase.call(GetProfileAndSetAlertParams(
              getProfileAndSetAlertRequestEntity:
                  getProfileAndSetAlertRequestEntity));

      if (response is DataSuccess) {
        isAPIResponse.value = true;
        isKYCCompleted.value =
            response.data!.alertData!.customerDetails!.kycUpdate == 1
                ? true
                : false;
        if (response.data!.alertData!.userKyc != null) {}
        if (response.data!.alertData!.userKyc != null) {
          if (response.data!.alertData!.userKyc!.kycStatus == "Pending" ||
              response.data!.alertData!.userKyc!.kycStatus == "Rejected") {
            userName.value =
                response.data!.alertData!.customerDetails!.fullName!;
          } else {
            userName.value = response.data!.alertData!.userKyc!.fullname!;
          }
        } else {
          userName.value = response.data!.alertData!.customerDetails!.fullName!;
        }
        userMobileNo.value = response.data!.alertData!.customerDetails!.phone!;
        userEmail.value = response.data!.alertData!.customerDetails!.user!;
        alretDataEntity.value = response.data!.alertData!;
        if (response.data!.alertData!.profilePhotoUrl != null) {
          profileImage.value = response.data!.alertData!.profilePhotoUrl!;
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          isAPIResponse.value = false;
          commonDialog(Strings.session_timeout, 4);
        }else{
          isAPIResponse.value = false;
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<bool> willPopCallback() async {
    Navigator.pop(Get.context!, "cancel");
    return true;
  }

  Future<void> uploadPhoto() async {
    if (await _connectionInfo.isConnected) {
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> updateProfilePicAndPin() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity =
          UpdateProfileAndPinRequestEntity(
        isForUpdatePin: 0,
        isForProfilePic: 1,
        oldPin: '1134',
        newPin: '1234',
        retypePin: '1234',
        image: rxbyteImageString.value,
      );

      DataState<UpdateProfileAndPinResponseEntity> response =
          await _accountSettingsUseCase.call(
        UpdateProfileAndPinRequestParams(
            updateProfileAndPinRequestEntity: updateProfileAndPinRequestEntity),
      );
      Get.back();
      if (response is DataSuccess) {
        //Firebase Event
        Map<String, dynamic> parameters = new Map<String, dynamic>();
        parameters[Strings.name] = userName;
        parameters[Strings.mobile_no] = userMobileNo;
        parameters[Strings.email] = userEmail;
        parameters[Strings.photo_url] =
            response.data!.updateDataResponseEntity!.profilePicturesFileUrl;
        parameters[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.profile_photo_update, parameters);

        imageCache.clear();
        imageCache.clearLiveImages();
        profileImage.value =
            response.data!.updateDataResponseEntity!.profilePicturesFileUrl!;
        Utility.showToastMessage("Profile picture updated");
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else if (response.error!.message.isNotEmpty) {
          commonDialog(response.error!.message, 0);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
