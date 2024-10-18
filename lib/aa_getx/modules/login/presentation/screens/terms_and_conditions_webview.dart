import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/terms_and_conditions_webview_controller.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class TermsAndConditionsWebview
    extends GetView<TermsAndConditionsWebviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        children: [
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: ArrowToolbarBackwardNavigation(),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: scripsNameText(controller.isComingFor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                child: Image.asset(AssetsImagePath.app_icon,
                    width: 37, height: 37),
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => Container(
                  child: controller.url != null
                      ? controller.isLoading.isFalse
                          ? PDFViewer(
                              document: controller.pdfDocument!,
                              zoomSteps: 1,
                              scrollDirection: Axis.vertical)
                          : Center(child: CircularProgressIndicator())
                      : Center(child: Text("No Data"))),
            ),
          ),
        ],
      ),
    );
  }
}
