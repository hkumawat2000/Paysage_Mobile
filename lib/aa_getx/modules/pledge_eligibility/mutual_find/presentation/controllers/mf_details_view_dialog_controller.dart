import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';

class MfDetailsViewDialogController extends GetxController {
  MfDetailsViewDialogController();

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

  @override
  void onInit() {
    controllers.text = widget.selectedUnit;
    if (widget.scheme.units == null || widget.scheme.units == 0) {
      isAddBtnSelected = true;
      isAddQtyEnable = false;
    } else {
      isAddBtnSelected = false;
      isAddQtyEnable = true;
    }
    updateSchemeAndELValue();
    super.onInit();
  }
}
