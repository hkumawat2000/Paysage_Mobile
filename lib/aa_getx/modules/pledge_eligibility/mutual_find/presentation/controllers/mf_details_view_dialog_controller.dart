import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/arguments/mf_details_dialog_arguments.dart';
import 'package:lms/util/Utility.dart';

class MfDetailsViewDialogController extends GetxController {
  final ConnectionInfo connectionInfo;
  MfDetailsViewDialogController(this.connectionInfo);

  RxBool isDefalutbottomDialog = true.obs;
  RxBool isEligiblebottomDialog = false.obs;
  RxBool isAddBtnSelected = true.obs;
  RxBool isAddQtyEnable = false.obs;
  TextEditingController controllers = TextEditingController();
  RxDouble schemeValue = 0.0.obs;
  RxDouble eligibleLoanAmount = 0.0.obs;
  RxBool isSchemeSelect = true.obs;
  RxList<SecuritiesListRequestEntity> securitiesListItems =
      <SecuritiesListRequestEntity>[].obs;
  FocusNode focusNode = FocusNode();
  RxDouble previousSchemeValue = 0.0.obs;
  RxDouble previousEligibleLoan = 0.0.obs;
  RxDouble selectedSchemeValue = 0.0.obs;
  RxDouble selectedEligibleLoan = 0.0.obs;

  MfDetailsDialogArguments arguments = Get.arguments;

  @override
  void onInit() {
    controllers.text = arguments.selectedUnit!;
    if (arguments.scheme.units == null || arguments.scheme.units == 0) {
      isAddBtnSelected.value = true;
      isAddQtyEnable.value = false;
    } else {
      isAddBtnSelected.value = false;
      isAddQtyEnable.value = true;
    }
    updateSchemeAndELValue();
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }

  Future<bool> onBackPressed() async {
    FocusScope.of(Get.context!).unfocus();
    focusNode.unfocus();
    Navigator.pop(Get.context!, arguments.selectedSchemeList);
    return true;
  }

  void updateSchemeAndELValue() {
    arguments.scheme.units = controllers.text.isEmpty || controllers.text == " "
        ? 0
        : double.parse(controllers.text);
    schemeValue.value = 0;
    eligibleLoanAmount.value = 0;
    for (int i = 0; i < arguments.selectedSchemeList.length; i++) {
      schemeValue.value = schemeValue.value! +
          (arguments.selectedSchemeList[i].price! *
              arguments.selectedSchemeList[i].units!);
      eligibleLoanAmount.value = eligibleLoanAmount.value! +
          (arguments.selectedSchemeList[i].price! *
                  arguments.selectedSchemeList[i].units! *
                  arguments.selectedSchemeList[i].ltv!) /
              100;
      if (arguments.selectedSchemeList[i].isin == arguments.scheme.isin) {
        arguments.selectedSchemeList[i].units = arguments.scheme.units;
      }
    }
  }

  Future<void> onaddSecuritiesBtnClick() async {
    if (await connectionInfo.isConnected) {
      isAddQtyEnable.value = true;
      isAddBtnSelected.value = false;
      controllers.text = "1";
      arguments.selectedSchemeList.add(arguments.scheme);
      updateSchemeAndELValue();
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
