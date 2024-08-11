import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSettingsController extends GetxController{
  ManageSettingsController();

     final scaffoldKey = GlobalKey<ScaffoldState>();
  RxString instrumentType = "".obs;
  RxString loanApplicationStatus = "".obs;
  RxString pledgorBoid = "".obs;
  RxString myCamsEmail= "".obs;
  RxString loanName = "".obs;
}