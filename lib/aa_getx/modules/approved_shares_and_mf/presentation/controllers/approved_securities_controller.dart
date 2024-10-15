import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/approved_securities_response_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/request/approved_securities_request_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/usecases/get_approved_securities_list_usecase.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';

class ApprovedSecuritiesController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final GetApprovedSecuritiesListUsecase _getApprovedSecuritiesListUsecase;

  ApprovedSecuritiesController(
      this._connectionInfo, this._getApprovedSecuritiesListUsecase);

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
  final _listControllerSecurityCategory =
      StreamController<ApprovedSecuritiesDataResponseEntity>.broadcast();
  get listSecurityCategory => _listControllerSecurityCategory.stream;

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
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isMoreData.value = true;
        if (await _connectionInfo.isConnected) {
          searchStart.value = searchStart.value + 20;
          ApprovedSecuritiesRequestEntity approvedSecuritiesRequestEntity =
              ApprovedSecuritiesRequestEntity(
                  lender: "Choice Finserv",
                  start: searchStart.value,
                  perPage: 20,
                  search: searchName.value,
                  isDownload: 0,
                  loanType: currentInstrument.value,
                  category: filterName.value);
          DataState<ApprovedSecuritiesResponseEntity> response =
              await _getApprovedSecuritiesListUsecase.call(
            GetApprovedSecuritiesListParams(
                approvedSecuritiesRequestEntity:
                    approvedSecuritiesRequestEntity),
          );

          if (response is DataSuccess) {
            if (response.data!.data!.approvedSecuritiesList!.length != 0) {
              approvedSecurityList
                  .addAll(response.data!.data!.approvedSecuritiesList!);
            }

            if (response.data!.data!.approvedSecuritiesList!.length < 20) {
              isMoreData.value = false;
            } else {
              isMoreData.value = true;
            }
          }
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      }
    });
    super.onInit();
  }



  Future<void> onScrollGetApprovedSecuritiesList() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isMoreData.value = true;
      }
      if (await _connectionInfo.isConnected) {
        searchStart.value = searchStart.value + 20;
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> getDirectApprovedSecuritesList(bool isSearch) async {
    if (await _connectionInfo.isConnected) {
      ApprovedSecuritiesRequestEntity approvedSecuritiesRequestEntity =
          ApprovedSecuritiesRequestEntity(
              lender: "Choice Finserv",
              start: 0,
              perPage: 20,
              search: isSearch ? searchName.value : "",
              isDownload: 1,
              loanType: currentInstrument.value,
              category: filterName.value);

      DataState<ApprovedSecuritiesResponseEntity> response =
          await _getApprovedSecuritiesListUsecase.call(
        GetApprovedSecuritiesListParams(
            approvedSecuritiesRequestEntity: approvedSecuritiesRequestEntity),
      );
      if (response is DataSuccess) {
        pdfUrl.value = response.data!.data!.pdfFileUrl!;
        filterList.clear();
        filterList.add(Strings.clear_filter.obs);
        //In the below code the List<String> is converted to RxString
        filterList.addAll(
            response.data!.data!.securityCategoryList!.map((str) => str.obs));
        _listControllerSecurityCategory.sink.add(response.data!.data!);
        isAPICalling.value = false;
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          isAPICalling.value = false;
          commonDialog(Strings.session_timeout, 4);
        } else {
          pdfUrl.value = "";
          _listControllerSecurityCategory.sink
              .addError(response.error!.message);
          isAPICalling.value = false;
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> getApprovedSecuritesList() async {
    if (await _connectionInfo.isConnected) {
      ApprovedSecuritiesRequestEntity approvedSecuritiesRequestEntity =
          ApprovedSecuritiesRequestEntity(
              lender: "Choice Finserv",
              start: start.value,
              perPage: 20,
              search: "",
              isDownload: 0,
              loanType: currentInstrument.value,
              category: filterName.value);
      DataState<ApprovedSecuritiesResponseEntity> response =
          await _getApprovedSecuritiesListUsecase.call(
        GetApprovedSecuritiesListParams(
            approvedSecuritiesRequestEntity: approvedSecuritiesRequestEntity),
      );

      if (response is DataSuccess) {
        approvedSecurityList.clear();
        approvedSecurityList
            .addAll(response.data!.data!.approvedSecuritiesList!);
        if (response.data!.data!.approvedSecuritiesList!.length < 20) {
          isMoreData.value = false;
        } else {
          isMoreData.value = true;
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
