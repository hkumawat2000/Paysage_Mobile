import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_otp_controller.dart';

class CibilOtpBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CibilOtpController>(() =>
        CibilOtpController(

        ),
    );
  }

}