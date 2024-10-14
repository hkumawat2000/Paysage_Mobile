import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/controllers/contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());

  }

}