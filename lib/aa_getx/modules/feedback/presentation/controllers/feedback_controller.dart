import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/arguments/feedback_argument.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/utility.dart';

class FeedbackController extends GetxController {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? commentController = TextEditingController();
  RxString commentTxt = "".obs;
  RxBool firstCheck = false.obs;
  RxBool secondCheck = false.obs;
  RxBool firstCheckVisibility = false.obs;
  RxBool secondCheckVisibility = false.obs;
  RxBool userExperienceCheck = false.obs;
  RxBool functionalityCheck = false.obs;
  RxBool otherCheck = false.obs;
  RxBool suggestionsVisibility = false.obs;
  FeedbackArgument feedbackArgument = Get.arguments;
  var submitText = '';
  String main = '', doBetter = '';

  firstCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      firstCheck.value = newValue;
      secondCheck.value = false;
      firstCheckVisibility.value = true;
      secondCheckVisibility.value = false;
      suggestionsVisibility.value = true;
      commentController!.text= "";
    } else {
      firstCheck.value = newValue;
      firstCheckVisibility.value = false;
      suggestionsVisibility.value = false;
      commentController!.text = "";
    }
  }

  secondCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      secondCheck.value = newValue;
      firstCheck.value = false;
      secondCheckVisibility.value = true;
      firstCheckVisibility.value = false;
      suggestionsVisibility.value = false;
      userExperienceCheck.value = false;
      functionalityCheck.value = false;
      otherCheck.value = false;
      commentController!.text = "";
    } else {
      secondCheck.value = newValue;
      suggestionsVisibility.value = false;
      secondCheckVisibility.value = false;
      userExperienceCheck.value = false;
      functionalityCheck.value = false;
      otherCheck.value = false;
      commentController!.text = "";
    }
  }

  userExperienceCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      userExperienceCheck.value = newValue;
      functionalityCheck.value = false;
      otherCheck.value = false;
      suggestionsVisibility.value = true;
      secondCheck.value = true;
      commentController!.text = "";
    } else {
      userExperienceCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
    }
  }

  functionalityCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      functionalityCheck.value = newValue;
      userExperienceCheck.value = false;
      otherCheck.value = false;
      suggestionsVisibility.value = true;
      secondCheck.value = true;
      commentController!.text = "";
    } else {
      functionalityCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
    }
  }

  otherCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      otherCheck.value = newValue;
      functionalityCheck.value = false;
      userExperienceCheck.value = false;
      suggestionsVisibility.value = true;
      secondCheck.value = true;
      commentController!.text = "";
    } else {
      otherCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
    }
  }

  submitFeedbackData(){
    if(commentTxt.value.length != 0){
      Utility.isNetworkConnection().then((isNetwork) {
        if (isNetwork) {
          if (commentTxt.value.length <= 500) {
            if (!firstCheck.value && !secondCheck.value) {
              Utility.showToastMessage(Strings.atleast_one_feedback);
            } else {
              if (secondCheck.value) {
                if (!userExperienceCheck.value && !functionalityCheck.value && !otherCheck.value) {
                  Utility.showToastMessage(Strings.atleast_one_favor);
                } else {
                  // sendFeedbackData();
                }
              } else {
                // sendFeedbackData();
              }
            }
          } else {
            Utility.showToastMessage(Strings.more_500_char);
          }
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
    }
  }

  // void sendFeedbackData() async {
  //   Preferences preferences = new Preferences();
  //   String email = await preferences.getEmail();
  //   String? mobile = await preferences.getMobile();
  //   LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
  //   FeedbackRequestBean? feedbackRequestBean;
  //   if (feedbackArgument.comeFrom == Strings.more_menu) {
  //     feedbackRequestBean = new FeedbackRequestBean(
  //         doNotShowAgain: widget.doNotShowAgain,
  //         bullsEye: firstCheck ? 1 : 0,
  //         canDoBetter: secondCheck ? 1 : 0,
  //         relatedToUserExperience: userExperienceCheck ? 1 : 0,
  //         relatedToFunctionality: functionalityCheck ? 1 : 0,
  //         others: otherCheck ? 1 : 0,
  //         comment: commentController!.text.toString().trim(),
  //         fromMoreMenu: 1
  //     );
  //   } else if(feedbackArgument.comeFrom == Strings.pop_up){
  //     feedbackRequestBean = new FeedbackRequestBean(
  //         doNotShowAgain: widget.doNotShowAgain,
  //         bullsEye: firstCheck ? 1 : 0,
  //         canDoBetter: secondCheck ? 1 : 0,
  //         relatedToUserExperience: userExperienceCheck ? 1 : 0,
  //         relatedToFunctionality: functionalityCheck ? 1 : 0,
  //         others: otherCheck ? 1 : 0,
  //         comment: commentController!.text.toString().trim(),
  //         fromMoreMenu: 0
  //     );
  //   }
  //   feedbackBloc.submitFeedback(feedbackRequestBean!).then((value) {
  //     Navigator.pop(context);
  //     if (value.isSuccessFull!) {
  //       // Firebase Event
  //       Map<String, dynamic> parameter = new Map<String, dynamic>();
  //       parameter[Strings.do_not_show_again_prm] = feedbackRequestBean!.doNotShowAgain;
  //       parameter[Strings.bulls_eye] = feedbackRequestBean.bullsEye;
  //       parameter[Strings.can_do_better] = feedbackRequestBean.canDoBetter;
  //       parameter[Strings.related_to_user_experience] = feedbackRequestBean.relatedToUserExperience;
  //       parameter[Strings.related_to_functionality] = feedbackRequestBean.relatedToFunctionality;
  //       parameter[Strings.others] = feedbackRequestBean.others;
  //       parameter[Strings.message] = feedbackRequestBean.comment;
  //       parameter[Strings.from_more_menu] = feedbackRequestBean.fromMoreMenu;
  //       parameter[Strings.mobile_no] = mobile;
  //       parameter[Strings.email] = email;
  //       parameter[Strings.date_time] = getCurrentDateAndTime();
  //       firebaseEvent(Strings.feedback_submit, parameter);
  //
  //       Utility.showToastMessage(value.message!);
  //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  //     } else if (value.errorCode == 403) {
  //       commonDialog(context, Strings.session_timeout, 4);
  //     } else {
  //       Utility.showToastMessage(value.errorMessage!);
  //     }
  //   });
  // }
}