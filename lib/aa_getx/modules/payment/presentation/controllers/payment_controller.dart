
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/payment/presentation/arguments/payment_arguments.dart';
import 'package:lms/network/requestbean/PaymentRequest.dart';
import 'package:lms/network/requestbean/RazorPayRequest.dart';
import 'package:lms/payment/PaymentBloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController{
  Razorpay? _razorpay;
  final paymentBloc = PaymentBloc();
  var orderId, paymentAmount, drawingPower, drawingPowerStr, sanctionedLimit,
      minimumPayAmount, loanBalanceAmt;
  double? loanBalance;
  TextEditingController amountController = TextEditingController();
  RxBool isSubmitBtnClickable = true.obs;
  FocusNode focusNode = FocusNode();
  RxInt id = 1.obs;
  RxString radioButtonItem = 'Full Amount'.obs;
  RxBool isAmountFieldVisible = false.obs;
  Preferences preferences = Preferences();
  RxString transaction_logID = "".obs, emailId = "".obs, mobileNumber = "".obs;
  PaymentArguments paymentArguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getPreferenceData();
    if(paymentArguments.isMarginShortfall!){
      radioButtonItem.value = 'Full Amount';
      id.value = 1;
      isAmountFieldVisible.value = false;
      isSubmitBtnClickable.value = false;
      amountController.text = "";
    }
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        paymentBloc.getLoanDetails(paymentArguments.loanName);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  getPreferenceData() async {
    var email = await preferences.getEmail();
    var mobile = await preferences.getMobile();

    emailId.value = email;
    mobileNumber.value = mobile!;
  }

  void createOrderId(amount, loanBalance) {
    if(paymentArguments.isMarginShortfall!){
      if (amount > loanBalance) {
        Utility.showToastMessage(Strings.payment_greater_than + " " "$loanBalance");
      } else {
        createOrder(amount);
      }
    } else{
      createOrder(amount);
    }
  }

  createOrder(amount) async {
    var newAmount = amount * 100;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    showDialogLoading( Strings.please_wait);
    double requestAmountValue;
    if (paymentArguments.isMarginShortfall!) {
      if (id == 1) {
        requestAmountValue = double.parse(paymentArguments.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue = double.parse(amountController.text.toString().trim());
      }
    } else {
      requestAmountValue = double.parse(amountController.text.toString().trim());
    }
    Notes notes = Notes(paymentArguments.loanName,
        requestAmountValue.toString(),
        paymentArguments.isMarginShortfall! ? "0" : paymentArguments.isForInterest.toString() ,
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
    });
  }


  void openCheckout(amount, orderID) async {
    String? baseURL = await preferences.getBaseURL();
    var options = {
      'key': baseURL == Apis.baseUrlProd ? 'rzp_live_55JW5NYsUIguyM' : 'rzp_test_PWqvSLj4rnBOaG',
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
    IsFailed isFailed = IsFailed();
    if(Platform.isAndroid){
      Map<String, dynamic> map = json.decode(response.message!);
      Map<String, dynamic> data = map["error"];
      debugPrint("handlePaymentError ==> $data");
      isFailed = IsFailed(code:data["code"], description: data["description"], source: data["source"], step: data["step"], reason: data["reason"] );
    } else {
      isFailed = IsFailed(description: response.message!);
    }
    debugPrint("isFailed ==> ${jsonEncode(isFailed)}");

    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        createPaymentRequest(isFailed, "");
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utility.showToastMessage("EXTERNAL_WALLET: " + response.walletName!);
  }

  void createPaymentRequest(IsFailed isFailed, String isComingFor) async {
    var requestAmountValue;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    if (paymentArguments.isMarginShortfall!) {
      if (id == 1) {
        requestAmountValue = double.parse(paymentArguments.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue = double.parse(amountController.text.toString().trim());
      }
    } else {
      requestAmountValue = double.parse(amountController.text.toString().trim());
    }
    RazorPayRequest request = RazorPayRequest(
        loanName: paymentArguments.loanName,
        amount: requestAmountValue,
        orderId: orderId,
        loanMarginShortfallName: paymentArguments.marginShortfallLoanName,
        isForInterest: paymentArguments.isMarginShortfall! ? 0: paymentArguments.isForInterest,
        loanTransactionName: isComingFor == Strings.create_loan_transaction ? "" : transaction_logID.value,
        isFailed: isFailed.description != null ? isFailed : null);
    debugPrint("request${jsonEncode(request)}");
    showDialogLoading( Strings.please_wait);
    paymentBloc.createPaymentRequest(request).then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        //FocusScope.of(context).requestFocus(new FocusNode());
        Get.focusScope?.requestFocus(new FocusNode());
        if(isComingFor == Strings.create_loan_transaction){
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
          parameter[Strings.payment_amount] = requestAmountValue.toStringAsFixed(2);
          parameter[Strings.error_message] = Strings.razorpay_canceled;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.payment_cancel, parameter);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
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
          if (id == 1) {
            createOrderId(paymentArguments.minimumCashAmount, loanBalance);
          } else {
            if (amountController.text.toString().trim().length == 0) {
              Utility.showToastMessage(Strings.enter_payment_amount);
            } else {
              double amount = double.parse(amountController.text.toString().trim());
              createOrderId(amount, loanBalance);
            }
          }
        } else {
          double amount = double.parse(amountController.text.toString().trim());
          createOrderId(amount, loanBalance);
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
        } else if (double.parse(amountController.text.toString().trim()) > loanBalance!) {
          isSubmitBtnClickable.value = true;
          Utility.showToastMessage(Strings.payment_greater_than + " " "$loanBalance");
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
}