import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';

class CibilView extends GetView<CibilController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Center(
        child: MaterialButton(
          onPressed: () => controller.cibilCheckApi(),
          child: Text("CIBIL..."),
        ),
      ),
    );
  }

}