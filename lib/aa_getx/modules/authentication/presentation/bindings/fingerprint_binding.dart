
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/controllers/fingerprint_controller.dart';

class FingerprintBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FingerPrintController>(() => FingerPrintController());
  }

}