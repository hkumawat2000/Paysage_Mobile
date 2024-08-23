import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';

class CibilBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CibilController>(() =>
        CibilController(
          Get.find<ConnectionInfo>(),
        ),
    );
  }

}