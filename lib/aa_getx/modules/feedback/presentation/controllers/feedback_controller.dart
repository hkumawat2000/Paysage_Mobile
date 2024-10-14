import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? commentController = TextEditingController();
  RxBool firstCheck = false.obs;
  RxBool secondCheck = false.obs;
  RxBool firstCheckVisibility = false.obs;
  RxBool secondCheckVisibility = false.obs;
  RxBool userExperienceCheck = false.obs;
  RxBool functionalityCheck = false.obs;
  RxBool otherCheck = false.obs;
  RxBool suggestionsVisibility = false.obs;
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
}