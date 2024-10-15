import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/webview/presentation/controller/common_webview_controller.dart';

class CommonWebviewBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CommonWebviewController>(() => CommonWebviewController(

    ));

  }

}