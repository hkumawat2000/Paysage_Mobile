import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/payment_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/payment_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/repositories/payment_repository.dart';

class CreateOrderIdUseCase
    extends UsecaseWithParams<PaymentResponseEntity, PaymentRequestParams> {
  final PaymentRepository paymentRepository;

  CreateOrderIdUseCase(this.paymentRepository);

  @override
  ResultFuture<PaymentResponseEntity> call(PaymentRequestParams params) async {
    return await paymentRepository.createOrderID(params.paymentRequestEntity);
  }
}

class PaymentRequestParams {
  final PaymentRequestEntity paymentRequestEntity;

  PaymentRequestParams({required this.paymentRequestEntity});
}
