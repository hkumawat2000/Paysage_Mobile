import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/user_kyc_doc_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/consent_details_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/arguments/kyc_address_arguments.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/arguments/kyc_consent_arguments.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';

class KycConsentController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final ConsentDetailsKycUsecase _consentDetailsKycUsecase;
  KycConsentController(this._connectionInfo, this._consentDetailsKycUsecase);

  Preferences _preferences = Preferences();
  RxBool checkBoxValue = true.obs;
  String userEmail = "-";
  RxInt acceptTerms = 1.obs;
  RxBool isApiCalling = true.obs;
  RxInt loanRenewal = 0.obs;
  String isAPICallingText = Strings.please_wait;
  String? cKycDocName;
  UserKycDocResponseEntity userKycDocResponseEntity =
      UserKycDocResponseEntity();
  KycConsentArguments kycConsentArguments = KycConsentArguments();

  @override
  void onInit() {
    if (kycConsentArguments.forLoanRenewal!) {
      if (kycConsentArguments.isShowEdit!) {
        loanRenewal.value = 1;
      } else {
        loanRenewal.value = 0;
      }
    } else {
      if (kycConsentArguments.isShowEdit!) {
        loanRenewal.value = 0;
      }
    }
    getKycConsentDetails();
    super.onInit();
  }

  Future<void> getKycConsentDetails() async {
    if (await _connectionInfo.isConnected) {
      ConsentDetailsRequestEntity consentDetailsRequestEntity =
          ConsentDetailsRequestEntity(
        userKycName: kycConsentArguments.kycName,
        acceptTerms: 1,
        isLoanRenewal: loanRenewal.value,
      );

      DataState<ConsentDetailResponseEntity> response =
          await _consentDetailsKycUsecase.call(ConsentDetailsKycParams(
              consentDetailsRequestEntity: consentDetailsRequestEntity));

      if (response is DataSuccess) {
        userKycDocResponseEntity =
            response.data!.consentDetailData!.userKycDoc!;
        cKycDocName = response.data!.consentDetailData!.userKycDoc!.name;
        isApiCalling.value = false;
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          isApiCalling.value = true;
          isAPICallingText = Strings.session_timeout;
          commonDialog(Strings.session_timeout, 4);
        } else {
          isApiCalling.value = true;
          isAPICallingText = response.error!.message;
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> navigateToConsentAddressScreen() async {
    if (await _connectionInfo.isConnected) {
      //TODO Navigate to Address Screen.
     // Get.toNamed(kycAddressView,arguments: KycAddressArguments(kycName: kycConsentArguments.forLoanRenewal! ? ckycDocName! : kycConsentArguments.ckycName!, loanName: '', loanRenewalName: '', isShowEdit: null, forLoanRenewal: null));
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
