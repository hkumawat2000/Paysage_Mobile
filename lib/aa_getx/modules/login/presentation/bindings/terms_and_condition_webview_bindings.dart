import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/terms_and_conditions_webview_controller.dart';

class TermsAndConditionWebviewBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TermsAndConditionsWebviewController>( () => TermsAndConditionsWebviewController(Get.find<ConnectionInfo>(),),);
  }
}