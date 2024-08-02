import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/pin_screen_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/pin_screeen_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/pin_screen_arguments.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/offline_customer_screen.dart';
import 'package:lms/util/Preferences.dart';
import 'package:local_auth/local_auth.dart';

class PinScreenController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final PinScreeenUsecase pinScreeenUsecase;

  PinScreenController(this._connectionInfo, this.pinScreeenUsecase);

  final scadffoldKey = GlobalKey<ScaffoldState>();
  final Preferences _preferences = Preferences();
  final Utility utility = Utility();
  List<BiometricType> availableBiometricType = <BiometricType>[];
  String? enterPin;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  RxBool isFingerSupport = false.obs;
  RxBool isFingerEnable = false.obs;
  RxBool isSubmitButtonClickable = true.obs;
  RxBool obscureText = true.obs;
  RxBool hideShowText = false.obs;
  RxBool isAuthenticated = false.obs;
  RxString versionName = "".obs;
  RxString doesEmailExist = "".obs;
  RxString doesTokenExist = "".obs;
  RxString doesFirebaseTokenExist = "".obs;
  RxString savePin = "".obs;
  RxString mobileNumber = "".obs;
  RxString currentSavedPin = "".obs;
  RxString newToken = "".obs;
  RxString deviceInfo = "".obs;
  final LocalAuthentication localAuthentication = LocalAuthentication();
  final TextEditingController enterPinTextEditingController =
      TextEditingController();

  PinScreenArguments pinScreenArguments = Get.arguments;

  @override
  void onInit() {
    fetchValuesFromPrefrences();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchValuesFromPrefrences() async {
    versionName(await Utility.getVersionInfo());
    doesEmailExist(await _preferences.getEmail());
    doesTokenExist(await _preferences.getToken());
    doesFirebaseTokenExist(await _preferences.getFirebaseToken());
    savePin(await _preferences.getPin());
    mobileNumber(await _preferences.getMobile());
    deviceInfo(await getDeviceInfo());
    // bool kycCompleteSrt = await preferences.getUserKYC();
    // String? loanNoSrt = await preferences.getLoanApplicationNo();

    if (savePin.value.isNotEmpty) {
      getFingerPrintInfo();
    }
  }

  Future<void> getFingerPrintInfo() async {
    isFingerSupport(await utility.getBiometricsSupport());
    isFingerEnable(await _preferences.getFingerprintEnable());
    availableBiometricType = await utility.getAvailableSupport();

    if (isFingerSupport.isTrue &&
        isFingerEnable.isTrue &&
        availableBiometricType.length != 0) {
      isFingerPrintSupport();
    }
  }

  Future<void> isFingerPrintSupport() async {
    isAuthenticated(await utility.authenticateMe());
    if (isAuthenticated.isTrue) {
      if (await _connectionInfo.isConnected) {
        currentSavedPin(await _preferences.getPin());
        SchedulerBinding.instance.addPostFrameCallback((_) {
          //TODO Add Loading Indicator
          refreshFirebaseToken(enterPin!, Strings.pin);
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }

  //TODO To pass PIN and isComingFrom
  Future<void> refreshFirebaseToken(String pin, String isComingFrom) async {
    await FirebaseMessaging.instance.deleteToken();
    newToken(await FirebaseMessaging.instance.getToken());
    if (doesFirebaseTokenExist.value == newToken.value) {
      print(
          "=========================================================================");
      print("Token not refreshed");
      print(
          "=========================================================================");
      refreshFirebaseToken(pin, isComingFrom);
    } else {
      print("New token created :: ${newToken.value}");
      getPinApiCall(isComingFrom);
    }
  }

  Future<void> onPinCompleted(String enteredPin) async {
    if (await _connectionInfo.isConnected) {
      if (enteredPin.length >= 4) {
        isSubmitButtonClickable.value = false;
        getPinApiCall(Strings.pin);
      } else {
        isSubmitButtonClickable.value = true;
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> onPinChanged(String pinValue) async {
    if (await _connectionInfo.isConnected) {
      if (pinValue.length >= 4) {
        isSubmitButtonClickable.value = false;
      } else if (pinValue.length == 0) {
        hideShowText.value = false;
      } else {
        isSubmitButtonClickable.value = true;
        hideShowText.value = true;
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void hideOrShowText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> callGetPinApi() async {
    if (await _connectionInfo.isConnected) {
      if (enterPin != null &&
          enterPinTextEditingController.text.isNotEmpty &&
          enterPinTextEditingController.text.length == 4 &&
          enterPin!.length == 4) {
        showDialogLoading(Strings.please_wait);
        getPinApiCall(Strings.pin);
      } else {
        Utility.showToastMessage(Strings.message_valid_PIN);
      }
    } else {
      showSnackBar(scadffoldKey);
    }
  }

  Future<void> toRegisterWithAnotherAccount() async {
    FirebaseMessaging.instance.deleteToken();
    localAuthentication.stopAuthentication();
    bool? accountPermission = await _preferences.getEmailDialogConsent();
    bool? photoPermission = await _preferences.getPhotoConsent();
    bool? biometricPermission = await _preferences.getBiometricConsent();
    bool? biometricEnable = await _preferences.getFingerprintEnable();
    bool? biometricConsent = await _preferences.getFingerprintConsent();
    await _preferences.clearPreferences();
    _preferences.setIsVisitTutorial("true");
    _preferences.setFingerprintConsent(biometricConsent);
    _preferences.setEmailDialogConsent(accountPermission!);
    _preferences.setPhotoConsent(photoPermission);
    _preferences.setBiometricConsent(biometricPermission);
    _preferences.setFingerprintEnable(biometricEnable);

    //Navigate to Login Screen
    Get.offNamed(loginView);
  }

  Future<void> toNavigatetoForgotPin() async {
    if (await _connectionInfo.isConnected) {
      localAuthentication.stopAuthentication();
      //TODO Navigate To forgot Pin Screen
      Get.toNamed(forgotPinView);
    } else {
      showSnackBar(scadffoldKey);
    }
  }

  Future<void> getPinApiCall(String isComingFrom) async {
    if (await _connectionInfo.isConnected) {
      PinScreenRequestEntity pinScreenRequestDataEntity =
          PinScreenRequestEntity(
        mobileNumber: mobileNumber.value,
        pin: enterPin,
        firebase_token: newToken.value,
        acceptTerms: 1,
        platform: deviceInfo.value,
        appversion: versionName.value,
      );

      DataState<AuthLoginResponseEntity> response =
          await pinScreeenUsecase.call(
        PinScreenParams(
          pinScreenRequestEntity: pinScreenRequestDataEntity,
        ),
      );
      Get.back();
      if (response is DataSuccess) {
        //Firebase Event Parameters
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileNumber.value;
        parameter[Strings.email] = doesEmailExist.value;
        parameter[Strings.date_time] = getCurrentDateAndTime();

        // To callfirebase event
        if (isComingFrom == "PIN") {
          firebaseEvent(Strings.log_in_with_pin, parameter);
        } else {
          firebaseEvent(Strings.log_in_with_biometric, parameter);
        }

        //TO Set Preferences by using response data
        if (response.data!.registerData!.customer != null) {
          _preferences.setCamsEmail(
              response.data!.registerData!.customer!.camsEmailId ?? "");
          _preferences.setToken(response.data!.registerData!.token!);
          // preferences.setCustomer(value.data);
          _preferences.setFullName(
              response.data!.registerData!.customer!.firstName.toString() +
                  " " +
                  response.data!.registerData!.customer!.lastName.toString());
          // preferences.setUserKYC(value.data!.customer!.kycUpdate == 1 ? true : false);
          _preferences.setEmail(response.data!.registerData!.customer!.user!);
          _preferences.setPin(enterPin!);
        }

        localAuthentication.stopAuthentication();
        if (response.data!.registerData!.customer!.offlineCustomer == 1 &&
            response.data!.registerData!.customer!.loanOpen == 0) {
          Get.offUntil(GetPageRoute(page: () => OfflineCustomerScreen()),
              (route) => false);
        } else {
          //TODO Navigate To Dashboard
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(isFromPinScreen: true)));
        }
      } else if (response is DataFailed) {
        Utility.showToastMessage(
            response.error!.message ?? Strings.something_went_wrong);

        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileNumber.value;
        parameter[Strings.email] = doesEmailExist.value;
        parameter[Strings.error_message] = response.error!.message;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if (isComingFrom == "PIN") {
          firebaseEvent(Strings.log_in_with_pin_failed, parameter);
        } else {
          firebaseEvent(Strings.log_in_with_biometric_failed, parameter);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
