import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:local_auth/local_auth.dart';

class EnableFingerPrintController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Utility utility = Utility();
  Preferences preferences = Preferences();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  List<BiometricType> availableBuimetricType = <BiometricType>[];
  var isFingerSupport = false;
  //SetPinArgs setPinArgs = Get.arguments; todo: uncomment this after previous pages are done and comment below line
  SetPinArgs setPinArgs = SetPinArgs(); //Get.arguments;

  @override
  void onInit() {
    isFingerPrintSupport();
    _getAvailableSupport();
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
  }


  Future<void> isFingerPrintSupport() async {
    isFingerSupport = await utility.getBiometricsSupport();
  }

  Future<void> _getAvailableSupport() async {
    try {
      availableBuimetricType = await _localAuthentication.getAvailableBiometrics();
      debugPrint("availableBuimetricType ==> $availableBuimetricType");
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }


  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  Future enableClicked() async {
    if (availableBuimetricType.isEmpty) {
      Alert.showSnackBar(title: Strings.biometric_alert_msg);
    } else {
      if (isFingerSupport) {
        firebaseEvent("Biometric_Set", {'Set': true});
        preferences.setFingerprintEnable(true);
        preferences.setFingerprintConsent(true);
        if (setPinArgs.isForOfflineCustomer! && setPinArgs.isLoanOpen == 0) {
          Get.offAllNamed(offlineCustomerView);
        } else {
          Get.offNamed(registrationSuccessfulView);
        }
      } else {
        Alert.showSnackBar(title: Strings.biometric_alert_msg);
      }
    }
  }

  Future skipClicked() async {
    firebaseEvent("Biometric_Set", {'Set': false});
    if (setPinArgs.isForOfflineCustomer! && setPinArgs.isLoanOpen == 0) {
      Get.offAllNamed(offlineCustomerView);
    } else {
      Get.offNamed(registrationSuccessfulView);
    }
  }
}