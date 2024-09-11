import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_pincode_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/consent_details_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/get_pincode_details_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/arguments/kyc_address_arguments.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/screens/kyc_address_screen.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';

class KycAddressController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final GetPincodeDetailsUsecase _getPincodeDetailsUsecase;
  final ConsentDetailsKycUsecase _consentDetailsKycUsecase;
  KycAddressController(this._connectionInfo, this._getPincodeDetailsUsecase,
      this._consentDetailsKycUsecase);

  TextEditingController permAddressLine1Controller = TextEditingController();
  TextEditingController permAddressLine2Controller = TextEditingController();
  TextEditingController permAddressLine3Controller = TextEditingController();
  TextEditingController permCityController = TextEditingController();
  TextEditingController permPinCodeController = TextEditingController();
  TextEditingController permDistrictController = TextEditingController();
  TextEditingController permStateController = TextEditingController();
  TextEditingController corrAddressLine1Controller = TextEditingController();
  TextEditingController corrAddressLine2Controller = TextEditingController();
  TextEditingController corrAddressLine3Controller = TextEditingController();
  TextEditingController corrCityController = TextEditingController();
  TextEditingController corrPinCodeController = TextEditingController();
  TextEditingController corrDistrictController = TextEditingController();
  TextEditingController corrStateController = TextEditingController();
  TextEditingController permCountryController = TextEditingController();
  TextEditingController corrCountryController = TextEditingController();
  List<String> poaTypeList = [];
  List<String> countryList = [];
  String? consentText;
  String permPOATypeSelected = "POA TYPE";
  String corrPOATypeSelected = "POA TYPE";
  String? permByteImageString;
  String? corrByteImageString;
  final ImagePicker permPicker = ImagePicker();
  final ImagePicker corrPicker = ImagePicker();
  File? permPOAImage;
  String? permPOAImageNew;
  File? corrPOAImage;
  String? corrPOAImageNew;
  RxBool corrCheckbox = true.obs;
  RxBool consentCheckbox = true.obs;
  RxBool corrCheckboxEnable = false.obs;
  RxBool permFieldsEnable = false.obs;
  RxBool corrFieldsEnable = false.obs;
  RxBool isAPICalling = true.obs;
  String isAPICallingText = Strings.please_wait;
  //CompleteKYCBloc completeKYCBloc = CompleteKYCBloc();
  RxBool permValidatorAddress1 = true.obs;
  RxBool permValidatorCity = true.obs;
  RxBool permValidatorPinCode = true.obs;
  RxBool permValidPinCode = true.obs;
  RxBool permValidatorDistrict = true.obs;
  RxBool permValidatorState = true.obs;
  RxBool permValidatorCountry = true.obs;
  RxBool permValidatorValidCountry = true.obs;
  RxBool permValidatorPOAType = true.obs;
  RxBool permValidatorPOAImage = true.obs;
  RxBool permValidatorPOAImageSize = true.obs;
  RxBool corrValidatorAddress1 = true.obs;
  RxBool corrValidatorCity = true.obs;
  RxBool corrValidatorPinCode = true.obs;
  RxBool corrValidPinCode = true.obs;
  RxBool corrValidatorDistrict = true.obs;
  RxBool corrValidatorState = true.obs;
  RxBool corrValidatorCountry = true.obs;
  RxBool corrValidatorValidCountry = true.obs;
  RxBool corrValidatorPOAType = true.obs;
  RxBool corrValidatorPOAImage = true.obs;
  RxBool corrValidatorPOAImageSize = true.obs;
  RxBool allValidated = true.obs;
  RxBool? validate;
  RxBool? validation;
  Preferences preferences = new Preferences();
  String? permCountryValue;
  String? corrCountryValue;
  int permOnce = 1;
  int corrOnce = 1;
  ScrollController permScrollController = ScrollController();
  ScrollController corrScrollController = ScrollController();
  RxBool permIsBackPressedOrTouchedOutSide = false.obs,
      permIsDropDownOpened = false.obs;
  RxBool corrIsBackPressedOrTouchedOutSide = false.obs,
      corrIsDropDownOpened = false.obs;

  ScrollController scrollController = new ScrollController();
  // final myLoansBloc = MyLoansBloc();
  // Loan? loan;
  KycAddressArguments kycAddressArguments = Get.arguments;

  @override
  void onInit() {
    getConsentDetailsApiCall();    
    preferences.setOkClicked(false);
    scrollListener();
    super.onInit();
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (permIsDropDownOpened.isTrue) {
        permIsBackPressedOrTouchedOutSide.value = true;
      }
      if (corrIsDropDownOpened.isTrue) {
        corrIsBackPressedOrTouchedOutSide.value = true;
      }
      FocusScope.of(Get.context!).unfocus();
    });
  }

  void toChangeBoolValuesForDropdown() {
    if (permIsDropDownOpened.isTrue) {
      permIsBackPressedOrTouchedOutSide.value = true;
    }
    if (corrIsDropDownOpened.isTrue) {
      corrIsBackPressedOrTouchedOutSide.value = true;
    }
  }

  void onCheckBoxValueChanged() {
    consentCheckbox.value = !consentCheckbox.value;
  }

  void onCorrCheckBoxValueChanged() {
    corrCheckbox.value = !corrCheckbox.value;
  }

  Future<void> apiCallToGetPincodeDetails(String isComingFrom, pincode) async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      GetPincodeDetailsRequestEntity getPincodeDetailsRequestEntity =
          GetPincodeDetailsRequestEntity(pincode: pincode);

      DataState<PincodeResponseEntity> response =
          await _getPincodeDetailsUsecase.call(
        PincodeDetailsParams(
          getPincodeDetailsRequestEntity: getPincodeDetailsRequestEntity,
        ),
      );
      Get.back();
      if (response is DataSuccess) {
        if (isComingFrom == Strings.permanent_address) {
          permDistrictController.text = response.data!.data!.district!;
          permStateController.text = response.data!.data!.state!;
          permValidatorDistrict.value = true;
          permValidatorState.value = true;
        } else {
          corrDistrictController.text = response.data!.data!.district!;
          corrStateController.text = response.data!.data!.state!;
          corrValidatorDistrict.value = true;
          corrValidatorState.value = true;
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        }
      } else {
        if (isComingFrom == Strings.permanent_address) {
          permValidPinCode.value = false;
        } else {
          corrValidPinCode.value = false;
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> getConsentDetailsApiCall() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      ConsentDetailsRequestEntity consentDetailsRequestEntity =
          ConsentDetailsRequestEntity(
        userKycName: kycAddressArguments.kycName,
        isLoanRenewal: 0,
      );
      DataState<ConsentDetailResponseEntity> response =
          await _consentDetailsKycUsecase.call(ConsentDetailsKycParams(
              consentDetailsRequestEntity: consentDetailsRequestEntity));
      Get.back();
      if (response is DataSuccess) {
        permAddressLine1Controller.text =
            response.data!.consentDetailData!.userKycDoc!.permLine1!;
        permAddressLine2Controller.text =
            response.data!.consentDetailData!.userKycDoc!.permLine2!;
        permAddressLine3Controller.text =
            response.data!.consentDetailData!.userKycDoc!.permLine3!;
        permCityController.text =
            response.data!.consentDetailData!.userKycDoc!.permCity!;
        permPinCodeController.text =
            response.data!.consentDetailData!.userKycDoc!.permPin!;
        permDistrictController.text =
            response.data!.consentDetailData!.userKycDoc!.permDist!;
        permStateController.text =
            response.data!.consentDetailData!.userKycDoc!.permState!;
        permCountryController.text =
            response.data!.consentDetailData!.userKycDoc!.permCountry!;
        permCountryValue =
            response.data!.consentDetailData!.userKycDoc!.permCountry!;
        if (!kycAddressArguments.isShowEdit! &&
            response.data!.consentDetailData!.address! != null &&
            response.data!.consentDetailData!.address!.toString().isNotEmpty) {
          permPOATypeSelected =
              response.data!.consentDetailData!.address!.permPoa!;
          permPOAImageNew =
              response.data!.consentDetailData!.address!.permImage!;
        }
        corrAddressLine1Controller.text =
            response.data!.consentDetailData!.userKycDoc!.corresLine1!;
        corrAddressLine2Controller.text =
            response.data!.consentDetailData!.userKycDoc!.corresLine2!;
        corrAddressLine3Controller.text =
            response.data!.consentDetailData!.userKycDoc!.corresLine3!;
        corrCityController.text =
            response.data!.consentDetailData!.userKycDoc!.corresCity!;
        corrPinCodeController.text =
            response.data!.consentDetailData!.userKycDoc!.corresPin!;
        corrDistrictController.text =
            response.data!.consentDetailData!.userKycDoc!.corresDist!;
        corrStateController.text =
            response.data!.consentDetailData!.userKycDoc!.corresState!;
        corrCountryController.text =
            response.data!.consentDetailData!.userKycDoc!.corresCountry!;
        corrCountryValue =
            response.data!.consentDetailData!.userKycDoc!.corresCountry!;
        if (!kycAddressArguments.isShowEdit! &&
            response.data!.consentDetailData!.address != null &&
            response.data!.consentDetailData!.address!.toString().isNotEmpty) {
          corrPOATypeSelected =
              response.data!.consentDetailData!.address!.corresPoa!;
          corrPOAImageNew =
              response.data!.consentDetailData!.address!.corresPoaImage!;
        }
        poaTypeList =
            response.data!.consentDetailData!.poaType!.toSet().toList();
        countryList = response.data!.consentDetailData!.country!;
        consentText = response.data!.consentDetailData!.consentDetails!.consent;
        corrCheckbox.value = response
                    .data!.consentDetailData!.userKycDoc!.permCorresSameflag!
                    .toLowerCase() ==
                "y"
            ? true
            : false;
        isAPICalling.value = false;
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          isAPICalling.value = true;
          isAPICallingText = response.error!.message;
          commonDialog(Strings.session_timeout, 4);
        }
      } else {
        Utility.showToastMessage(response.error!.message);
        isAPICalling.value = true;
        isAPICallingText = response.error!.message;
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> saveConsentDetailsApicall() async {
    if (await _connectionInfo.isConnected) {
      String geoLocation = "";
      LocationPermission permission = await Geolocator.requestPermission();
      if(permission.index == 2){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        geoLocation = "${position.latitude},${position.longitude}";
      }
      showDialogLoading(Strings.please_wait);
      ConsentDetailsRequestEntity consentDetailsRequestEntity =
          ConsentDetailsRequestEntity(
        userKycName: kycAddressArguments.kycName,
        acceptTerms: consentCheckbox.isTrue ? 1 : 0,
        addressDetailsRequestEntity: 
        AddressDetailsRequestEntity(
            permanentAddress: PermanentAddressRequestEntity(
              addressLine1: permAddressLine1Controller.text.toString(),
              addressLine2: permAddressLine2Controller.text.toString(),
              addressLine3: permAddressLine3Controller.text.toString(),
              city: permCityController.text.toString(),
              pinCode: permPinCodeController.text.toString(),
              district: permDistrictController.text.toString(),
              state: permStateController.text.toString(),
              country: permCountryController.text.toString(),
              poaType: permPOATypeSelected,
              addressProofImage: permByteImageString,
            ),
            permCorresFlag: corrCheckbox.isTrue ? "yes" : "no",
            geoLocation: geoLocation,
            correspondingAddress: PermanentAddressRequestEntity(
              addressLine1: corrAddressLine1Controller.text.toString(),
              addressLine2: corrAddressLine2Controller.text.toString(),
              addressLine3: corrAddressLine3Controller.text.toString(),
              city: corrCityController.text.toString(),
              pinCode: corrPinCodeController.text.toString(),
              district: corrDistrictController.text.toString(),
              state: corrStateController.text.toString(),
              country: corrCountryController.text.toString(),
              poaType: corrPOATypeSelected,
              addressProofImage: corrByteImageString,
            )),
        isLoanRenewal: 0,
      );
      DataState<ConsentDetailResponseEntity> response =
          await _consentDetailsKycUsecase.call(ConsentDetailsKycParams(
              consentDetailsRequestEntity: consentDetailsRequestEntity));
      Get.back();
      if (response is DataSuccess) {
        preferences.setOkClicked(true);
          KycAddressController kycAddressController = KycAddressController(_connectionInfo, _getPincodeDetailsUsecase, _consentDetailsKycUsecase);
        showDialogOnCKYCSuccess(response.data!.message!,kycAddressController);
      } else if (response is DataFailed) {}
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> toNavigateOnSuccess() async {
    String camsEmail = await preferences.getCamsEmail();
    preferences.setOkClicked(false);
    Get.back();
    if (kycAddressArguments.forLoanRenewal!) {
      //Navigate to Dashboard
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DashBoard()));
    } else {
      //TODO Navigate to Additional Details Screen
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             AdditionalAccountDetailScreen(
      //                 1, "", "", "")));
    }
  }
}
