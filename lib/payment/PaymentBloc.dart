import 'dart:async';

import 'package:choice/network/requestbean/PaymentRequest.dart';
import 'package:choice/network/requestbean/RazorPayRequest.dart';
import 'package:choice/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/PaymentResponse.dart';
import 'package:choice/payment/PaymentRepository.dart';
import 'package:choice/widgets/WidgetCommon.dart';

class PaymentBloc {
  PaymentBloc();

  final paymentRepository = PaymentRepository();
  final paymentController = StreamController<LoanDetailData>.broadcast();
  get paymentLoan => paymentController.stream;

  Future<PaymentResponse> createOrderID(PaymentRequest requestBean) async {
    PaymentResponse wrapper = await paymentRepository.createOrderID(requestBean);
    return wrapper;
  }

  Future<CommonResponse> createPaymentRequest(RazorPayRequest request) async {
    CommonResponse wrapper = await paymentRepository.createPaymentRequest(request);
    return wrapper;
  }

  Future<CommonResponse> createInterestPaymentRequest(RazorPayRequest request) async {
    CommonResponse wrapper = await paymentRepository.createInterestPaymentRequest(request);
    return wrapper;
  }

  Future<LoanDetailsResponse> getLoanDetails(loanName) async {
    LoanDetailsResponse wrapper = await paymentRepository.getLoanDetails(loanName);
    if(wrapper.isSuccessFull!){
      printLog("-----SUCESS-----");
      paymentController.sink.add(wrapper.data!);
    }else{
      printLog("-----FAIL-----");
      if (wrapper.errorCode == 403) {
        paymentController.sink.addError(wrapper.errorCode.toString());
      }
    }
    return wrapper;
  }
}