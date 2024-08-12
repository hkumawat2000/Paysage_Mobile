import 'dart:io';

import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/force_update_usecase.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final ForceUpdateUsecase _forceUpdateUsecase;
  DashboardController(this._connectionInfo, this._forceUpdateUsecase);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseInAppMessaging _firebaseInAppMessaging =
      FirebaseInAppMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  Preferences preferences = Preferences();
  static var notificationId, messageId;

  RxInt? selectedIndex = 0.obs;

  RxString storeURL = "".obs;
  RxString storeWhatsNew = "".obs;
  RxString storeVersion = "".obs;

  final List<Widget> children = [
    // HomeScreen(),
    // MyPledgeSecurityScreen(),
    // SingleMyActiveLoanScreen(),
    // MoreScreen()
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> forceUpdate() async {
    if (await _connectionInfo.isConnected) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;
      String localVersion = packageInfo.version;
      if (packageName == Strings.ios_prod_package ||
          packageName == Strings.android_prod_package) {
        DataState<ForceUpdateResponseEntity> response =
            await _forceUpdateUsecase.call();

        if (response is DataSuccess) {
          if (response.data!.forceUpdateDataEntity != null) {
            if (Platform.isAndroid) {
              storeURL.value =
                  response.data!.forceUpdateDataEntity!.playStoreLink!;
              storeVersion.value =
                  response.data!.forceUpdateDataEntity!.androidVersion!;
            } else {
              storeURL.value =
                  response.data!.forceUpdateDataEntity!.appStoreLink!;
              storeVersion.value =
                  response.data!.forceUpdateDataEntity!.iosVersion!;
            }
          }
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> redirectNotification() async {
    String screenToOpen = await preferences.getNotificationRedirect();
    String notificationLoan = await preferences.getNotificationLoan();

    if (screenToOpen != "") {
      await notificationNavigator(Get.context!, screenToOpen, notificationLoan);
      await preferences.setNotificationRedirect("");
      await preferences.setNotificationLoan("");
    }
  }

  Future<void> redirectSms() async {
    String screenToOpen = await preferences.getSmsRedirection();
    if(screenToOpen != null && screenToOpen.isNotEmpty){
      await smsNavigator(Get.context!, screenToOpen);
      await preferences.setSmsRedirection("");
    }
  }

  Future<bool> onBackPressed() async {
    return await showDialog(
      context: Get.context!,
      builder: (context) => onBackPressDialog(1, Strings.exit_app),
    ) ?? false;
  }

  void onItemTapped(int index) {
      selectedIndex!.value = index;
  }
}
