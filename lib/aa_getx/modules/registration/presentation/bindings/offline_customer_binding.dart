import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/offline_customer_controller.dart';

class OfflineCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfflineCustomerController>(() => OfflineCustomerController());
  }
}
