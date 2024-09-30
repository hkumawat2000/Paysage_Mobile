
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
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_request_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/request_unpledge_otp_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/unpledge_request_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/arguments/unpledge_otp_arguments.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class UnpledgeOtpVerificationController extends GetxController with GetTickerProviderStateMixin, CodeAutoFill{
  final ConnectionInfo _connectionInfo;
  final RequestUnpledgeOtpUseCase _requestUnpledgeOtpUseCase;
  final UnpledgeRequestUsecase _unpledgeRequestUseCase;

  UnpledgeOtpVerificationController(this._connectionInfo, this._requestUnpledgeOtpUseCase, this._unpledgeRequestUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  RxInt start = 120.obs;
  RxBool retryAvailable = false.obs;
  AnimationController? controller;
  String? otpValue;
  Preferences preferences = new Preferences();
  var mobileExist;
  RxBool isResendOTPClickable = true.obs;
  RxBool isSubmitBtnClickable = true.obs;
  TextEditingController otpController = TextEditingController();
  final unpledgeBloc = UnpledgeBloc();
  UnpledgeOtpArguments unpledgeOtpArguments = Get.arguments;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) { ///todo: => setState(() functionality
          if (start < 1) {
            timer.cancel();
           // setState(() {
              isResendOTPClickable.value = false;
              retryAvailable.value = true;
            //});
          } else {
            start = start - 1;
          }
        },
      //),
    );
  }

  String get timerString {
    Duration duration = Duration(seconds: start.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer!.cancel();
    controller!.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
    cancel();
  }

  @override
  void onInit() {
    listenForCode();
    preferences = Preferences();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
    super.onInit();
  }

  @override
  void codeUpdated() {
    if(RegExp(r'^[0-9]+$').hasMatch(code!)){
      otpValue = code;
      otpController.text = code ?? "";
    }
  }

  void unpledgeRequestOTP() async{
    showDialogLoading( Strings.please_wait);
    DataState<CommonResponseEntity> response = await _requestUnpledgeOtpUseCase.call();
    Get.back();
    if (response is DataSuccess) {
      Utility.showToastMessage(Strings.otp_sent_success);
      startTimer();
    } else if (response is DataFailed) {
      if (response.error!.statusCode == 403) {
        commonDialog(Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(response.error!.message);
      }
    }
    /*unpledgeBloc.requestUnpledgeOTP().then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.otp_sent_success);
        startTimer();
      } else if (value.errorCode == 403) {
        commonDialog( Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });*/
  }


  void createUnpledgeRequest() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    if (otpValue!.isEmpty ) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else if (otpValue!.length < 4) {
      Utility.showToastMessage(Strings.message_valid_OTP);
    } else {
      showDialogLoading( Strings.please_wait);

      UnpledgeRequestReqEntity unpledgeRequestReqEntity =
          UnpledgeRequestReqEntity(
              loanName: unpledgeOtpArguments.loanName,
              securities: new UnPledgeSecuritiesEntity(list: unpledgeOtpArguments.unpledgeListItem),
              otp: otpValue);
      DataState<UnpledgeRequestResponseEntity> response = await _unpledgeRequestUseCase.call(UnpledgeRequestParams(unpledgeRequestReqEntity: unpledgeRequestReqEntity));
      Get.back();

      if(response is DataSuccess){
        retryAvailable.value = false;
        // Utility.showToastMessage(value.message);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = unpledgeOtpArguments.loanName;
        parameter[Strings.max_allowable] = unpledgeOtpArguments.maxAllowable;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.Unpledge_Success, parameter);

        Get.toNamed(unpledgeSuccessfulView, arguments: unpledgeOtpArguments.loanType);

      } else if(response is DataFailed){
        if(response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else{
          otpController.clear();
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = unpledgeOtpArguments.loanName;
          parameter[Strings.max_allowable] = unpledgeOtpArguments.maxAllowable;
          parameter[Strings.error_message] = response.error!.message;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.unpledge_failed, parameter);
          Utility.showToastMessage(response.error!.message);
        }
      }


      /*UnpledgeRequestBean unpledgeRequestBean = UnpledgeRequestBean();
      unpledgeRequestBean.loanName = unpledgeOtpArguments.loanName;
      unpledgeRequestBean.securities = new UnPledgeSecurities(list: unpledgeOtpArguments.unpledgeListItem);
      unpledgeRequestBean.otp = otpValue;
      unpledgeBloc.unpledgeRequest(unpledgeRequestBean).then((value) {
        Get.back();
        if (value.isSuccessFull!) {
          retryAvailable.value = false;
          // Utility.showToastMessage(value.message);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = unpledgeOtpArguments.loanName;
          parameter[Strings.max_allowable] = unpledgeOtpArguments.maxAllowable;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.Unpledge_Success, parameter);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UnpledgeSuccessfulScreen(unpledgeOtpArguments.loanType)));

        } else if (value.errorCode == 403) {
          commonDialog( Strings.session_timeout, 4);
        } else {
          otpController.clear();
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = unpledgeOtpArguments.loanName;
          parameter[Strings.max_allowable] = unpledgeOtpArguments.maxAllowable;
          parameter[Strings.error_message] = value.errorMessage;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.unpledge_failed, parameter);
          Utility.showToastMessage(value.errorMessage!);
        }
      });*/
    }

  }

  resendOtpClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        otpController.clear();
        listenForCode();
        unpledgeRequestOTP();
       // setState(() {
          start.value = 120;
          retryAvailable.value = false;
          isResendOTPClickable.value = true;
       // });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  submitClicked()  async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Utility.isNetworkConnection().then((isNetwork) {
          if (isNetwork) {
            createUnpledgeRequest();
          } else {
            Utility.showToastMessage(Strings.no_internet_message);
          }
        });

      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  otpOnChanged(String value) {
    if (value.length >= 4) {
      isSubmitBtnClickable.value = false;
    } else {
      isSubmitBtnClickable.value = true;
    }
    //setState(() {});
  }

  otpOnCompleted(String otp) {
    otpValue = otp;
    if (otpValue!.length >= 4) {
      isSubmitBtnClickable.value = false;
      Utility.isNetworkConnection().then((isNetwork) {
        if (isNetwork) {
          createUnpledgeRequest();
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
    } else {
      isSubmitBtnClickable.value = true;
    }
  }
}