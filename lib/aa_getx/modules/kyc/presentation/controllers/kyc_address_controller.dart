import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/util/Preferences.dart';

class KycAddressController extends GetxController {
  KycAddressController();

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
  final ImagePicker _permPicker = ImagePicker();
  final ImagePicker _corrPicker = ImagePicker();
  File? permPOAImage;
  String? permPOAImageNew;
  File? corrPOAImage;
  String? corrPOAImageNew;
  bool? corrCheckbox;
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
  Preferences _preferences = new Preferences();
  String? permCountryValue;
  String? corrCountryValue;
  int permOnce = 1;
  int corrOnce = 1;
  ScrollController _permScrollController = ScrollController();
  ScrollController _corrScrollController = ScrollController();
  RxBool permIsBackPressedOrTouchedOutSide = false.obs,
      permIsDropDownOpened = false.obs;
  RxBool corrIsBackPressedOrTouchedOutSide = false.obs,
      corrIsDropDownOpened = false.obs;

  ScrollController scrollController = new ScrollController();
  // final myLoansBloc = MyLoansBloc();
  // Loan? loan;

  @override
  void onInit() {
    // TODO: implement onInit
    _preferences.setOkClicked(false);
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
}
