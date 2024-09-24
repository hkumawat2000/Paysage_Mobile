import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/risk_profile/presentation/controllers/risk_profile_controller.dart';

class RiskProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiskProfileController>(() => RiskProfileController());
  }
}
