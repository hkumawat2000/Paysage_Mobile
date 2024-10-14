import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {

  TextEditingController? searchController = TextEditingController();
  TextEditingController? messageController = TextEditingController();

  RxString contactUsMessageTxt = "".obs;

  contactUsAPI(){


  }
}