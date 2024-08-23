import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/modules/webview/presentation/arguments/common_webview_arguments.dart';
import 'package:lms/aa_getx/modules/webview/presentation/controller/common_webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewView extends GetView<CommonWebviewController> {
  CommonWebviewView();

  CommonWebviewArguments commonWebviewArguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        controller.willPopCallback();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: ArrowToolbarBackwardNavigation(),
              onPressed: () => Get.back(result: "cancel")
              // Navigator.pop(context, "cancel"),
              ),
          backgroundColor: colorBg,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
              commonWebviewArguments.title != null
                  ? commonWebviewArguments.title!
                  : "",
              style: TextStyle(color: appTheme)),
        ),
        body: controller.baseUrlString.isEmpty
            ? Center(child: Text(Strings.please_wait))
            : getPrivacyPolicyUrl(),
      ),
    );
  }

  Widget getPrivacyPolicyUrl() {
    //1 = FAQ,
    //2 = Privacy Policy
    //3 = Terms of Use

    return Column(
      children: [
        Expanded(
          child: WebViewWidget(controller: controller.controller),
        ),
      ],
    );
  }
}
