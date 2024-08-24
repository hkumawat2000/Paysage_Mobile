import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';

class CibilResultView extends GetView<CibilResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Your Credit Report", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20),
                    Obx(() => Center(child: Text(controller.cibilScoreResult.value, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),))),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.1
                  ),
                  color: colorLightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsets.all(10),
                child: Center(child: Text("Check new score", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}