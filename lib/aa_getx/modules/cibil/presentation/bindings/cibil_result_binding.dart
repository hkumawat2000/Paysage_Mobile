import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';

class CibilResultBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CibilResultController>(() =>
        CibilResultController(
        ),
    );
  }

}