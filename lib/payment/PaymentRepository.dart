import 'package:choice/network/requestbean/PaymentRequest.dart';
import 'package:choice/network/requestbean/RazorPayRequest.dart';
import 'package:choice/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/PaymentResponse.dart';
import 'package:choice/payment/PaymentDao.dart';

class PaymentRepository {
  final paymentDao = PaymentDao();

  Future<PaymentResponse> createOrderID(PaymentRequest request) => paymentDao.createOrderID(request);
  Future<CommonResponse> createPaymentRequest(RazorPayRequest request) =>
      paymentDao.createPaymentRequest(request);
  Future<CommonResponse> createInterestPaymentRequest(RazorPayRequest request) => paymentDao.createInterestPaymentRequest(request);
  Future<LoanDetailsResponse> getLoanDetails(loanName) =>
      paymentDao.getLoanDetails(loanName);
}