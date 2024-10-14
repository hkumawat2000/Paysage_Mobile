import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/lender/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/lender/domain/usecases/lender_usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/isin_details_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/mf_scheme_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/usecases/isin_details_usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/usecases/mf_scheme_usecase.dart';
import 'package:lms/util/Utility.dart';

class PledgeMfSchemeSelectionController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final MfSchemeUsecase mfSchemeUsecase;
  final LenderUsecase lenderUsecase;
  final IsinDetailsUsecase isinDetailsUsecase;

  PledgeMfSchemeSelectionController(
    this._connectionInfo,
    this.mfSchemeUsecase,
    this.lenderUsecase,
    this.isinDetailsUsecase,
  );

  Widget appBarTitle = new Text("", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController textController = TextEditingController();
  RxBool isDefaultBottomDialog = true.obs;
  RxBool isEligibleBottomDialog = false.obs;
  RxList<bool> isAddBtnSelected = <bool>[].obs;
  RxList<bool> isAddQtyEnable = <bool>[].obs;
  String currentMutualFundOption = Strings.equity;
  RxList<String> selectedLenderList = <String>[].obs;
  RxList<String> selectedLevelList = <String>[].obs;
  RxList<bool> selectedBoolLenderList = <bool>[].obs;
  RxList<bool> selectedBoolLevelList = <bool>[].obs;
  RxList<bool> lenderCheckBox = <bool>[].obs;
  RxList<bool> levelCheckBox = <bool>[].obs;
  RxList<String> lenderList = <String>[].obs;
  RxList<String> levelList = <String>[].obs;
  RxList<String> previousLevelList = <String>[].obs;
  List<DropdownMenuItem<String>>? dropDownMutualFund;
  RxList<SchemesListEntity> schemesListAfterFilter = <SchemesListEntity>[].obs;
  RxList<SchemesListEntity> selectedSchemeList = <SchemesListEntity>[].obs;
  RxList<TextEditingController> unitControllersList =
      <TextEditingController>[].obs;
  List mutualFundList = [Strings.equity, Strings.debt];
  RxBool isSchemeSelect = true.obs;
  RxList<SchemesListEntity> schemesList = <SchemesListEntity>[].obs;
  List<FocusNode> focusNode = <FocusNode>[];
  RxDouble schemeValue = 0.0.obs;
  RxDouble eligibleLoanAmount = 0.0.obs;
  FocusNode searchFocusNode = FocusNode();
  ScrollController scrollController = new ScrollController();
  final schemeController = StreamController<MfSchemeResponseEntity>.broadcast();
  get getSchemes => schemeController.stream;

  List<DropdownMenuItem<String>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in mutualFundList) {
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
    appBarTitle = Text(
      Strings.eligibility,
      style: mediumTextStyle_18_gray_dark,
    );

    dropDownMutualFund = getDropDownFormatMenuItems();
    scrollController.addListener(() {});

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.forEach((focusNode) {
      focusNode.dispose();
    });
    super.onClose();
  }

  Future<void> getLendersData() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);

      DataState<LenderResponseEntity> response = await lenderUsecase.call();
      if (response is DataSuccess) {
        for (int i = 0; i < response.data!.lenderData!.length; i++) {
          lenderList.add(response.data!.lenderData![i].name!);
          selectedLenderList.add(response.data!.lenderData![i].name!);
          selectedBoolLenderList.add(true);
          selectedLevelList.clear();
          selectedBoolLevelList.clear();
          levelList.clear();
          levelList.addAll(response.data!.lenderData![0].levels!);
          response.data!.lenderData![0].levels!.forEach((element) {
            selectedLevelList.add(element.toString().split(" ")[1]);
            selectedBoolLevelList.add(true);
          });
        }
        Get.back();
        await getSchemesListData();
      } else if (response is DataFailed) {
        Get.back();

        Utility.showToastMessage(response.error!.message);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> getSchemesListData() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);

      MFSchemeRequestEntity mfSchemeRequestEntity = MFSchemeRequestEntity(
        schemeType: currentMutualFundOption,
        lender: selectedLenderList.join(","),
        level: selectedLevelList.join(","),
      );

      DataState<MfSchemeResponseEntity> response = await mfSchemeUsecase.call(
          MfSchemeRequestParams(mfSchemeRequestEntity: mfSchemeRequestEntity));

      if (response is DataSuccess) {
        schemesListAfterFilter.clear();
        isAddBtnSelected.clear();
        unitControllersList.clear();
        focusNode.clear();
        isAddQtyEnable.clear();
        schemesListAfterFilter.addAll(
            response.data!.mfSchemeDataResponseModel!.schemesListEntity!);
        schemesListAfterFilter.forEach((element) {
          isAddBtnSelected.add(true);
          unitControllersList.add(TextEditingController());
          focusNode.add(FocusNode());
          isAddQtyEnable.add(false);
        });
        schemeController.sink.add(response.data!);
        Get.back();
      } else if (response is DataFailed) {
        Get.back();
        if (response.error!.statusCode == 403) {
          schemeController.sink.addError(response.error!.message);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void scrollUp() {
    if (scrollController.position.pixels !=
        scrollController.position.minScrollExtent) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
    }
  }

  Future<void> getSchemesAndSetLoanAmount() async {
    if (await _connectionInfo.isConnected) {
      MFSchemeRequestEntity mfSchemeRequestEntity = MFSchemeRequestEntity(
        schemeType: currentMutualFundOption,
        lender: selectedLenderList.join(","),
        level: selectedLevelList.join(","),
      );

      DataState<MfSchemeResponseEntity> response = await mfSchemeUsecase.call(
          MfSchemeRequestParams(mfSchemeRequestEntity: mfSchemeRequestEntity));

      if (response is DataSuccess) {
        schemesListAfterFilter.clear();
        isAddBtnSelected.clear();
        unitControllersList.clear();
        focusNode.clear();
        isAddQtyEnable.clear();
        schemesListAfterFilter.addAll(
            response.data!.mfSchemeDataResponseModel!.schemesListEntity!);
        schemesListAfterFilter.forEach((element) {
          isAddBtnSelected.add(true);
          unitControllersList.add(TextEditingController());
          focusNode.add(FocusNode());
          isAddQtyEnable.add(false);
        });
        schemeController.sink.add(response.data!);
        schemeValue.value = 0.0;
        eligibleLoanAmount.value = 0.0;

        Get.back();
      } else if (response is DataFailed) {
        Get.back();
        if (response.error!.statusCode == 403) {
          schemeController.sink.addError(response.error!.message);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> changedDropDownMutualFund(String? selectedStatus) async {
    if (await _connectionInfo.isConnected) {
      if (currentMutualFundOption != selectedStatus) {
        currentMutualFundOption = selectedStatus!;
        showDialogLoading(Strings.please_wait);
        scrollUp();
        selectedLenderList.clear();
        selectedLevelList.clear();
        selectedBoolLevelList.clear();
        selectedLenderList.addAll(lenderList);
        levelList.forEach((element) {
          selectedLevelList.add(element.split(" ")[1]);
          selectedBoolLevelList.add(true);
        });
        handleOnSearchEnd();
        await getSchemesAndSetLoanAmount();
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> getIsinDetailsData(
      String? isinValue, int index, int actualIndex) async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      IsinDetailsRequestEntity isinDetailsRequestEntity =
          IsinDetailsRequestEntity(isin: isinValue);

      DataState<IsinDetailResponseEntity> response =
          await isinDetailsUsecase.call(
        IsinDetailsRequestParams(
          isinDetailsRequestEntity: isinDetailsRequestEntity,
        ),
      );

      if (response is DataSuccess) {
        schemesList[index].units =
            unitControllersList[actualIndex].text.isNotEmpty
                ? double.parse(unitControllersList[actualIndex].text)
                : 0;
        schemesListAfterFilter[actualIndex].units =
            unitControllersList[actualIndex].text.isNotEmpty
                ? double.parse(unitControllersList[actualIndex].text)
                : 0;
        for (int i = 0; i < schemesListAfterFilter.length; i++) {
          if (!isAddBtnSelected[i]) {
            schemesListAfterFilter[i].units =
                double.parse(unitControllersList[i].text.toString());
            selectedSchemeList.add(schemesListAfterFilter[i]);
          }
        }
        print("length of list --> ${selectedSchemeList.length}");

        RxList<SchemesListEntity> securityList = await showModalBottomSheet(
          isScrollControlled: true,
          enableDrag: false,
          backgroundColor: Colors.transparent,
          context: Get.context!,
          builder: (BuildContext bc) {
            return MF_DetailViewDialog(
                selectedSchemeList,
                schemesList[index],
                response.data!.data!.isinDetails,
                currentMutualFundOption,
                lenderList[0],
                schemesListAfterFilter,
                unitControllersList[actualIndex].text.toString());
          },
        );
        // printLog("dialogResult ==> $dialogResult");

        // if(dialogResult != null) {
        //   if (double.parse(dialogResult.toString()) > 0) {
        //     isAddBtnSelected[actualIndex] = false;
        //     isAddQtyEnable[actualIndex] = true;
        //   } else {
        //     isAddBtnSelected[actualIndex] = true;
        //     isAddQtyEnable[actualIndex] = false;
        //   }
        //   unitControllersList[actualIndex].text = dialogResult.toString();
        //   schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
        //   schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
        //   updateSchemeValueAndEL();
        // }
        updateQuantity(securityList);
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void handleOnSearchEnd() {
    searchFocusNode.unfocus();
    this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
    this.appBarTitle = Text(
      Strings.eligibility,
      style: mediumTextStyle_18_gray_dark,
    );
    textController.clear();
    schemeSearch(schemesListAfterFilter, "");
  }

  void schemeSearch(List<SchemesListEntity> schemesListFilter, String query) {
    if (query.isNotEmpty) {
      RxList<SchemesListEntity> dummyListData = <SchemesListEntity>[].obs;
      schemesListFilter.forEach((item) {
        if (item.schemeName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      schemeController.sink.add(MfSchemeResponseEntity(
          mfSchemeDataResponseModel:
              MFSchemeDataResponseEntity(schemesListEntity: dummyListData)));
    } else {
      schemeController.sink.add(MfSchemeResponseEntity(
          mfSchemeDataResponseModel: MFSchemeDataResponseEntity(
              schemesListEntity: schemesListFilter)));
    }
  }
}
