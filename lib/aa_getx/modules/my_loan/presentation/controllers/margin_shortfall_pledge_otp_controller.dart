import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/create_loan_application_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/process_cart_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/pledge_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/create_loan_application_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/request_pledge_otp_usecase.dart';

class MarginShortfallPledgeOtpController extends GetxController with GetSingleTickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? timer;
  RxInt start = 120.obs;
  AnimationController? animController;
  String? otpValue;
  Preferences? preferences;
  var mobileExist, firebase_token;
  RxBool isResendOTPClickable = true.obs;
  bool isSubmitBtnClickable = true;
  MarginShortfallPledgeOtpArguments pageArguments = Get.arguments;
  TextEditingController otpController = TextEditingController();
  RxBool retryAvailable = false.obs;
  final ConnectionInfo _connectionInfo;
  final RequestPledgeOtpUseCase _requestPledgeOtpUseCase;
  final CreateLoanApplicationUseCase _createLoanApplicationUseCase;

  MarginShortfallPledgeOtpController(this._connectionInfo, this._requestPledgeOtpUseCase, this._createLoanApplicationUseCase);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
            if (start < 1) {
              timer.cancel();
              isResendOTPClickable.value = false;
              retryAvailable.value = true;
//              Utility.showToastMessage(Strings.expire_otp);
            } else {
              start = start - 1;
            }
          }
    );
  }

  String get timerString {
    Duration duration = Duration(seconds: start.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    timer!.cancel();
    animController!.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    autoLogin();
    animController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
  }


  void createLoanApplication() async {

    if(await _connectionInfo.isConnected){
      String? email = await preferences!.getEmail();
      showDialogLoading(Strings.please_wait);
      CreateLoanApplicationRequestEntity createLoanApplicationRequestEntity =
          CreateLoanApplicationRequestEntity(
        cartName: pageArguments.cartName,
        otp: otpValue,
        fileId: pageArguments.fileId,
        pledgorBoid: pageArguments.pledgorBoid,
      );
      DataState<ProcessCartResponseEntity> response = await _createLoanApplicationUseCase.call(CreateLoanApplicationRequestParams(createLoanApplicationRequestEntity: createLoanApplicationRequestEntity));
      Get.back();
      if(response is DataSuccess){
        if(response.data != null){
          retryAvailable.value = false;
          start.value = 0;
          debugPrint("loan no : ${response.data!.processCartData!.loanApplication!.name}");
          debugPrint("cart name : ${pageArguments.cartName}");
          debugPrint("loan dp : ${response.data!.processCartData!.loanApplication!.drawingPower}");
          debugPrint("loan colateral : ${response.data!.processCartData!.loanApplication!.totalCollateralValue}");

          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobileExist;
          parameter[Strings.email] = email;
          parameter[Strings.action_type] = 'Pledge More';
          parameter[Strings.loan_number] = response.data!.processCartData!.loanApplication!.name;
          parameter[Strings.total_collateral_value_prm] = response.data!.processCartData!.loanApplication!.totalCollateralValue;
          parameter[Strings.drawing_power_prm] = response.data!.processCartData!.loanApplication!.drawingPower!.toStringAsFixed(2);
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.margin_shortFall_pledge_action_success, parameter);

          Get.toNamed(applicationSuccessView, arguments: response.data!.processCartData!.loanApplication!.name!);

        }

      } else if (response is DataFailed){
        if (response.error!.statusCode! == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
            otpController.clear();
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobileExist;
            parameter[Strings.email] = email;
            parameter[Strings.action_type] = 'Pledge More';
            parameter[Strings.error_message] = response.error!.message;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.margin_shortFall_pledge_action_failed, parameter);

            Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> autoLogin() async {
    mobileExist = await preferences!.getMobile();
    debugPrint(mobileExist);
    firebase_token = await preferences!.getFirebaseToken();
  }

  Future<void> pledgeOTP() async {
    if(await _connectionInfo.isConnected){
      showDialogLoading(Strings.please_wait);
      PledgeOTPRequestEntity pledgeOTPRequestEntity = PledgeOTPRequestEntity(instrumentType: pageArguments.instrumentType);
      DataState<CommonResponseEntity> response = await _requestPledgeOtpUseCase.call(PledgeOtpParams(pledgeOTPRequestEntity: pledgeOTPRequestEntity));
      Get.back();
      if(response is DataSuccess){
        if(response.data != null){
          Utility.showToastMessage(Strings.success_otp_sent);
          start.value = 120;
          retryAvailable.value = false;
          startTimer();
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

  Future resendOtpClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        otpController.clear();
        pledgeOTP();
        start.value = 120;
        retryAvailable.value = false;
        isResendOTPClickable.value = true;
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  otpFieldCompleted(String otp) {
    otpValue = otp;
    if (otpValue!.length >= 4) {
      isSubmitBtnClickable = false;
      Utility.isNetworkConnection().then((isNetwork) {
        if (isNetwork) {
          createLoanApplication();
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
    } else {
      isSubmitBtnClickable = true;
    }
  }
}

class MarginShortfallPledgeOtpArguments{
  String? cartName, fileId, pledgorBoid,instrumentType;

  MarginShortfallPledgeOtpArguments({required this.cartName,required this.fileId,required this.pledgorBoid,required this.instrumentType});
}