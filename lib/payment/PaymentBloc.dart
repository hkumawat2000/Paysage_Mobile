import 'dart:async';

import 'package:lms/network/requestbean/PaymentRequest.dart';
import 'package:lms/network/requestbean/RazorPayRequest.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/PaymentResponse.dart';
import 'package:lms/payment/PaymentRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

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