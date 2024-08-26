import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';

class CibilView extends GetView<CibilController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(controller.emptyStr),
            SizedBox(height: 30),
            Center(
              child: Text("Check your CIBIL score for free.\nIt takes less than a minute",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.1
                ),
                color: colorLightGray2,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: colorGreen, size: 18),
                      SizedBox(width: 10),
                      Expanded(child: Text("Your CIBIL score does not decrease after you check it.")),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: colorGreen, size: 18),
                      SizedBox(width: 10),
                      Expanded(child: Text("Paysage.ai does not share credit report data with any third party")),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Text("")),
            // Spacer(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                controller.cibilCheckOTPApi();
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
                child: Center(child: Text("Check your score now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}