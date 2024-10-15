import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';
import 'package:lms/aa_getx/modules/feedback/data/models/request/feedback_request_model.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/request/feedback_request_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/response/feedback_response_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/usecases/feedback_usecase.dart';
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

  final FeedbackUsecase feedbackUsecase;

  FeedbackController(this.feedbackUsecase);

  firstCheckBoxOnChange(bool? newValue){
    if (newValue!) {
      firstCheck.value = newValue;
      secondCheck.value = false;
      firstCheckVisibility.value = true;
      secondCheckVisibility.value = false;
      suggestionsVisibility.value = true;
      commentController!.text= "";
      commentTxt.value = "";
    } else {
      firstCheck.value = newValue;
      firstCheckVisibility.value = false;
      suggestionsVisibility.value = false;
      commentController!.text = "";
      commentTxt.value = "";
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
      commentTxt.value = "";
    } else {
      secondCheck.value = newValue;
      suggestionsVisibility.value = false;
      secondCheckVisibility.value = false;
      userExperienceCheck.value = false;
      functionalityCheck.value = false;
      otherCheck.value = false;
      commentController!.text = "";
      commentTxt.value = "";
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
      commentTxt.value = "";
    } else {
      userExperienceCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
      commentTxt.value = "";
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
      commentTxt.value = "";
    } else {
      functionalityCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
      commentTxt.value = "";
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
      commentTxt.value = "";
    } else {
      otherCheck.value = newValue;
      suggestionsVisibility.value = false;
      commentController!.text = "";
      commentTxt.value = "";
    }
  }

  submitFeedbackData(){
    if(commentTxt.value.isNotEmpty){
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
                  sendFeedbackData();
                }
              } else {
                sendFeedbackData();
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

  void sendFeedbackData() async {
    Preferences preferences = new Preferences();
    String email = await preferences.getEmail();
    String? mobile = await preferences.getMobile();
    showDialogLoading(Strings.please_wait);
    FeedbackRequestEntity? feedbackRequestEntity;
    if (feedbackArgument.comeFrom == Strings.more_menu) {
      feedbackRequestEntity = FeedbackRequestEntity(
          doNotShowAgain: feedbackArgument.doNotShowAgain,
          bullsEye: firstCheck.value ? 1 : 0,
          canDoBetter: secondCheck.value ? 1 : 0,
          relatedToUserExperience: userExperienceCheck.value ? 1 : 0,
          relatedToFunctionality: functionalityCheck.value ? 1 : 0,
          others: otherCheck.value ? 1 : 0,
          comment: commentController!.text.toString().trim(),
          fromMoreMenu: 1
      );
    } else if(feedbackArgument.comeFrom == Strings.pop_up){
      feedbackRequestEntity = FeedbackRequestEntity(
          doNotShowAgain: feedbackArgument.doNotShowAgain,
          bullsEye: firstCheck.value ? 1 : 0,
          canDoBetter: secondCheck.value ? 1 : 0,
          relatedToUserExperience: userExperienceCheck.value ? 1 : 0,
          relatedToFunctionality: functionalityCheck.value ? 1 : 0,
          others: otherCheck.value ? 1 : 0,
          comment: commentController!.text.toString().trim(),
          fromMoreMenu: 0
      );
    }

    DataState<FeedbackResponseEntity> response =
    await feedbackUsecase.call(FeedbackParams(feedbackRequestEntity: feedbackRequestEntity!));
    Get.back();
    if (response is DataSuccess) {
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.do_not_show_again_prm] = feedbackRequestEntity.doNotShowAgain;
      parameter[Strings.bulls_eye] = feedbackRequestEntity.bullsEye;
      parameter[Strings.can_do_better] = feedbackRequestEntity.canDoBetter;
      parameter[Strings.related_to_user_experience] = feedbackRequestEntity.relatedToUserExperience;
      parameter[Strings.related_to_functionality] = feedbackRequestEntity.relatedToFunctionality;
      parameter[Strings.others] = feedbackRequestEntity.others;
      parameter[Strings.message] = feedbackRequestEntity.comment;
      parameter[Strings.from_more_menu] = feedbackRequestEntity.fromMoreMenu;
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      firebaseEvent(Strings.feedback_submit, parameter);

      Utility.showToastMessage(response.data!.message!);
      Get.offAllNamed(dashboardView, arguments: DashboardArguments(
        isFromPinScreen: false,
        selectedIndex: 0,
      ));
    } else if (response is DataFailed) {
      Utility.showToastMessage(response.error!.message);
    }
  }
}