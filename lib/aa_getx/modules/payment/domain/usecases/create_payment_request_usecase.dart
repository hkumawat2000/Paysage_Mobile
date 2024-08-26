import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/razor_pay_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/repositories/payment_repository.dart';

class CreatePaymentRequestUseCase
    extends UsecaseWithParams<CommonResponseEntity, RazorPayRequestParams> {
  final PaymentRepository paymentRepository;

  CreatePaymentRequestUseCase(this.paymentRepository);

  @override
  ResultFuture<CommonResponseEntity> call(RazorPayRequestParams params) async {
    return await paymentRepository.createPaymentRequest(params.razorPayRequestEntity);
  }
}

class RazorPayRequestParams {
  final RazorPayRequestEntity razorPayRequestEntity;

  RazorPayRequestParams({required this.razorPayRequestEntity});
}
