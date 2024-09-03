
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/payment_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/payment_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/razor_pay_request_entity.dart';

abstract class PaymentRepository {
  ResultFuture<LoanDetailsResponseEntity> getLoanDetails(LoanDetailsRequestEntity loanDetailsRequestEntity);

  ResultFuture<PaymentResponseEntity> createOrderID(PaymentRequestEntity paymentRequestEntity);

  ResultFuture<CommonResponseEntity> createPaymentRequest(RazorPayRequestEntity razorPayRequestEntity);

}