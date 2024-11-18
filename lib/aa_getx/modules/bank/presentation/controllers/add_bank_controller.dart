import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/atrina_bank_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/bank_master_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/fund_acc_validation_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/bank_details_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/validate_bank_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/get_bank_details_usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/get_ifsc_bank_details_usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/validate_bank_usecase.dart';
import 'package:lms/aa_getx/modules/bank/presentation/views/add_bank_view.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/terms_and_conditions_arguments.dart';

import '../../../../core/utils/preferences.dart';

class AddBankController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final GetBankDetailsUseCase _getBankDetailsUseCase;
  final GetIfscBankDetailsUseCase _getIfscBankDetailsUseCase;
  final ValidateBankUseCase _validateBankUseCase;

  AddBankController(this._connectionInfo, this._getBankDetailsUseCase, this._getIfscBankDetailsUseCase, this._validateBankUseCase);

  RxBool accHolderNameValidator = true.obs;
  RxBool iFSCValidator = true.obs;
  RxBool validatorIFSC = true.obs;
  RxBool isAvailable = false.obs;
  RxBool isAPICalled = false.obs;
  RxBool iFSCTextLen = true.obs;
  RxBool accNumberValidator = true.obs;
  RxBool reEnterAccNumberValidator = true.obs;
  RxBool isVisible = false.obs;
  RxBool reEnterAccNumberIsCorrect = false.obs;
  List<BankDataEntity> bankData = [];
  //BankMasterResponseEntity? iFSCDetails;
  //BankDetailBloc bankDetailBloc = BankDetailBloc();
  BankAccountEntity bankAccount = BankAccountEntity();
  //Timer? timer;
  int pennyAPICallCount = 0;
  String? iFSCText = "HDFC BANK";
  //final completeKYCBloc = CompleteKYCBloc();
  final ImagePicker chequePicker = ImagePicker();
  RxString chequeByteImageString = "".obs;
  File? chequeImage;
  double? cropKb ;
  double? cropMb ;
  RxBool imageInMb = false.obs;
  FocusNode ifscFocusNode = FocusNode();
  Preferences preferences = Preferences();

  TextEditingController accHolderNameController = TextEditingController();
  TextEditingController iFSCController = TextEditingController();
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController reEnterAccNumberController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accTypeController = TextEditingController();

  @override
  void onInit() {
    choiceKYC();
    super.onInit();
  }

  @override
  void dispose() {
    accHolderNameController.dispose();
    accNumberController.dispose();
    reEnterAccNumberController.dispose();
    super.dispose();
  }

  void bankDetailAPI(String ifsc) async {
    if(await _connectionInfo.isConnected){
      BankDetailsRequestEntity bankDetailsRequestEntity = BankDetailsRequestEntity(ifsc: ifsc);
      DataState<BankMasterResponseEntity> response = await _getIfscBankDetailsUseCase.call(BankDetailsRequestParams(bankDetailsRequestEntity: bankDetailsRequestEntity));

      if(response is DataSuccess) {
          if (response.data!.bankList != null) {
            response.data!.bankList!.forEach((element) {
              if(element.ifsc == iFSCController.text.toString().trim()){
                isAvailable.value = true;
              } else {
                isAvailable.value = false;
              }
            });
            bankData.clear();
            bankData.addAll(response.data!.bankList!);
            isAPICalled.value = false;
          } else {
            isAvailable.value = false;
            isAPICalled.value = false;
          }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
            isAvailable.value = false;
            isAPICalled.value = false;
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }


    /*Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        await bankDetailBloc.getBankDetails(ifsc).then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              if (value.bankList != null) {
                value.bankList!.forEach((element) {
                  if(element.ifsc == iFSCController.text.toString().trim()){
                    isAvailable = true;
                  } else {
                    isAvailable = false;
                  }
                });
                bankData.clear();
                bankData.addAll(value.bankList!);
                isAPICalled = false;
              } else {
                isAvailable = false;
                isAPICalled = false;
              }
            });
          } else {
            setState(() {
              isAvailable = false;
              isAPICalled = false;
            });
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });*/
  }

  Future<void> choiceKYC() async {
    if(await _connectionInfo.isConnected){
      showLoadingWithoutBack(Get.context!, Strings.please_wait);
      DataState<AtrinaBankResponseEntity> response = await _getBankDetailsUseCase.call();
      Get.back();

      if(response is DataSuccess) {
        if (response.data != null){
          if (response.data!.atrinaBankData != null) {
            if (response.data!.atrinaBankData!.bankAccount != null
                && response.data!.atrinaBankData!.bankAccount!.isNotEmpty) {
              bankAccount = response.data!.atrinaBankData!.bankAccount![0];
              AddBankController controller = AddBankController(this._connectionInfo, this._getBankDetailsUseCase, this._getIfscBankDetailsUseCase, this._validateBankUseCase);
              choiceUserConfirmationDialog(controller);
            }
          }
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

    /*Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        showLoadingWithoutBack(Get.context!, Strings.please_wait);
        bankDetailBloc.getChoiceBankKYC().then((value) {
          Get.back();
          if (value.isSuccessFull!) {
            if(value.atrinaBankData != null){
              if(value.atrinaBankData!.bankAccount != null
                  && value.atrinaBankData!.bankAccount!.isNotEmpty){
                bankAccount = value.atrinaBankData!.bankAccount![0];
                AddBankController controller = AddBankController();
                choiceUserConfirmationDialog(controller);
              }
            }
          } else if (value.errorCode == 403) {
            commonDialog( Strings.session_timeout, 4);
          } else {
            // Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });*/
  }

  Future<void> validateBank() async {
    if(await _connectionInfo.isConnected){
    showLoadingWithoutBack(Get.context!, Strings.verifying_details);
    ValidateBankRequestEntity validateBankRequestEntity = ValidateBankRequestEntity(
      ifsc: iFSCController.text.toString().trim(),
      accountHolderName: accHolderNameController.text.toString().trim(),
      accountNumber: accNumberController.text.toString().trim(),
      bankAccountType: accTypeController.text.toString().trim(),
      branch: branchController.text.toString().trim(),
      city: cityController.text.toString().trim(),
      bank: bankController.text.toString().trim(),
      personalizedCheque: chequeByteImageString.value,
    );

    DataState<FundAccValidationResponseEntity> response = await _validateBankUseCase.call(ValidateBankRequestParams(validateBankRequestEntity: validateBankRequestEntity));
    Get.back();

    if(response is DataSuccess){
      showSuccessDialog(response.data!.message!, true);
    } else if (response is DataFailed) {
        if (response.error!.statusCode == 201) {
          showSuccessDialog(response.error!.message, false);
        } else if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          showFailedDialog(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }


    /*bankDetailBloc.validateBank(validateBankRequestBean).then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        showSuccessDialog(value.message!, true);
      } else if (value.errorCode == 201) {
        showSuccessDialog(value.message!, false);
      } else if (value.errorCode == 403) {
        commonDialog( Strings.session_timeout, 4);
      } else {
        showFailedDialog(value.errorMessage!);
      }
    });*/
  }

  Future<void> uploadPhoto() async {
    try {
      XFile? imagePicker = await chequePicker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          cropStyle: CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: appTheme,
              toolbarTitle: "Crop Image",
              toolbarWidgetColor: colorWhite,
              backgroundColor: colorBg,
            ),
          ],
        );

        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          final bytesint = File(cropped.path).readAsBytesSync().lengthInBytes;
          cropKb = bytesint / 1024;
          cropMb = cropKb! / 1024;
          debugPrint("Bytes ==> $bytesint");
          debugPrint("cropKb ==> $cropKb");
          debugPrint("cropMb ==> $cropMb");
          chequeByteImageString.value = base64Encode(bytes);
          //setState(() {
            chequeImage = File(cropped.path);
            if(cropMb! > 10){
              imageInMb.value = false;
            } else {
              imageInMb.value = true;
            }
         // });
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(Get.context);
      debugPrint("Exception : ${e.toString()}");
    }
  }

  void privacyPolicyClicked()  {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        String privacyPolicyUrl = await preferences.getPrivacyPolicyUrl();
        debugPrint("privacyPolicyUrl ==> $privacyPolicyUrl");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
        Get.toNamed(
          termsAndConditionsWebView,
          arguments: TermsAndConditionsWebViewArguments(
            url: "",
            isComingFor: Strings.terms_privacy,
            isForPrivacyPolicy: true,
          ),
        );
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> yesClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        //setState(() {
          iFSCController.text = bankAccount.ifsc.toString();
          bankController.text = bankAccount.bank.toString();
          branchController.text = bankAccount.branch.toString();
          cityController.text = bankAccount.city.toString();
          // accNumberController.text = bankAccount.accountNumber.toString();
          // reEnterAccNumberController.text = bankAccount.accountNumber.toString();
          accTypeController.text = bankAccount.accountType.toString();
          isAvailable.value = true;
          Get.back();
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void reEnterAccNumberOnChanged() {
     //setState(() {
      isVisible.value = true;
      getSubmitValidation();
      reEnterAccNumberController.text.isEmpty
          ? reEnterAccNumberValidator.value = false
          : reEnterAccNumberValidator.value = true;
      if(accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty) {
        if ((accNumberController.text.trim()
            .compareTo(reEnterAccNumberController.text.trim())) == 0) {
          reEnterAccNumberIsCorrect.value = false;
        } else {
          reEnterAccNumberIsCorrect.value = true;
        }
      }
    //});
  }

  void accNumberOnChanged() {
    //setState(() {
      isVisible.value = true;
      getSubmitValidation();
      accNumberController.text.isEmpty
          ? accNumberValidator.value = false
          : accNumberValidator.value = true;
      if(accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty){
        if ((accNumberController.text.trim()
            .compareTo(reEnterAccNumberController.text.trim())) == 0) {
          reEnterAccNumberIsCorrect.value = false;
        } else {
          reEnterAccNumberIsCorrect.value = true;
        }
      }
    //});
  }

  void accHolderNameOnChanged()  {
    //setState(() {
      isVisible.value = true;
      getSubmitValidation();
      accHolderNameController.text.isEmpty
          ? accHolderNameValidator.value = false
          : accHolderNameValidator.value = true;
    //});
  }

  void ifscOnChanged(String value, FocusNode fieldFocusNode)  {
    //setState(() {
    getSubmitValidation();
      if (iFSCController.text != value.toUpperCase())
        iFSCController.value = iFSCController.value
            .copyWith(text: value.toUpperCase());
      isVisible.value = true;
      // iFSCControllerr.text.isEmpty
      //     ? iFSCValidator = false
      //     : iFSCValidator = true;
      branchController.clear();
      bankController.clear();
      cityController.clear();

      fieldFocusNode.addListener(() {
        if(fieldFocusNode.hasFocus){
          iFSCValidator.value = true;
          iFSCTextLen.value = true;
          // if(iFSCController.text.length == 11 && iFSCController.text.isEmpty) {
          //   iFSCTextLen = true;
          // }
        }else{
          if(iFSCController.text.isNotEmpty) {
            iFSCValidator.value = true;
            if (iFSCController.text.length < 11) {
              iFSCTextLen.value = false;
            } else {
              iFSCTextLen.value = true;
            }
            debugPrint("focus length ==> ${iFSCTextLen.toString()}");
          }else{
            iFSCValidator.value = false;
          }
        }
      });
   // });
  }

  RxBool getSubmitValidation() {
    if(bankController.text.toString().trim().isNotEmpty &&
        iFSCController.text.toString().trim().isNotEmpty &&
        accHolderNameController.text.toString().trim().isNotEmpty &&
        accNumberController.text.toString().trim().isNotEmpty &&
        reEnterAccNumberController.text.toString().trim().isNotEmpty &&
        !reEnterAccNumberIsCorrect.value && cropMb != null && imageInMb.isTrue){
      return true.obs;
    } else {
      return false.obs;
    }
  }
}