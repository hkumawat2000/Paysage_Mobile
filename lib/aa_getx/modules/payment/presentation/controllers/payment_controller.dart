import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/payment_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/payment_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/razor_pay_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/create_order_id_usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/create_payment_request_usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/payment/presentation/arguments/payment_arguments.dart';
import 'package:lms/payment/PaymentBloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final GetLoanDetailsPayUseCase _getLoanDetailsUseCase;
  final CreateOrderIdUseCase _createOrderIdUseCase;
  final CreatePaymentRequestUseCase _createPaymentRequestUseCase;

  PaymentController(this._connectionInfo, this._getLoanDetailsUseCase,
      this._createOrderIdUseCase, this._createPaymentRequestUseCase);

  Razorpay? _razorpay;
  final paymentBloc = PaymentBloc();
  var orderId,
      paymentAmount,
      drawingPower,
      drawingPowerStr,
      sanctionedLimit,
      minimumPayAmount,
      loanBalanceAmt;
  RxDouble loanBalance = 0.0.obs;
  TextEditingController amountController = TextEditingController();
  RxBool isSubmitBtnClickable = true.obs;
  FocusNode focusNode = FocusNode();
  RxInt id = 1.obs;
  RxString radioButtonItem = 'Full Amount'.obs;
  RxBool isAmountFieldVisible = false.obs;
  Preferences preferences = Preferences();
  RxString transaction_logID = "".obs, emailId = "".obs, mobileNumber = "".obs;
  PaymentArguments paymentArguments = Get.arguments;
  Rx<LoanDetailDataEntity?> loanDetailData = LoanDetailDataEntity().obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getPreferenceData();
    if (paymentArguments.isMarginShortfall!) {
      radioButtonItem.value = 'Full Amount';
      id.value = 1;
      isAmountFieldVisible.value = false;
      isSubmitBtnClickable.value = false;
      amountController.text = "";
    }
    getLoanDetails(paymentArguments.loanName);
    // Utility.isNetworkConnection().then((isNetwork) {
    //   if (isNetwork) {
    //     paymentBloc.getLoanDetails(paymentArguments.loanName);
    //   } else {
    //     Utility.showToastMessage(Strings.no_internet_message);
    //   }
    // });
  }

  getPreferenceData() async {
    var email = await preferences.getEmail();
    var mobile = await preferences.getMobile();

    emailId.value = email;
    mobileNumber.value = mobile!;
  }

  void createOrderId(amount, loanBalance) {
    if (paymentArguments.isMarginShortfall!) {
      if (amount > loanBalance) {
        Utility.showToastMessage(
            Strings.payment_greater_than + " " "$loanBalance");
      } else {
        createOrder(amount);
      }
    } else {
      createOrder(amount);
    }
  }

  createOrder(amount) async {
    var newAmount = amount * 100;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();

    double requestAmountValue;
    if (paymentArguments.isMarginShortfall!) {
      if (id.value == 1) {
        requestAmountValue =
            double.parse(paymentArguments.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue =
            double.parse(amountController.text.toString().trim());
      }
    } else {
      requestAmountValue =
          double.parse(amountController.text.toString().trim());
    }

    if (await _connectionInfo.isConnected) {
      NotesEntity notesEntity = NotesEntity(
        loanName: paymentArguments.loanName,
        amount: requestAmountValue.toString(),
        isForInterest: paymentArguments.isMarginShortfall!
            ? "0"
            : paymentArguments.isForInterest.toString(),
        loanMarginShortfallName: paymentArguments.marginShortfallLoanName,
      );
      PaymentRequestEntity paymentRequestEntity = PaymentRequestEntity(
          amount: newAmount, currency: "INR", notes: notesEntity);
      showDialogLoading(Strings.please_wait);
      DataState<PaymentResponseEntity> paymentResponse =
          await _createOrderIdUseCase.call(
              PaymentRequestParams(paymentRequestEntity: paymentRequestEntity));
      Get.back();
      if (paymentResponse is DataSuccess) {
        if (paymentResponse.data != null) {
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = paymentArguments.loanName;
          parameter[Strings.payment_amount] = amount.toStringAsFixed(2);
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.payment_in_process, parameter);

          orderId = paymentResponse.data!.id;
          paymentAmount = paymentResponse.data!.amount;
          if (orderId != null) {
            createPaymentRequest(IsFailedEntity(), Strings.create_loan_transaction);
          } else {
            Utility.showToastMessage(Strings.something_went_wrong);
          }
        }
      } else if (paymentResponse is DataFailed) {
        if (paymentResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(paymentResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }

    /*Notes notes = Notes(
        paymentArguments.loanName,
        requestAmountValue.toString(),
        paymentArguments.isMarginShortfall!
            ? "0"
            : paymentArguments.isForInterest.toString(),
        paymentArguments.marginShortfallLoanName);
    PaymentRequest requestBean = PaymentRequest(newAmount, "INR", notes);
    paymentBloc.createOrderID(requestBean).then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        debugPrint("Order ID response : ${value.toJson()}");
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = paymentArguments.loanName;
        parameter[Strings.payment_amount] = amount.toStringAsFixed(2);
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.payment_in_process, parameter);

        orderId = value.id;
        paymentAmount = value.amount;
        if (orderId != null) {
          createPaymentRequest(IsFailed(), Strings.create_loan_transaction);
        } else {
          Utility.showToastMessage(Strings.something_went_wrong);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });*/
  }

  void openCheckout(amount, orderID) async {
    String? baseURL = await preferences.getBaseURL();
    var options = {
      'key': baseURL == Apis.baseUrlProd
          ? 'rzp_live_55JW5NYsUIguyM'
          : 'rzp_test_PWqvSLj4rnBOaG',
      // 'key': 'rzp_live_55JW5NYsUIguyM',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'LMS',
      'order_id': orderID, // Generate order_id using Orders API
      'description': 'Payment',
      'prefill': {'contact': '+91$mobileNumber', 'email': emailId},
      //ToDo need to activated wallet from Razorpay dashboard
//      'external': {
//        'wallets': ['paytm']
//      }
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint("_razorpayE$e");
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (BuildContext contex) => DashBoard()));
        Get.offNamed(dashboardView);
        Utility.showToastMessage(Strings.payment_successful);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("========> Payment Failure Response <==========");
    debugPrint(response.message!);
    IsFailedEntity isFailedEntity = IsFailedEntity();
    if (Platform.isAndroid) {
      Map<String, dynamic> map = json.decode(response.message!);
      Map<String, dynamic> data = map["error"];
      debugPrint("handlePaymentError ==> $data");
      isFailedEntity = IsFailedEntity(
          code: data["code"],
          description: data["description"],
          source: data["source"],
          step: data["step"],
          reason: data["reason"]);
    } else {
      isFailedEntity = IsFailedEntity(description: response.message!);
    }
    debugPrint("isFailed ==> ${jsonEncode(isFailedEntity)}");

    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        createPaymentRequest(isFailedEntity, "");
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utility.showToastMessage("EXTERNAL_WALLET: " + response.walletName!);
  }

  void createPaymentRequest(IsFailedEntity isFailed, String isComingFor) async {
    var requestAmountValue;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    if (paymentArguments.isMarginShortfall!) {
      if (id.value == 1) {
        requestAmountValue =
            double.parse(paymentArguments.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue =
            double.parse(amountController.text.toString().trim());
      }
    } else {
      requestAmountValue =
          double.parse(amountController.text.toString().trim());
    }
    if (await _connectionInfo.isConnected) {
      RazorPayRequestEntity razorPayRequestEntity = RazorPayRequestEntity(
          loanName: paymentArguments.loanName,
          amount: requestAmountValue,
          orderId: orderId,
          loanMarginShortfallName: paymentArguments.marginShortfallLoanName,
          isForInterest: paymentArguments.isMarginShortfall!
              ? 0
              : paymentArguments.isForInterest,
          loanTransactionName: isComingFor == Strings.create_loan_transaction
              ? ""
              : transaction_logID.value,
          isFailed: isFailed.description != null ? isFailed : null);

      debugPrint("request${jsonEncode(razorPayRequestEntity)}");
      showDialogLoading(Strings.please_wait);
      DataState<
          CommonResponseEntity> createPaymentReqResponse = await _createPaymentRequestUseCase
          .call(
          RazorPayRequestParams(razorPayRequestEntity: razorPayRequestEntity));
      Get.back();

      if (createPaymentReqResponse is DataSuccess) {
        if (createPaymentReqResponse.data != null) {
          //FocusScope.of(context).requestFocus(new FocusNode());
          Get.focusScope?.requestFocus(new FocusNode());
          if (isComingFor == Strings.create_loan_transaction) {
            transaction_logID.value =
            createPaymentReqResponse.data!.commonData!.loanTransactionName!;
            debugPrint("Transaction Log ID ==> $transaction_logID");
            openCheckout(paymentAmount, orderId);
          } else {
            Utility.showToastMessage(Strings.razorpay_canceled);
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.loan_number] = paymentArguments.loanName;
            parameter[Strings.payment_amount] =
                requestAmountValue.toStringAsFixed(2);
            parameter[Strings.error_message] = Strings.razorpay_canceled;
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.payment_cancel, parameter);
          }
        }
      } else if (createPaymentReqResponse is DataFailed) {
        if (createPaymentReqResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(createPaymentReqResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }


    /*RazorPayRequest request = RazorPayRequest(
        loanName: paymentArguments.loanName,
        amount: requestAmountValue,
        orderId: orderId,
        loanMarginShortfallName: paymentArguments.marginShortfallLoanName,
        isForInterest: paymentArguments.isMarginShortfall!
            ? 0
            : paymentArguments.isForInterest,
        loanTransactionName: isComingFor == Strings.create_loan_transaction
            ? ""
            : transaction_logID.value,
        isFailed: isFailed.description != null ? isFailed : null);
    debugPrint("request${jsonEncode(request)}");
    showDialogLoading(Strings.please_wait);
    paymentBloc.createPaymentRequest(request).then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        //FocusScope.of(context).requestFocus(new FocusNode());
        Get.focusScope?.requestFocus(new FocusNode());
        if (isComingFor == Strings.create_loan_transaction) {
          transaction_logID.value = value.data!.loanTransactionName!;
          debugPrint("Transaction Log ID ==> $transaction_logID");
          openCheckout(paymentAmount, orderId);
        } else {
          Utility.showToastMessage(Strings.razorpay_canceled);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = paymentArguments.loanName;
          parameter[Strings.payment_amount] =
              requestAmountValue.toStringAsFixed(2);
          parameter[Strings.error_message] = Strings.razorpay_canceled;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.payment_cancel, parameter);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  Future<void> proceedButtonClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (paymentArguments.isMarginShortfall!) {
          if (id.value == 1) {
            createOrderId(paymentArguments.minimumCashAmount, loanBalance.value);
          } else {
            if (amountController.text.toString().trim().length == 0) {
              Utility.showToastMessage(Strings.enter_payment_amount);
            } else {
              double amount =
                  double.parse(amountController.text.toString().trim());
              createOrderId(amount, loanBalance.value);
            }
          }
        } else {
          double amount = double.parse(amountController.text.toString().trim());
          createOrderId(amount, loanBalance.value);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void radioId2Selected() {
    radioButtonItem.value = 'Please enter amount';
    id.value = 2;
    isAmountFieldVisible.value = true;
    isSubmitBtnClickable.value = true;
  }

  void radioId1Selected() {
    radioButtonItem.value = 'Full Amount';
    id.value = 1;
    isAmountFieldVisible.value = false;
    isSubmitBtnClickable.value = false;
    amountController.text = "";
  }

  amountValueChanged() {
    // _amountController.selection = new TextSelection(baseOffset: value.length, extentOffset: value.length);
    if (paymentArguments.isMarginShortfall!) {
      if (amountController.text.isEmpty) {
        isSubmitBtnClickable.value = true;
      } else if (double.parse(amountController.text.toString().trim()) == 0.0) {
        isSubmitBtnClickable.value = true;
      } else if (double.parse(amountController.text.toString().trim()) >
          loanBalance.value) {
        isSubmitBtnClickable.value = true;
        Utility.showToastMessage(
            Strings.payment_greater_than + " " "${loanBalance.value}");
      } else {
        isSubmitBtnClickable.value = false;
      }
    } else {
      if (amountController.text.isEmpty) {
        isSubmitBtnClickable.value = true;
        // } else if (double.parse(_amountController.text.toString().trim()) > loanBalance && widget.isForInterest == 1) {
        //   isSubmitBtnClickable = true;
        //   Utility.showToastMessage(Strings.payment_greater_than + " " "${loanBalance}");
      } else if (double.parse(amountController.text.toString().trim()) == 0.0) {
        isSubmitBtnClickable.value = true;
      } else {
        isSubmitBtnClickable.value = false;
      }
    }
  }

  void getLoanDetails(String loanName) async {
    debugPrint("loanName ===> $loanName");
    if (await _connectionInfo.isConnected) {
      LoanDetailsRequestEntity loanDetailsRequestEntity =
          LoanDetailsRequestEntity(
        loanName: loanName,
      );
      DataState<LoanDetailsResponseEntity> loanDetailsResponse =
          await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
              loanDetailsRequestEntity: loanDetailsRequestEntity));

      if (loanDetailsResponse is DataSuccess) {
        if (loanDetailsResponse.data!.data != null) {
          loanDetailData.value = loanDetailsResponse.data!.data!;
          drawingPower = loanDetailData.value!.loan!.drawingPower!;
          drawingPowerStr = loanDetailData.value!.loan!.drawingPowerStr!;
          sanctionedLimit = numberToString(loanDetailData.value!.loan!.sanctionedLimit!.toStringAsFixed(2));
          loanBalance.value = loanDetailData.value!.loan!.balance!;
          print("loanBalance => ${loanBalance.value}");
          print("loanBalance => ${loanDetailData.value!.loan!.balance!}");
        }
      } else if (loanDetailsResponse is DataFailed) {
        if (loanDetailsResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(loanDetailsResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
