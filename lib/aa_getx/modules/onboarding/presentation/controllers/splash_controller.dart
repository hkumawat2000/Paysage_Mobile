import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/alert.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/entity/onboarding_response_entity.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/arguments/tutotrials_arguments.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:safe_device/safe_device.dart';

class SplashController extends GetxController {
  final GetOnboardingDetailsUsecase _getOnboardingDetailsUsecase;
  final ConnectionInfo _connectionInfo;

  SplashController(this._getOnboardingDetailsUsecase, this._connectionInfo);

  RxString versionName = "".obs;
  RxString _doesMobileExist = "".obs;
  RxString _doesEmailExist = "".obs;
  RxString _isVisitTutorial = "".obs;
  RxBool _isJailBroken = false.obs;
  Preferences? _preferences = Preferences();

  @override
  void onInit() {
    getVersionInfo();
    splashTimer();
    toDetermineInitPlatformState();
    super.onInit();
  }

  /// To get the App Version
  Future<void> getVersionInfo() async {
    versionName(await Utility.getVersionInfo());
  }

  /// To check if the device/platform is Jailbroken/Root/Emulator/ for security measures.
  Future<void> toDetermineInitPlatformState() async {
    try {
      _isJailBroken(await SafeDevice.isJailBroken);
    } on PlatformException {
      _isJailBroken.value = false;
    } catch (e) {
      _isJailBroken.value = false;
    }
  }

  Future<void> splashTimer() async {
    await Future.delayed(Duration(seconds: 3)).then((onValue) {
      autoLogin();
    });
  }

  Future<void> autoLogin() async {
    _doesMobileExist(await _preferences!.getMobile());
    _doesEmailExist(await _preferences!.getEmail());
    _isVisitTutorial(await _preferences!.isVisitTutorial());

    if (_isJailBroken.isTrue) {
      Get.offNamed(jailBreakView);
    } else {
      if (_doesMobileExist.isNotEmpty && _doesEmailExist.isNotEmpty) {
        Get.offNamed(pinView);
      } else if (_isVisitTutorial.isNotEmpty) {
        Get.offNamed(loginView);
      } else {
        getDetails();
      }
    }
  }

  Future<void> getDetails() async {
    if (await _connectionInfo.isConnected) {
      DataState<OnBoardingResponseEntity> response =
          await _getOnboardingDetailsUsecase.call();
      if (response is DataSuccess) {
        if (response.data != null) {
          Get.offNamed(
            tutorialsView,
            arguments: TutotrialsArguments(
              onboardingDataEntity: response.data!.onBoardingData!,
            ),
          );
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Get.context!, Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}
