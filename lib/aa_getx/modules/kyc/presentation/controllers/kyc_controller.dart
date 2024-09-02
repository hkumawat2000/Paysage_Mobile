import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/network/base_urls.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_text_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_download_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_search_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/download_kyc_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/search_kyc_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/consent_text_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/download_kyc_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/search_kyc_usecases.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/arguments/kyc_consent_arguments.dart';
import 'package:lms/network/responsebean/OTPResponseBean.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';

class KycController extends GetxController {
  SearchKycUseCase _searchKycUseCase;
  DownloadKycUsecase _downloadKycUsecase;
  ConsentTextKycUsecase _consentTextKycUsecase;
  ConnectionInfo _connectionInfo;
  KycController(
    this._connectionInfo,
    this._searchKycUseCase,
    this._downloadKycUsecase,
    this._consentTextKycUsecase,
  );

  TextEditingController panController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  DateTime selectedbirthDate = DateTime.now();
  Preferences _preferences = Preferences();
  RxBool checkBoxValue = true.obs;
  RxInt acceptTerms = 1.obs;
  FocusNode dobDateFocus = FocusNode();
  RxString consentKycText = "".obs;
  RxBool isApiCallInProgress = true.obs;
  String isAPICallingText = Strings.please_wait;

  @override
  void onInit() {
    consentTextApi();
    super.onInit();
  }

  void onCheckBoxValueChanged() {
    checkBoxValue.value = !checkBoxValue.value;
    if (checkBoxValue.isTrue) {
      acceptTerms.value = 1;
    } else {
      acceptTerms.value = 0;
    }
  }

  void onDOBChanged() {
    if (dateOfBirthController.text.length == 10) {
      // FocusScope.of(context).unfocus();
      if (panController.text.trim().length == 10) {
        checkFourthPValidation();
      }
    }
  }

  void requestFocusOnDOB() {
    if (panController.text.length == 10) {
      // FocusScope.of(context).requestFocus(dobDateFocus);
    }
  }

  Future<void> toCallKycApiAndNavigateTo() async {
    if (await _connectionInfo.isConnected) {
      FocusScope.of(Get.context!).unfocus();
      checkFourthPValidation();
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedbirthDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedbirthDate = picked;
      DateTime todaysDate = DateTime.now();

      var displayDateFormatter = new DateFormat('dd/MM/yyyy');
      var date = DateTime.parse(selectedbirthDate.toString());
      String formattedDate = displayDateFormatter.format(date);
      if (selectedbirthDate.isBefore(todaysDate)) {
        int age = todaysDate.year - selectedbirthDate.year;
        if (age > 18) {
          dateOfBirthController.clear();
          dateOfBirthController.text =
              formattedDate.toString().substring(0, 10);
        } else {
          dateOfBirthController.clear();
          Utility.showToastMessage(Strings.age_above_18);
        }
      } else {
        dateOfBirthController.clear();
        Utility.showToastMessage(Strings.invalid_dob);
      }
    }
  }

  //validation for pan number
  checkFourthPValidation() async {
    String? baseURL = await _preferences.getBaseURL();
    if (baseURL == BaseUrls.baseUrlProd) {
      if (panController.text.length == 0) {
        Utility.showToastMessage(Strings.message_empty_panNo);
      } else if (panController.text.length < 10) {
        Utility.showToastMessage(Strings.message_valid_panNo);
      } else if (panController.text[3].toLowerCase() != "p") {
        commonDialog(Strings.kyc_fourth_letter_validation, 0);
      } else {
        callSubmitKycApi();
      }
    } else {
      callSubmitKycApi();
    }
  }

