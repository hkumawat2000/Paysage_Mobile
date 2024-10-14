import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/risk_profile/presentation/controllers/risk_profile_controller.dart';

class RiskProfileView extends GetView<RiskProfileController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(backgroundColor: colorBg),
      body: Obx(
          () => controller.isApiCalling.value
              ? Center(child: Text(Strings.please_wait))
              : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Text("Risk Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: controller.riskCategoryDataList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.riskCategoryDataList[index].category!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 2),
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text(controller.riskCategoryDataList[index].category!),
                                      style: mediumTextStyle_18,
                                      focusColor: appTheme,
                                      items: controller.riskCategoryDataList[index].subCategoryList!.map((menu) =>
                                          DropdownMenuItem<String>(
                                            child: Text(menu),
                                            value: menu,
                                          ),
                                      ).toList() ?? [],
                                      onChanged: (value) => controller.dropDownOnChange(index, value!),
                                      value: controller.riskSubCategoryResultList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),
                    ),
                    foregroundColor: colorWhite,
                    backgroundColor: appTheme,
                  ),
                  child: Text("Submit",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () => controller.submitData(),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

}