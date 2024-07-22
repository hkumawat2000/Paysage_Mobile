import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/login_usecases.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_otp_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/otp_verification_arguments.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/offline_customer_screen.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationController extends GetxController {
  final LoginUseCase _loginUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final ConnectionInfo _connectionInfo;
  OtpVerificationController(
      this._loginUseCase, this._verifyOtpUsecase, this._connectionInfo);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  RxInt start = 0.obs;
  String? otpValue;
  Preferences _preferences = Preferences();
  String? mobileExist, firebase_token;
  RxBool isResendOTPClickable = false.obs;
  RxBool isSubmitBtnClickable = true.obs;
  final TextEditingController otpTextController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    initSmsListener();
    startTime();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _timer!.cancel();
    // controller!.dispose();
    SmsAutoFill().unregisterListener();

    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
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

  Future<void> initSmsListener() async {
    String signature = await SmsAutoFill().getAppSignature;
    print("signature ==> $signature");
  }

  Future<void> autoLogin() async {
    mobileExist = await _preferences.getMobile();
    print(mobileExist);
    firebase_token = await _preferences.getFirebaseToken();
  }

  void login(
    String mobileNumber,
    fireBaseToken,
    deviceInfo,
    versionName,
    message,
    int acceptTerms,
  ) async {
    if (await _connectionInfo.isConnected) {
      //TODO replace with Get.dialog
      //LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);

      LoginSubmitResquestEntity loginSubmitResquestDataEntity =
          LoginSubmitResquestEntity(
        mobileNumber: mobileNumber,
        firebase_token: fireBaseToken,
        acceptTerms: acceptTerms,
        platform: deviceInfo,
        appVersion: versionName,
      );
      DataState<AuthLoginResponseEntity> response = await _loginUseCase.call(
        LoginSubmitParams(
          loginSubmitResquestEntity: loginSubmitResquestDataEntity,
        ),
      );
      //Replace with Get.back
      //Navigator.pop(context); //pop dialog
      if (response is DataSuccess) {
        Utility.showToastMessage(message);
        startTime();
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void otpVerify(
    String mobileNumber,
    fireBaseToken,
    deviceInfo,
    versionName,
  ) async {
    if (otpValue == null) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else if (otpValue!.length < 4) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else {
      if (await _connectionInfo.isConnected) {
        //Replacemwith Get.dialog
        //LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        VerifyOtpRequestEntity verifyOtpRequestDataEntity =
            VerifyOtpRequestEntity(
          mobileNumber: mobileNumber,
          firebase_token: fireBaseToken,
          platform: deviceInfo,
          appVersion: versionName,
          otp: otpValue,
        );
        DataState<AuthLoginResponseEntity> response =
            await _verifyOtpUsecase.call(
          VerifyOtpParams(
            verifyOtpRequestEntity: verifyOtpRequestDataEntity,
          ),
        );
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileNumber;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if (response is DataSuccess) {
          print("object ${response.data!.registerData!.token.toString()}");
          // print('CAMS Email ID${response.data!.registerData!.customer!.camsEmailId}');
          // _preferences.setCamsEmail(
          //     response.data!.registerData!.customer!.camsEmailId ?? "");
          _preferences.setToken(response.data!.registerData!.token ?? "");
          print('Token ID${response.data!.registerData!.token}');

          _preferences
              .setMobile(response.data!.registerData!.customer!.phone ?? "");
          // preferences!.setCustomer(value.data);
          _preferences
              .setEmail(response.data!.registerData!.customer!.user ?? "");
          _preferences.setFullName(
              response.data!.registerData!.customer!.firstName! +
                  " " +
                  response.data!.registerData!.customer!.lastName!);

          if (response.data!.registerData!.customer!.offlineCustomer != null &&
              response.data!.registerData!.customer!.offlineCustomer == 1 &&
              response.data!.registerData!.customer!.setPin == 0) {
            firebaseEvent(Strings.login_otp_verified, parameter);
            Get.toNamed(jailBreakView);
            //TODO Navigate to Set Pin Screen
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             SetPinScreen(true, value.data!.customer!.loanOpen!)));
          } else if (response.data!.registerData!.customer!.offlineCustomer !=
                  null &&
              response.data!.registerData!.customer!.offlineCustomer == 1 &&
              response.data!.registerData!.customer!.loanOpen == 0) {
            firebaseEvent(Strings.login_otp_verified, parameter);
            Get.offUntil(GetPageRoute(page: () => OfflineCustomerScreen()),
                (route) => false);
          } else {
            firebaseEvent(Strings.login_otp_verified, parameter);
            //TODO Navigate to Dashboard
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => DashBoard()),
            //     (route) => false);
          }
        } else if (response is DataFailed) {
          print('-----> Data Failed Status Code ${response.error!.statusCode}');
          if (response.error!.statusCode == 404) {
            print("object 404");
            firebaseEvent(Strings.login_otp_verified, parameter);
            //TODO Navigate to Registration screen
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             RegistrationScreen(widget.mobileNumber, otpValue!)),
            //     (route) => false);
          } else if (response.error!.statusCode == 401) {
            print("object 401");
            otpTextController.clear();
            parameter[Strings.error_message] = response.error!.message;
            firebaseEvent(Strings.login_otp_failed, parameter);
            Utility.showToastMessage(response.error!.message);
          }else if(response.error!.statusCode == 500){
            print("object other${response.error!.statusCode}");

          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }
}
