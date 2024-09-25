import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/approved_securities_response_entity.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';

class ApprovedSecuritiesController extends GetxController {
  final ConnectionInfo _connectionInfo;

  ApprovedSecuritiesController(this._connectionInfo);

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<RxString> filterList = <RxString>[].obs;
  RxList<RxString> securityCategoryList = <RxString>[].obs;
  RxList<ApprovedSecuritiesListResponseEntity> approvedSecurityList =
      <ApprovedSecuritiesListResponseEntity>[].obs;

  RxBool isComingFromFilter = false.obs;
  RxBool isComingFromSearch = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreData = false.obs;
  RxBool isAPICalling = false.obs;

  RxString filterName = "".obs;
  RxString searchName = "".obs;
  RxString currentInstrument = "".obs;
  RxString pdfUrl = "".obs;

  RxInt start = 0.obs;
  RxInt searchStart = 0.obs;

  Preferences preferences = Preferences();

  List<DropdownMenuItem<String>>? dropDownInstrument;
  List instrumentTypeList = [
    "Equity",
    "Mutual Fund - Equity",
    "Mutual Fund - Debt"
  ];

  FocusNode focusNode = FocusNode();

  List<DropdownMenuItem<String>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in instrumentTypeList) {
      items.add(
        DropdownMenuItem(
          value: status,
          child: Text(
            status,
            style: regularTextStyle_14_gray,
          ),
        ),
      );
    }
    return items;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    dropDownInstrument = getDropDownFormatMenuItems();

    super.onInit();
  }

  Future<void> onScrollGetApprovedSecuritiesList() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isMoreData.value = true;
      }
      if(await _connectionInfo.isConnected){
        searchStart.value = searchStart.value + 20;
      }else{
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}
