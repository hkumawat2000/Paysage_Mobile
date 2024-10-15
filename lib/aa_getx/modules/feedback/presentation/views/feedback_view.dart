import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/controllers/feedback_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/common_widgets.dart';
import '../../../../core/utils/utility.dart';

class FeedbackView extends GetView<FeedbackController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: colorBg,
          elevation: 0.0,
          // centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: headingText("Feedback"),
                    ),
                  ],
                ),
                SizedBoxHeightWidget(10.0),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Please give your valuable feedback"),
                    ),
                  ],
                ),
                SizedBoxHeightWidget(20.0),
                firstCheckBox(),
                Obx(() => Visibility(visible: controller.firstCheckVisibility.value, child: firstFeedBackData())),
                SizedBoxHeightWidget(10.0),
                secondCheckBox(),
                Obx(() => Visibility(visible: controller.secondCheckVisibility.value, child: secondFeedBackData())),
                SizedBoxHeightWidget(50.0),
                submitFeedback(),
                SizedBoxHeightWidget(50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstCheckBox() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          children: [
            Checkbox(
                value: controller.firstCheck.value,
                activeColor: appTheme,
                onChanged: controller.firstCheckBoxOnChange,
            ),
            Expanded(
              child: Text("LMS have hit the bull's eye with the product",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget secondCheckBox() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          children: [
            Checkbox(
                value: controller.secondCheck.value,
                activeColor: appTheme,
                onChanged: controller.secondCheckBoxOnChange,
            ),
            Expanded(
              child: Text('LMS can do better', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstFeedBackData() {
    return Column(
      children: [
        Text('Thank you for appreciating our hard work!!'),
        suggestions(),
      ],
    );
  }

  Widget secondFeedBackData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Text("You can help us improve our product. Please select"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Column(
            children: [
              userExperienceCheckBox(),
              functionalityCheckBox(),
              otherCheckBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: suggestions(),
        ),
      ],
    );
  }

  Widget userExperienceCheckBox() {
    return Obx(
      () => Row(
        children: [
          Checkbox(
              value: controller.userExperienceCheck.value,
              activeColor: appTheme,
              onChanged: controller.userExperienceCheckBoxOnChange,
          ),
          Expanded(
            child: Text('Related to User Experience'),
          ),
        ],
      ),
    );
  }

  Widget functionalityCheckBox() {
    return Obx(
      () => Row(
        children: [
          Checkbox(
              value: controller.functionalityCheck.value,
              activeColor: appTheme,
              onChanged: controller.functionalityCheckBoxOnChange,
          ),
          Expanded(
            child: Text('Related to Functionality'),
          ),
        ],
      ),
    );
  }

  Widget otherCheckBox() {
    return Obx(
      () => Row(
        children: [
          Checkbox(
              value: controller.otherCheck.value,
              activeColor: appTheme,
              onChanged: controller.otherCheckBoxOnChange,
          ),
          Expanded(
            child: Text('Others'),
          ),
        ],
      ),
    );
  }

  Widget suggestions() {
    return Obx(
      () => Visibility(
        visible: controller.suggestionsVisibility.value,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 6, 10, 10),
          child: Container(
            height: 120,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: SizedBox(
                  height: 115.0,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    controller: controller.commentController,
                    maxLength: 500,
                    maxLines: 50,
                    decoration: InputDecoration(
                      hintText: "You can write your suggestions to us:",
                      hintStyle: TextStyle(fontSize: 12),
                      border: InputBorder.none,
                    ),
                    onTap: (){
                      if(controller.commentController!.text.length <= 500){
                        controller.submitText = controller.commentController!.text;
                      } else {
                        controller.commentController!.text = controller.submitText;
                        FocusScope.of(Get.context!).unfocus();
                      }
                    },
                    onChanged: (val){
                      controller.commentTxt.value = controller.commentController!.text;
                      if(controller.commentController!.text.length <= 500){
                        controller.submitText = controller.commentController!.text;
                      } else {
                        controller.commentController!.text = controller.submitText;
                        FocusScope.of(Get.context!).unfocus();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget submitFeedback() {
    return Obx(
      () => Container(
        height: 45,
        width: 145,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: controller.commentTxt.value.isEmpty ? colorGrey : appTheme,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(Get.context!).size.width,
            onPressed: controller.submitFeedbackData,
            child: Text(
              Strings.submit,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

}