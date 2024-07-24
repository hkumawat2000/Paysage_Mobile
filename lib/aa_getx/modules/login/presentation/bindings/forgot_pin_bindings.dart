import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/forgot_pin_usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_forgot_pin_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/forogt_pin_controller.dart';

class ForgotPinBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginDataSourceImpl>(
      () => LoginDataSourceImpl(),
    );

    Get.lazyPut<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(
        Get.find<LoginDataSourceImpl>(),
      ),
    );

    Get.lazyPut<ForgotPinUsecase>(
        () => ForgotPinUsecase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut<VerifyForgotPinUsecase>(
        () => VerifyForgotPinUsecase(Get.find<LoginRepositoryImpl>()));

    

    Get.lazyPut<ForgotPinController>(
      () => ForgotPinController(
        Get.find<ForgotPinUsecase>(),
        Get.find<VerifyForgotPinUsecase>(),
        Get.find<ConnectionInfo>(),
      ),
    );
  }
}