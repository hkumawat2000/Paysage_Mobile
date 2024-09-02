import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/cibil/data/data_source/cibil_data_source.dart';
import 'package:lms/aa_getx/modules/cibil/data/repositories/cibil_repository_impl.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_otp_verification_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_send_otp_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_otp_controller.dart';

class CibilBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CibilDataSourceImpl>(
          () => CibilDataSourceImpl(),
    );

    Get.lazyPut<CibilRepositoryImpl>(
          () => CibilRepositoryImpl(
        Get.find<CibilDataSourceImpl>(),
      ),
    );


    Get.lazyPut<CibilOtpVerificationUsecase>(
            () => CibilOtpVerificationUsecase(Get.find<CibilRepositoryImpl>()));

    Get.lazyPut<CibilOtpController>(() => CibilOtpController(
      Get.find<CibilOtpVerificationUsecase>()));

    Get.lazyPut<CibilSendOtpUsecase>(
            () => CibilSendOtpUsecase(Get.find<CibilRepositoryImpl>()));

    Get.lazyPut<CibilController>(() =>
        CibilController(
          Get.find<ConnectionInfo>(),
          Get.find<CibilSendOtpUsecase>(),
        ),
    );
  }

}