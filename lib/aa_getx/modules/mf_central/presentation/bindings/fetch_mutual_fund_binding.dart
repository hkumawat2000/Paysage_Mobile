import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/fetch_mutual_fund_controller.dart';

class FetchMutualFundBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<FetchMutualFundController>(() =>
        FetchMutualFundController(

        ),
    );
  }

}