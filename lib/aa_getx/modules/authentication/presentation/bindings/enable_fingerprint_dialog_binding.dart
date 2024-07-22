import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/controllers/enable_fingerprint_dialog_controller.dart';

class EnableFingerprintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnableFingerPrintController>(
        () => EnableFingerPrintController());
  }
}
