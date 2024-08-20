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
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';
import 'package:lms/aa_getx/modules/more/presentation/views/more_view.dart';
import 'package:lms/my_loan/SingleMyActiveLoanScreen.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/pledged_securities/MyPledgedListScreen.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_support/overlay_support.dart';
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

  RxInt selectedIndex = 0.obs;

  RxString storeURL = "".obs;
  RxString storeWhatsNew = "".obs;
  RxString storeVersion = "".obs;

  final List<Widget> children = [
    HomeScreen(),
    MyPledgeSecurityScreen(),
    SingleMyActiveLoanScreen(),
    MoreView()
  ];

  DashboardArguments dashboardArguments = DashboardArguments(isFromPinScreen: false,selectedIndex: 1);/// Todo: uncomment this Get.arguments;

  @override
  void onInit() {
    forceUpdate();
    fcmConfigure();
    redirectNotification();
    redirectSms();
    _localAuthentication.stopAuthentication();
    flutterLocalNotificationsPlugin.cancelAll();
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
    if (screenToOpen != null && screenToOpen.isNotEmpty) {
      await smsNavigator(Get.context!, screenToOpen);
      await preferences.setSmsRedirection("");
    }
  }

  Future<bool> onBackPressed() async {
    return await showDialog(
          context: Get.context!,
          builder: (context) => onBackPressDialog(1, Strings.exit_app),
        ) ??
        false;
  }

  void onItemTapped(int index) {
    selectedIndex!.value = index;
  }

  fcmConfigure() async {
    preferences = Preferences();
    String firebaseTokenExist = await preferences.getFirebaseToken();
    FirebaseMessaging.instance.getToken().then((token) {
      if (firebaseTokenExist != token) {
        printLog("==========> New Token Created <==========");
        preferences.setFirebaseToken(token!);
      }
      printLog("firebaseToken ==> $token");
    });

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_app_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    // var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse id) async {
      selectNotification;
    });

    notificationId = await preferences.getNotificationId();

    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && dashboardArguments.isFromPinScreen) {
      _handleMessageOnLaunch(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOnResume);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog("==================> FCM <==================");
      //printLog("onMessage :: ${json.encode(message.data)}");
      if (message.messageId != messageId) {
        if (message.notification != null &&
            message.notification!.title != null) {
          preferences.setNotificationId(message.messageId!);
          messageId = message.messageId!;
          int id = int.parse(message.data['notification_id'].toString());
          showSimpleNotification(
            id,
            message.notification!.title!,
            message.notification!.body!,
            "${message.data['screen']}&${message.data['loan_no']}&${message.data['name']}",
          );
        }
      }
    });

    _firebaseMessaging.requestPermission(
        sound: true, badge: false, alert: true);
  }

  void _handleMessageOnLaunch(RemoteMessage message) async {
    if (message.notification != null && message.notification!.title != null) {
      if (notificationId != message.data['notification_id']) {
        printLog("==================> FCM <==================");
       // printLog("onLaunch :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});
        //TODO TO use notification api to delete / clear
        // if (mounted) {
        //   LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        //   notificationBloc
        //       .deleteOrClearNotification(1, 0, message.data["name"])
        //       .then((value) async {
        //     Navigator.pop(context);
        //     if (value.isSuccessFull!) {
        //       await notificationNavigator(
        //           context, message.data["screen"], message.data["loan_no"]);
        //     } else if (value.errorCode == 403) {
        //       commonDialog(context, Strings.session_timeout, 4);
        //     } else {
        //       Utility.showToastMessage(value.errorMessage!);
        //     }
        //   });
        // }
      }
    }
  }

  void _handleMessageOnResume(RemoteMessage message) async {
    if (message.notification != null && message.notification!.title != null) {
      if (notificationId != message.data['notification_id']) {
        printLog("==================> FCM <==================");
        //printLog("onResume :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        preferences.setNotificationRedirect(message.data["screen"] ?? "");
        preferences.setNotificationLoan(message.data["loan_no"] ?? "");
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});
        //TODO
        // if (mounted) {
        //   LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        //   notificationBloc.deleteOrClearNotification(1, 0, message.data["name"]).then((value) async {
        //     Navigator.pop(context);
        //     if (value.isSuccessFull!) {
        //       await notificationNavigator(context, message.data["screen"], message.data["loan_no"]);
        //       await preferences.setNotificationRedirect("");
        //       await preferences.setNotificationLoan("");
        //     } else if(value.errorCode == 403) {
        //       commonDialog(context, Strings.session_timeout, 4);
        //     } else {
        //       Utility.showToastMessage(value.errorMessage!);
        //     }
        //   });
        // }
      }
    }
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      printLog("payload ===>> $payload");
      String screen = payload.split("&")[0];
      String loan = payload.split("&")[1];
      String name = payload.split("&")[2];
      printLog("Screen ===>> $screen");
      printLog("Loan ===>> $loan");
      printLog("Name ===>> $name");
      // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      // notificationBloc.deleteOrClearNotification(1, 0, name).then((value) async {
      //   Navigator.pop(context);
      //   if (value.isSuccessFull!) {
      //     await notificationNavigator(context, screen, loan);
      //   } else if(value.errorCode == 403) {
      //     commonDialog(context, Strings.session_timeout, 4);
      //   } else {
      //     Utility.showToastMessage(value.errorMessage!);
      //   }
      // });
    }
  }

  void showSimpleNotification(
      int id, String title, String body, String payload) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      Strings.channelID,
      Strings.channelName,
      importance: Importance.high,
      priority: Priority.high,
      groupKey: Strings.groupKey,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: payload);

    if (Platform.isAndroid) {
      NotificationDetails groupNotification = getGroupNotifier(id);
      await flutterLocalNotificationsPlugin
          .show(0, title, body, groupNotification, payload: payload);
    }
  }

  NotificationDetails getGroupNotifier(int id) {
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation([],
        contentTitle: 'new notifications', summaryText: '');

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      Strings.channelID,
      Strings.channelName,
      styleInformation: inboxStyleInformation,
      groupKey: Strings.groupKey,
      playSound: false,
      setAsGroupSummary: true,
      priority: Priority.high,
    );

    return NotificationDetails(android: androidNotificationDetails);
  }
}