  Future<void> callSubmitKycApi() async {
    if (await _connectionInfo.isConnected) {
      if (panController.text.length == 0) {
        Utility.showToastMessage(Strings.message_empty_panNo);
      } else if (panController.text.length < 10) {
        Utility.showToastMessage(Strings.message_valid_panNo);
      } else if (dateOfBirthController.text.length == 0) {
        Utility.showToastMessage(Strings.message_valid_DOB);
      } else if (acceptTerms == 0) {
        Utility.showToastMessage(Strings.kyc_check_validation);
      } else {
        try {
          DateTime todaysDate = DateTime.now();
          var displayDateFormatter = DateFormat('dd/MM/yyyy');
          var ddMmYyFormat =
              displayDateFormatter.parse(dateOfBirthController.value.text);
          if (ddMmYyFormat.isBefore(todaysDate)) {
            int age = todaysDate.year - ddMmYyFormat.year;
            if (age > 18) {
              dateOfBirthController.text = dateOfBirthController.value.text;
              showDialogLoading(Strings.please_wait);
              SearchKycRequestEntity searchKycRequestEntity =
                  SearchKycRequestEntity(
                panCardNumber: panController.text,
                acceptTerms: acceptTerms,
              );
              DataState<KYCSearchResponseEntity> response =
                  await _searchKycUseCase.call(
                KycSearchParams(searchKycRequestEntity: searchKycRequestEntity),
              );

              if (response is DataSuccess) {
                Get.back();
                if (response.data!.searchData != null) {
                  ckycDownloadApi(response.data!.searchData!.ckycNo!);
                } else {
                  Get.back();
                  Utility.showToastMessage(Strings.something_went_wrong);
                }
              } else if (response is DataFailed) {
                if (response.error!.statusCode == 403) {
                  Get.back;
                  commonDialog(Strings.session_timeout, 4);
                } else {
                  Get.back();
                  commonDialog(response.error!.message, 4);
                }
              }
            } else {
              dateOfBirthController.clear();
              Utility.showToastMessage(Strings.age_above_18);
            }
          } else {
            dateOfBirthController.clear();
            Utility.showToastMessage(Strings.invalid_dob);
          }
        } catch (e) {
          dateOfBirthController.clear();
          Utility.showToastMessage(Strings.correct_dob);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> ckycDownloadApi(String ckycNo) async {
    if (await _connectionInfo.isConnected) {
      DownloadKycRequestEntity downloadKycRequestEntity =
          DownloadKycRequestEntity(
        panCardNumber: panController.text,
        dateOfBirth: dateOfBirthController.text,
        ckycNumber: ckycNo,
      );
      DataState<KycDownloadResponseEntity> response =
          await _downloadKycUsecase.call(
        KycDownloadParams(
          downloadKycRequestEntity: downloadKycRequestEntity,
        ),
      );

      if (response is DataSuccess) {
        //TODO To Navigate to CkycConsent Screen
        Get.toNamed(
          kycConsentView,
          arguments: KycConsentArguments(
            kycName: response.data!.downloadData!.userKycName!,
            forLoanRenewal: false,
            isShowEdit: true,
            loanName: "",
            loanRenewalName: "",
          ),
        );
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          commonDialog(response.error!.message, 0);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> consentTextApi() async {
    if (await _connectionInfo.isConnected) {
      GetConsentDetailsRequestEntity getConsentDetailsRequestEntity =
          GetConsentDetailsRequestEntity(
        consentIsfor: 'Kyc',
      );

      DataState<ConsentTextResponseEntity> response =
          await _consentTextKycUsecase.call(ConsentTextKycParams(
        getConsentDetailsRequestEntity: getConsentDetailsRequestEntity,
      ));
      if (response is DataSuccess) {
        consentKycText.value = response.data!.consentDetails!.consent!;
        isApiCallInProgress.value = false;
      } else if (response is DataFailed) {
        if(response.error!.statusCode == 403){
          isAPICallingText = Strings.session_timeout;
          commonDialog(Strings.session_timeout, 4);
        }else{
          isAPICallingText = response.error!.message;
        }
      }
        isApiCallInProgress(false);
        consentKycText.value = response.data!.consentDetails!.consent!;
      } else if (response is DataFailed) {
        isApiCallInProgress(false);
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;
    String pText = prevText.text;
    String cText = currText.text;
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      if (int.parse(cText) > 3) {
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        cText = cText.substring(0, 1);
      } else {
        cText += '/';
      }
    } else if (cLen == 4) {
      if (int.parse(cText.substring(3, 4)) > 1) {
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        cText = cText.substring(0, 4);
      } else {
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        cText = cText.substring(0, 2) + '/';
      } else {
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        cText = cText.substring(0, 5) + '/';
      } else {
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
        text: cText,
        selection: TextSelection.collapsed(offset: selectionIndex));
  }
}
