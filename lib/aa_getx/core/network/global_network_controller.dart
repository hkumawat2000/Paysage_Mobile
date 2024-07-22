import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> checkConnection() async {
    var connectivityResultData =
        await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResultData);
  }

  void _updateConnectionStatus(var connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      debugPrint('isDialogOpen ******************* ${Get.isDialogOpen}');
      //If this below Get.back is uncommented then the no internet screen will auto dispose.
      //Sometimes the network auto fluctuates then it can help.
      hasInternet.value = true;
    }
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint('isDialogOpen *******************-->${Get.isDialogOpen}');
      // Close loading indicator if it is open
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen! || Get.isDialogOpen == null) {
          Get.back();
        }
      }

      hasInternet.value = false;
      //TODO Navigate To No Internet Screen
      //Navigate to no internet screen
      //Get.toNamed(noInternet);
    }
  }
}

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}