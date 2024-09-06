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
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/sell_collateral_response_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_otp_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_securities_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/sell_collateral_otp_arguments.dart';
import 'package:lms/login/LoginValidationBloc.dart';
import 'package:lms/sell_collateral/SellCollateralBloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SellCollateralOtpController extends GetxController with GetTickerProviderStateMixin, CodeAutoFill{
  final ConnectionInfo _connectionInfo;
  final RequestSellCollateralOtpUseCase _requestSellCollateralOtpUseCase;
  final RequestSellCollateralSecuritiesUseCase _requestSellCollateralSecuritiesUseCase;

  SellCollateralOtpController(this._connectionInfo, this._requestSellCollateralOtpUseCase, this._requestSellCollateralSecuritiesUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final sellCollateralBloc = SellCollateralBloc();
  Timer? _timer;
  int _start = 120;
  RxBool retryAvailable = false.obs;
  AnimationController? animController;
  String? otpValue;
  final _loginValidatorBloc = LoginValidatorBloc();
  Preferences preferences = new Preferences();
  String? mobileExist, firebaseToken;
  RxBool isResendOTPClickable = true.obs;
  RxBool isSubmitBtnClickable = true.obs;
  TextEditingController otpController = TextEditingController();
  String signature = "";
  SellCollateralOtpArguments sellCollateralOtpArguments = Get.arguments;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
     // setState(() {
        if (_start < 1) {
          timer.cancel();
          isResendOTPClickable.value = false;
          retryAvailable.value = true;
        } else {
          _start = _start - 1;
        }
     // });
    });
  }

  String get timerString {
    Duration duration = Duration(seconds: _start);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer!.cancel();
    animController!.dispose();
    _loginValidatorBloc.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
    cancel();
  }

  @override
  void onInit() {
    super.onInit();
    listenForCode();
    animController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
  }

  @override
  void codeUpdated() {
    if(RegExp(r'^[0-9]+$').hasMatch(code!)){
      otpValue = code;
      otpController.text = code ?? "";
    }
  }

  Future<void> createSellCollateralRequest() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    SecuritiesEntity securities = new SecuritiesEntity(list: sellCollateralOtpArguments.sellList);
    if (otpValue!.isEmpty) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else if (otpValue!.length < 4) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else {
      if (await _connectionInfo.isConnected) {
        showDialogLoading(Strings.please_wait);
        SellCollateralRequestEntity sellCollateralRequestEntity =
            SellCollateralRequestEntity(
                securities: securities,
                loanName: sellCollateralOtpArguments.loanName,
                otp: otpValue!,
                loanMarginShortfallName:
                    sellCollateralOtpArguments.marginShortfallName);
        DataState<SellCollateralResponseEntity> response =
            await _requestSellCollateralSecuritiesUseCase.call(
                RequestSellCollateralSecuritiesParams(
                    sellCollateralRequestEntity: sellCollateralRequestEntity));
        Get.back();

        if(response is DataSuccess){
          if(response.data != null){
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = sellCollateralOtpArguments.loanName;
            parameter[Strings.is_for_margin_shortfall] = sellCollateralOtpArguments.marginShortfallName == "" ? "False" : "True";
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.sell_success, parameter);

            retryAvailable.value = false;
            Get.back();
            Get.toNamed(sellCollateralSuccessView, arguments: sellCollateralOtpArguments.loanType);
          }
        } else if(response is DataFailed){
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            otpController.clear();
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = sellCollateralOtpArguments.loanName;
            parameter[Strings.is_for_margin_shortfall] = sellCollateralOtpArguments.marginShortfallName == "" ? "False" : "True";
            parameter[Strings.error_message] = response.error!.message;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.sell_failed, parameter);

            Utility.showToastMessage(response.error!.message);
          }
        }

      } else {
        showSnackBar(scaffoldKey);
      }
    }
  }

  void sellCollateralOTP() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading( Strings.please_wait);
      DataState<CommonResponseEntity> response = await _requestSellCollateralOtpUseCase.call();
      Get.back();
      if (response is DataSuccess) {
        if(response.data != null){
          Utility.showToastMessage(Strings.enter_otp);
          startTimer();
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void otpCompleted(String otp)  {
    otpValue = otp;
    if (otpValue!.length >= 4) {
      isSubmitBtnClickable.value = false;
      createSellCollateralRequest();
    } else {
      isSubmitBtnClickable.value = true;
    }
  }

  otpOnChanged(String value) {
    if (value.length >= 4) {
      isSubmitBtnClickable.value = false;
    } else {
      isSubmitBtnClickable.value = true;
    }
  }

  Future<void> resendOtpClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        otpController.clear();
        listenForCode();
        sellCollateralOTP();
       // setState(() {
          _start = 120;
          retryAvailable.value = false;
          isResendOTPClickable.value = true;
       // });
      } else {
        showSnackBar(scaffoldKey);
      }
    });
  }
}