// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';

import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/get_terms_of_use_usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/login_usecases.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/terms_and_conditions_arguments.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/otp_verify_screen.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class LoginController extends GetxController {
  final GetTermsOfUseUsecase _getTermsOfUseUsecase;
  final LoginUseCase _loginUseCase;
  final ConnectionInfo _connectionInfo;

  LoginController(
    this._getTermsOfUseUsecase,
    this._loginUseCase,
    this._connectionInfo,
  );

  final TextEditingController mobileNumberController = TextEditingController();
  Preferences _preferences = Preferences();
  var authToken;
  String versionName = "";
  String? deviceInfo = "";
  String? terms_of_use_url = "";
  String? privacy_policy_url = "";
  RxBool checkBoxValue = true.obs;
  bool _biometricEnable = false;
  bool _biometricConsent = false;
  RxInt acceptTerms = 1.obs;
  List<String>? dummyAccounts = [];
  FocusNode mobileTextfiledFocus = FocusNode();
  String version = "";

  @override
  void onInit() async {
    getValuesFromPerfrences();
    if (await _connectionInfo.isConnected) {
      getTermsOfUse();
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
    super.onInit();
  }

  @override
  void onClose() {
    mobileTextfiledFocus.dispose();
    super.onClose();
  }

  Future<void> getValuesFromPerfrences() async {
    _biometricEnable = await _preferences.getFingerprintEnable();
    _biometricConsent = await _preferences.getFingerprintConsent();
    _preferences.clearPreferences();
    _preferences.setIsVisitTutorial("true");
    _preferences.setFingerprintEnable(_biometricEnable);
    _preferences.setFingerprintConsent(_biometricConsent);
    authToken = await FirebaseMessaging.instance.getToken();
    _preferences.setFirebaseToken(authToken);
    version = await Utility.getVersionInfo();
    versionName = version;
    deviceInfo = await getDeviceInfo();
  }

  Future<void> getTermsOfUse() async {
    if (await _connectionInfo.isConnected) {
      DataState<GetTermsandPrivacyResponseEntity> response =
          await _getTermsOfUseUsecase.call();
      if (response is DataSuccess) {
        if (response.data!.termsOfUseData != null &&
            response.data!.termsOfUseData!.dummyAccounts!.length != 0) {
          dummyAccounts = response.data!.termsOfUseData!.dummyAccounts!;
          _preferences.setPrivacyPolicyUrl(
              response.data!.termsOfUseData!.privacyPolicyUrl!);
          _preferences.setDummyAccountList(dummyAccounts);
          terms_of_use_url = response.data!.termsOfUseData!.termsOfUseUrl;
          privacy_policy_url = response.data!.termsOfUseData!.privacyPolicyUrl;
          //TODO : To solve context error.
          // FocusScope.of(context).requestFocus(mobileFocus);
        }
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }
    }
  }

  Future<void> onMobileNumberValueChanged() async {
    if (mobileNumberController.text.length == 10) {
      //TODO Solve context error.
      //FocusScope.of(context).requestFocus(FocusNode());
      if (await _connectionInfo.isConnected) {
        login();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }

  void onCheckBoxValueChanged(bool? newValue) {
    checkBoxValue.value = newValue!;
    if (checkBoxValue.isTrue) {
      acceptTerms.value = 1;
    } else {
      acceptTerms.value = 0;
    }
  }

  Future<void> login() async {
    RegExp myRegExp = RegExp('0');
    if (mobileNumberController.text.startsWith(myRegExp)) {
      Utility.showToastMessage(Strings.message_mobile_no_not_allow_first_zero);
    } else if (mobileNumberController.text.trim().length == 0) {
      Utility.showToastMessage(Strings.message_valid_mobile_no);
    } else if (mobileNumberController.text.trim().length < 10) {
      Utility.showToastMessage(Strings.message_valid_mobile_no_10_digit);
    } else if (acceptTerms == 0) {
      Utility.showToastMessage(Strings.accept_t_and_p);
    } else {
      bool? accountPermission = await _preferences.getEmailDialogConsent();
      bool? photoPermission = await _preferences.getPhotoConsent();
      bool? biometricConsent = await _preferences.getFingerprintConsent();
      bool? biometricPermission = await _preferences.getBiometricConsent();
      String? privacyUrl = await _preferences.getPrivacyPolicyUrl();
      bool? biometricEnable = await _preferences.getFingerprintEnable();
      _preferences.clearPreferences();
      _preferences.setIsVisitTutorial("true");
      _preferences.setEmailDialogConsent(accountPermission!);
      _preferences.setPhotoConsent(photoPermission);
      _preferences.setBiometricConsent(biometricPermission);
      _preferences.setFingerprintConsent(biometricConsent);
      _preferences.setFingerprintEnable(biometricEnable);
      _preferences.setPrivacyPolicyUrl(privacyUrl);
      _preferences.setDummyAccountList(dummyAccounts);
      for (int i = 0; i < dummyAccounts!.length; i++) {
        if (dummyAccounts![i] == mobileNumberController.text) {
          _preferences.setDummyUserMobile(
              mobileNumberController.text.toString().trim());
        }
      }
      // TODO to solve context error. Add Get.dialog
      //LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
      authToken = await FirebaseMessaging.instance.getToken();
      _preferences.setFirebaseToken(authToken);

      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobileNumberController.text.trim();
      parameter[Strings.date_time] = getCurrentDateAndTime();
      firebaseEvent(Strings.login_otp_sent, parameter);

      if (await _connectionInfo.isConnected) {
        LoginSubmitResquestEntity loginSubmitResquestDataEntity =
            LoginSubmitResquestEntity(
          mobileNumber: mobileNumberController.text,
          firebase_token: authToken,
          acceptTerms: acceptTerms.value,
          platform: deviceInfo,
          appVersion: versionName,
        );
        DataState<AuthLoginResponseEntity> response = await _loginUseCase.call(
          LoginSubmitParams(
            loginSubmitResquestEntity: loginSubmitResquestDataEntity,
          ),
        );
        if (response is DataSuccess) {
          //TODO Add Get.back
          //        Navigator.pop(context);

          Get.bottomSheet(
            backgroundColor: Colors.transparent,
            enableDrag: false,
            isDismissible: false,
            isScrollControlled: true,
            OTPVerificationView(
              loginSubmitResquestEntity: loginSubmitResquestDataEntity,
            ),
          );
          // showModalBottomSheet(
          //   backgroundColor: Colors.transparent,
          //   context: Get.context!,
          //   enableDrag: false,
          //   isScrollControlled: true,
          //   builder: (BuildContext bc) {
          //     return OTPVerificationView();
          //     //OTPVerificationScreen(mobileController.text, acceptTerms);
          //   },
          // );
        } else if (response is DataFailed) {
          Utility.showToastMessage(response.error!.message);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }

  void navigateToTermsAndConditionWebview(bool isUsedForPrivacyPolicy) async {
    if (await _connectionInfo.isConnected) {
      Get.toNamed(
        termsAndConditionsWebView,
        arguments: TermsAndConditionsWebViewArguments(
          url: isUsedForPrivacyPolicy ? privacy_policy_url : terms_of_use_url,
          isComingFor: isUsedForPrivacyPolicy
              ? Strings.privacy_policy
              : Strings.terms_of_use,
          isForPrivacyPolicy: isUsedForPrivacyPolicy ? true : false,
        ),
      );
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
