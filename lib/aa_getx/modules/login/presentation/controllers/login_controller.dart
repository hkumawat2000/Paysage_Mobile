import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';

class LoginController extends GetxController{
  final TextEditingController mobileNumberController = TextEditingController();
  Preferences _preferences = Preferences();
  var authToken;
  String versionName = "";
  RxBool _checkBoxValue = true.obs;
  bool _biometricEnable = false;
  bool _biometricConsent = false;
  RxInt _acceptTerms = 1.obs;
  RxList<String> _dummyAccounts = <String>[].obs;
  FocusNode _mobileTextfiledFocus = FocusNode();
  String version = "";
  //TODO - Declare Terms of use model

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _mobileTextfiledFocus.dispose();
    super.onClose();
  }

  Future<void> getValuesFromPerfrences() async{
    _biometricEnable = await _preferences.getFingerprintEnable();
    _biometricConsent = await _preferences.getFingerprintConsent();
    _preferences.clearPreferences();
    _preferences.setIsVisitTutorial("true");
    _preferences.setFingerprintEnable(_biometricEnable);
    _preferences.setFingerprintConsent(_biometricConsent);
    authToken = await FirebaseMessaging.instance.getToken();
    _preferences.setFirebaseToken(authToken);
    version = await Utility.getVersionInfo();
    versionName = version;
  }

  Future<void> getTermsOfUse() async{
    
  }
}