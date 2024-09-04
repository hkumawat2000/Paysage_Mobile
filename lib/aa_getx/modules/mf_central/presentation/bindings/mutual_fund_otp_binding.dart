import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/mutual_fund_otp_controller.dart';

class MutualFundOtpBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<MutualFundOtpController>(() =>
        MutualFundOtpController(

        ),
    );

  }

}