import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';

class ApprovedSecuritiesController extends GetxController {
  ApprovedSecuritiesController();

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<RxString> filterList = <RxString>[].obs;
  RxList<RxString> securityCategoryList = <RxString>[].obs;

  RxBool isComingFromFilter = false.obs;
  RxBool isComingFromSearch = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreData = false.obs;

  RxString filterName = "".obs;
  RxString searchName = "".obs;
  RxString currentInstrument = "".obs;
  RxString pdfUrl = "".obs;

  RxInt start = 0.obs;
  RxInt searchStart = 0.obs;

  Preferences preferences = Preferences();

  FocusNode focusNode = FocusNode();
}
