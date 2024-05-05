import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final String keyEmail = 'email';
  static final String keyCamsEmail = 'cams_email';
  static final String keyFullName = 'fullName';
  static final String keyToken = 'token';
  static final String keyPin = 'pin';
  static final String keyMobileNo = 'mobile';
  static final String keyVisitTutorial = 'visitTutorial';
  static final String keyFirebaseToken = 'firebase_token';
  static final String keyFingerprint = 'isFingerprintSet';
  static final String keyConsentFingerprint = 'isFingerprintConsent';
  static final String keyClicked = 'ok_clicked';
  static final String keyPhotoConsent = 'photo_consent';
  static final String keyBiometricConsent = 'biometric_consent';
  static final String keyConsentForEmail = 'consent_for_email';
  static final String keyChoiceUser = 'choice_user';
  static final String keyBaseUrl = 'base_url';
  static final String keyNotificationId = 'notification_id';
  static final String keyNotificationRedirection = 'notification_redirect';
  static final String keyNotificationLoan = 'notification_loan';
  static final String keyDummyUser = 'dummy_user';
  static final String keyRedirection = 'sms_redirection';
  static final String keyPrivacyPolicyUrl = 'privacy_policy_url';

  Future<String> getNotificationId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notificationId = prefs.getString('$keyNotificationId') ?? "";
    return notificationId;
  }

  setNotificationId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyNotificationId', value);
  }

  Future<String> getNotificationRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notificationRedirect = prefs.getString('$keyNotificationRedirection') ?? "";
    return notificationRedirect;
  }

  setNotificationRedirect(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyNotificationRedirection', value);
  }

  Future<String> getNotificationLoan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notificationLoan = prefs.getString('$keyNotificationLoan') ?? "";
    return notificationLoan;
  }

  setNotificationLoan(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyNotificationLoan', value);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('$keyEmail') ?? "";
    return email;
  }

  setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyEmail', value);
  }

  Future<String> getCamsEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String camsEmail = prefs.getString('$keyCamsEmail') ?? "";
    return camsEmail;
  }

  setCamsEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyCamsEmail', value);
  }

  clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  setFullName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyFullName', value);
  }

  Future<String> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('$keyFullName') ?? "";
    return email;
  }

  setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyToken', value);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('$keyToken') ?? "";
    return email;
  }

  setPin(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyPin', value);
  }

  Future<String> getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pin = prefs.getString('$keyPin') ?? "";
    return pin;
  }

  Future<String?> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString('$keyMobileNo');
    return mobile;
  }

  setMobile(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyMobileNo', value);
  }

  Future<String?> isVisitTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? visitTutorial = prefs.getString('$keyVisitTutorial');
    return visitTutorial;
  }

  setIsVisitTutorial(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyVisitTutorial', value);
  }

  Future<String> getFirebaseToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fireToken = prefs.getString('$keyFirebaseToken')!;
    return fireToken;
  }

  setFirebaseToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyFirebaseToken', value);
  }

  Future<bool> getFingerprintEnable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool finger = prefs.getBool('$keyFingerprint') ?? false;
    return finger;
  }

  setFingerprintEnable(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyFingerprint', value);
  }

  Future<bool> getFingerprintConsent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool finger = prefs.getBool('$keyConsentFingerprint') ?? false;
    return finger;
  }

  setFingerprintConsent(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyConsentFingerprint', value);
  }

  Future<bool> getIsChoiceUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('$keyChoiceUser') ?? false;
    return value;
  }

  Future<bool> getOkClicked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('$keyClicked') ?? false;
    return value;
  }

  setOkClicked(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyClicked', value);
  }

  Future<bool> getPhotoConsent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('$keyPhotoConsent') ?? false;
    return value;
  }

  setPhotoConsent(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyPhotoConsent', value);
  }

  Future<bool> getBiometricConsent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('$keyBiometricConsent') ?? false;
    return value;
  }

  setBiometricConsent(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyBiometricConsent', value);
  }

  setIsChoiceUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyChoiceUser', value);
  }

  Future<bool?> getEmailDialogConsent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? emailDialogConsent = prefs.getBool('$keyConsentForEmail') ?? false;
    return emailDialogConsent;
  }

  setEmailDialogConsent(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('$keyConsentForEmail', value);
  }

  Future<String?> getBaseURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('$keyBaseUrl')!;
    return value;
  }

  setBaseURL(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyBaseUrl', value);
  }

  Future<String> getSmsRedirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('$keyRedirection') ?? "";
    return value;
  }

  setSmsRedirection(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyRedirection', value);
  }

  Future<String?> getDummyUserMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dummyUserMobile = prefs.getString('$keyDummyUser');
    return dummyUserMobile;
  }

  setDummyUserMobile(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$keyDummyUser', value);
  }

  getDummyAccountList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString('key_dummy_account_list')!);
  }

  setDummyAccountList(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("key_dummy_account_list", json.encode(value));
  }

  Future<String> getPrivacyPolicyUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('$keyPrivacyPolicyUrl') ?? '';
    return value;
  }

  setPrivacyPolicyUrl(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyPrivacyPolicyUrl, value);
  }
}
