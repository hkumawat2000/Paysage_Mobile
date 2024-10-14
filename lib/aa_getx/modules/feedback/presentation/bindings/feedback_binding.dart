import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/controllers/feedback_controller.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }

}