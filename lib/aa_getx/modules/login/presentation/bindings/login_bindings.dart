import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/get_terms_of_use_usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/login_usecases.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_otp_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/login_controller.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/otp_verification_controller.dart';

class LoginBindings implements Bindings {
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

    Get.lazyPut<LoginUseCase>(
        () => LoginUseCase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut<VerifyOtpUsecase>(
        () => VerifyOtpUsecase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut<GetTermsOfUseUsecase>(
        () => GetTermsOfUseUsecase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut<LoginController>(() => LoginController(
          Get.find<GetTermsOfUseUsecase>(),
          Get.find<LoginUseCase>(),
          Get.find<ConnectionInfo>(),
        ));

    Get.lazyPut<OtpVerificationController>(
      () => OtpVerificationController(
        Get.find<LoginUseCase>(),
        Get.find<VerifyOtpUsecase>(),
        Get.find<ConnectionInfo>(),
      ),
    );
  }
}
