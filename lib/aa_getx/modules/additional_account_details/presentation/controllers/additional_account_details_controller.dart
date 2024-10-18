import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/request/additional_account_details_request_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/response/additional_account_details_response_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/usecases/additional_account_details_usecase.dart';
import 'package:lms/aa_getx/modules/additional_account_details/presentation/arguments/additional_account_details_arguments.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/util/Utility.dart';

class AdditionalAccountDetailsController extends GetxController {
  final ConnectionInfo connectionInfo;
  final AdditionalAccountDetailsUsecase additionalAccountDetailsUsecase;
  AdditionalAccountDetailsController(
      this.connectionInfo, this.additionalAccountDetailsUsecase);

  TextEditingController camsEmailController = TextEditingController();
  RxBool camsEmailValidator = true.obs;
  RxBool camsEmailSyntaxValidator = true.obs;
  RxBool isReadOnly = false.obs;
  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  Preferences preferences = new Preferences();
  FocusNode focusNode = FocusNode();

  AdditionalAccountDetailsArguments arguments = Get.arguments;

  @override
  void onInit() {
    preferences.setOkClicked(false);
    getData();
    getFocusOfTextField();
    super.onInit();
  }

  void getFocusOfTextField() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        camsEmailValidator.value = true;
      }
    });
  }

  Future<void> getData() async {
    //fetch value for isReadOnly variable if MF loan is open or is loan application is in pending state
    String camsEmail = await preferences.getCamsEmail();
    camsEmailController.text = camsEmail.toString();

    if (arguments.loanApplicationStatus.toString().isNotEmpty) {
      if (arguments.instrumentType == Strings.mutual_fund &&
          (arguments.loanApplicationStatus.toString() == "Approved" ||
              arguments.loanApplicationStatus.toString() == "Pending")) {
        isReadOnly.value = true;
      }
    }
  }

  Future<void> myCamsAccountDetail(String mycamsEmailId) async {
    if (await connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      AdditionalAccountdetailsRequestEntity
          additionalAccountdetailsRequestEntity =
          AdditionalAccountdetailsRequestEntity(email: mycamsEmailId);

      DataState<AdditionalAccountResponseEntity> response =
          await additionalAccountDetailsUsecase
              .call(AdditionalAccountDetailsParams(
        accountdetailsRequestEntity: additionalAccountdetailsRequestEntity,
      ));

      if(response is DataSuccess){

      }else if (response is DataFailed){

      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
