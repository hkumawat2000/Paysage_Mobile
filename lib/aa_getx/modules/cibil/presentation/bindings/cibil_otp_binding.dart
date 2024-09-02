import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/cibil/data/repositories/cibil_repository_impl.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_otp_verification_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_otp_controller.dart';

class CibilOtpBinding extends Bindings {

  @override
  void dependencies() {


    Get.lazyPut<CibilOtpVerificationUsecase>(
            () => CibilOtpVerificationUsecase(Get.find<CibilRepositoryImpl>()));

    Get.lazyPut<CibilOtpController>(() => CibilOtpController(
        Get.find<CibilOtpVerificationUsecase>()));
  }

}