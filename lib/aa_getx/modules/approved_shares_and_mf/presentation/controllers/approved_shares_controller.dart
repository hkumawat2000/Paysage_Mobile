// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';

import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_account_response_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/usecases/get_demat_account_details_usecase.dart';
import 'package:lms/approved_securities/ApprovedSecuritiesScreen.dart';

class ApprovedSharesController extends GetxController {
  final ConnectionInfo connectionInfo;
  final GetDematAccountDetailsUsecase getDematAccountDetailsUsecase;

  ApprovedSharesController(
    this.connectionInfo,
    this.getDematAccountDetailsUsecase,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<RxString> stockat = <RxString>[].obs;
  Preferences preferences = Preferences();
  RxBool isChoiceUser = false.obs;
  RxString camsEmail = "".obs;
  RxString mobileNumber = "".obs;
  RxString emailId = "".obs;

  @override
  void onInit() {
    getIsChoiceUserData();
    super.onInit();
  }

  Future getIsChoiceUserData() async {
    isChoiceUser.value = await preferences.getIsChoiceUser();
    camsEmail.value = await preferences.getCamsEmail();
    mobileNumber.value = (await preferences.getMobile())!;
    emailId.value = await preferences.getEmail();
  }

  Future<void> getDematAccountDetails() async {
    if (await connectionInfo.isConnected) {
      showLoadingWithoutBack(Get.context!, Strings.please_wait);
      DataState<DematAccountResponseEntity> response =
          await getDematAccountDetailsUsecase.call();
      Get.back();
      if (response is DataSuccess) {
        if (response.data!.dematAc != null &&
            response.data!.dematAc!.length != 0) {
          //TODO TO navigate to
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             SecuritySelectionScreen(value.dematAc!)));
        } else {
          commonDialog(Strings.not_fetch, 0);
        }
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

  Future<void> onSharesClick() async {
    if (await connectionInfo.isConnected) {
      if (isChoiceUser.isTrue) {
        getDematAccountDetails();
      } else {
        commonDialog(Strings.coming_soon, 0);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> onMutualFundClick() async {
    if (await connectionInfo.isConnected) {
      if (camsEmail.value.isNotEmpty) {
        Get.toNamed(pledgeMfSchemeSelection);
        //TODO
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => MFSchemeSelectionScreen()));
      } else {
        //TODO
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             AdditionalAccountDetailScreen(3, "", "", "")));
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> onMfCentralClick() async {
    if (await connectionInfo.isConnected) {
      Get.toNamed(mutualFundConsentView);
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> handleClickForApprovedShares() async {
    print('object Internet');
    if (await connectionInfo.isConnected) {
      print('object Internet 1');
      //     // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobileNumber.value;
      parameter[Strings.email] = emailId.value;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      firebaseEvent(Strings.approved_securities_opened, parameter);
      Get.toNamed(approvedSecuritiesView);
      //TODO Navigate
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             ApprovedSecuritiesScreen()));
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
