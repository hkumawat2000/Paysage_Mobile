import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/enable_fingerprint_dialog_view.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/fingerprint_view.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/terms_and_conditions_arguments.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';

class FingerPrintController extends GetxController{
  Preferences preferences = new Preferences();
  SetPinArgs setPinArgs = Get.arguments;

  Future yesClicked() async {
    bool consentForBiometric = await preferences.getBiometricConsent();
    if(!consentForBiometric) {
      FingerPrintController controller = FingerPrintController();
      permissionDialog(controller);
    } else {
      Get.bottomSheet(
        EnableFingerPrintDialog(),
        isDismissible: false,
        settings: RouteSettings(
          arguments: SetPinArgs(
            isForOfflineCustomer: setPinArgs.isForOfflineCustomer,
            isLoanOpen: setPinArgs.isLoanOpen,
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: false,
      );
    }
  }

  void privacyPolicyClicked() {
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

  void skipClicked() {
    if (setPinArgs.isForOfflineCustomer! && setPinArgs.isLoanOpen == 0) {
      Get.offAllNamed(offlineCustomerView);
    }else{
      Get.offNamed(registrationSuccessfulView);
    }
  }

  Future denyClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.back();
      } else{
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  allowClicked() async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        Get.back();
        preferences.setBiometricConsent(true);
        // showModalBottomSheet(
        //     backgroundColor: Colors.transparent,
        //     context: context,
        //     isScrollControlled: true,
        //     isDismissible: false,
        //     enableDrag: false,
        //     builder: (BuildContext bc) {
        //       return EnableFingerPrintDialog(widget.isForOfflineCustomer, widget.isLoanOpen);
        //     });

        Get.bottomSheet(
          EnableFingerPrintDialog(),
          isDismissible: false,
          settings: RouteSettings(
              arguments: SetPinArgs(
                  isForOfflineCustomer: setPinArgs.isForOfflineCustomer,
                  isLoanOpen: setPinArgs.isLoanOpen)),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          enableDrag: false,
        );
      }else{
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}