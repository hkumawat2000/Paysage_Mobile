import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:safe_device/safe_device.dart';

class SplashController extends GetxController {
  RxString versionName = "".obs;
  RxString _doesmobileExist = "".obs;
  RxString _doesEmailExist = "".obs;
  RxString _isVisitTutorial = "".obs;
  RxBool _isjailBroken = false.obs;
  Preferences? _preferences = Preferences();

  @override
  void onInit() {
    // TODO: implement onInit
    getVersionInfo();
    toDetermineInitPlatformState();
    super.onInit();
  }
// To get the App Version
  Future<void> getVersionInfo() async {
    versionName(await Utility.getVersionInfo());
  }
  // To check if the device/platform is Jailbroken/Root/Emulator/ for security measures.
  Future<void> toDetermineInitPlatformState() async{
    try{
      _isjailBroken(await SafeDevice.isJailBroken);
    }on PlatformException{
      _isjailBroken.value = false;
    }
    catch(e){
      _isjailBroken.value = false;
    }
  }

  Future<void> splashTimer() async{
    await Future.delayed(Duration(seconds: 3)).then((onValue){
      autoLogin();
    });
  }

  Future<void> autoLogin() async{
    _doesmobileExist(await _preferences!.getMobile());
    _doesEmailExist(await _preferences!.getEmail());
    _isVisitTutorial(await _preferences!.isVisitTutorial());

    if(_isjailBroken.isTrue){
      Get.offNamed(jailBreakView);
    }else {
    if(_doesmobileExist.isNotEmpty && _doesEmailExist.isNotEmpty ){
      Get.offNamed(pinView);
    }else if(_isVisitTutorial.isNotEmpty){
      Get..offNamed(loginView);
    }else{
//TODO Call GetDetails Method.
    }

    }
  }

  Future<void> getDetails()async{

  }
}
