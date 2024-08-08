import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/aml_check/presentation/controllers/aml_check_controller.dart';

import '../../../../core/constants/colors.dart';

class AmlCheckView extends GetView<AmlCheckController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Center(
        child: MaterialButton(
          onPressed: () => controller.callAMLCheckApi(),
          child: Text("AML Check..."),
        ),
      ),
    );
  }

}