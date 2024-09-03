import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanStatementScreenTabController extends GetxController with GetSingleTickerProviderStateMixin{
  RxString loanName = "".obs;
  RxString loanType = "".obs;
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void onClose() {
    super.onClose();
    tabController?.dispose();
  }
}