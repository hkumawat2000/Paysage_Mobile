import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/payment/data/data_sources/payment_data_source.dart';
import 'package:lms/aa_getx/modules/payment/data/repositories/payment_repository_impl.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/create_order_id_usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/create_payment_request_usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/payment/presentation/controllers/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentApiImpl>(() => PaymentApiImpl());

    Get.lazyPut<PaymentRepositoryImpl>(
        () => PaymentRepositoryImpl(Get.find<PaymentApiImpl>()));

    Get.lazyPut<GetLoanDetailsPayUseCase>(
        () => GetLoanDetailsPayUseCase(Get.find<PaymentRepositoryImpl>()));

    Get.lazyPut<CreateOrderIdUseCase>(
        () => CreateOrderIdUseCase(Get.find<PaymentRepositoryImpl>()));

    Get.lazyPut<CreatePaymentRequestUseCase>(
        () => CreatePaymentRequestUseCase(Get.find<PaymentRepositoryImpl>()));

    Get.lazyPut<PaymentController>(() => PaymentController(
          Get.find<ConnectionInfo>(),
          Get.find<GetLoanDetailsPayUseCase>(),
          Get.find<CreateOrderIdUseCase>(),
          Get.find<CreatePaymentRequestUseCase>(),
        ));
  }
}
