import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/eligible_mutual_fund_controller.dart';

class EligibleMutualFundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EligibleMutualFundController>(() => EligibleMutualFundController());
  }

}