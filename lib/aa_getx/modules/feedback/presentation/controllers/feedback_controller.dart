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
}