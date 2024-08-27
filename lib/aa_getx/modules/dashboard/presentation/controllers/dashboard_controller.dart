import 'dart:io';

import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/force_update_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/views/home_view.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/presentation/views/more_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/arguments/margin_shortfall_arguments.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/single_my_active_loan_view.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/delete_clear_notification_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/views/my_pledge_security_view.dart';
import 'package:lms/util/strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';


class DashboardController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final ForceUpdateUsecase _forceUpdateUsecase;
  final DeleteOrClearNotificationUseCase _deleteOrClearNotificationUseCase;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;

  DashboardController(this._connectionInfo, this._forceUpdateUsecase, this._deleteOrClearNotificationUseCase, this._getLoanDetailsUseCase);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseInAppMessaging _firebaseInAppMessaging =
      FirebaseInAppMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  Preferences preferences = Preferences();
  static var notificationId, messageId;
  //DashboardArguments dashboardArguments = DashboardArguments(isFromPinScreen: false,selectedIndex: 1);/// Todo: uncomment this Get.arguments;
  DashboardArguments? dashboardArguments = Get.arguments;
  RxInt selectedIndex = 0.obs;

  RxString storeURL = "".obs;
  RxString storeWhatsNew = "".obs;
  RxString storeVersion = "".obs;

  final List<Widget> children = [
    HomeView(),
    MyPledgeSecurityView(),
    SingleMyActiveLoanView(),
    MoreView()
  ];


  @override
  void onInit() {
    selectedIndex.value = dashboardArguments != null ? dashboardArguments!.selectedIndex : 0;
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
            storeWhatsNew.value = response.data!.forceUpdateDataEntity!.whatsNew!;
            bool canUpdateValue = await Utility().canUpdateVersion(storeVersion.value, localVersion);
            debugPrint("storeVersion ==> $storeVersion");
            debugPrint("localVersion ==> $localVersion");
            debugPrint("canUpdateValue ==> $canUpdateValue");
            if(canUpdateValue != null && canUpdateValue && response.data!.forceUpdateDataEntity!.forceUpdate == 1){
              Utility().forceUpdatePopUp( true, storeURL.value, storeWhatsNew.value);
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
      await notificationNavigator(screenToOpen, notificationLoan);
      await preferences.setNotificationRedirect("");
      await preferences.setNotificationLoan("");
    }
  }

  Future<void> redirectSms() async {
    String screenToOpen = await preferences.getSmsRedirection();
    if (screenToOpen != null && screenToOpen.isNotEmpty) {
      await smsNavigator(screenToOpen);
      await preferences.setSmsRedirection("");
    }
  }

  ////On click of sms link redirect user to particular screen
  smsNavigator(String screenName) async {
    if (screenName == "my_securities") {
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => DashBoard(selectedIndex: 1)));
      Get.toNamed(dashboardView, arguments: DashboardArguments(selectedIndex: 1,isFromPinScreen: false));
    } else if (screenName == "contact_us") {
      ///todo: uncomment below code after ContactUsScreen is developed
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => ContactUsScreen()));
    } else if (screenName == "my_loans") {
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => DashBoard(selectedIndex: 2)));
      Get.toNamed(dashboardView, arguments: DashboardArguments(selectedIndex: 2,isFromPinScreen: false));
    }
    await Preferences().setSmsRedirection("");
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  fcmConfigure() async {
    preferences = Preferences();
    String firebaseTokenExist = await preferences.getFirebaseToken();
    FirebaseMessaging.instance.getToken().then((token) {
      if (firebaseTokenExist != token) {
        debugPrint("==========> New Token Created <==========");
        preferences.setFirebaseToken(token!);
      }
      debugPrint("firebaseToken ==> $token");
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
    if (initialMessage != null && dashboardArguments!.isFromPinScreen) {
      _handleMessageOnLaunch(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOnResume);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("==================> FCM <==================");
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
        debugPrint("==================> FCM <==================");
        // printLog("onLaunch :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});

        DeleteNotificationEntity deleteNotificationEntity =
            DeleteNotificationEntity(
                isForRead: 1,
                isForClear: 0,
                notificationName: message.data["name"]);
        if (await _connectionInfo.isConnected) {
          showDialogLoading(Strings.please_wait);
          DataState<NotificationResponseEntity> response =
              await _deleteOrClearNotificationUseCase.call(
                  DeleteNotificationParams(
                      deleteNotificationEntity: deleteNotificationEntity));
          Get.back(); //pop dialog
          debugPrint("response block");
          debugPrint("response   ${response.data}");
          if (response is DataSuccess) {
            if (response.data != null) {
              await notificationNavigator(message.data["screen"],
                  message.data["loan_no"]);
            }
          } else if (response is DataFailed) {
            if (response.error!.statusCode == 403) {
              commonDialog(Strings.session_timeout, 4);
              debugPrint(
                  "response.error!.statusCode  ${response.error!.statusCode}");
            } else {
              Utility.showToastMessage(response.error!.message);
              debugPrint("response.error!.message  ${response.error!.message}");
            }
          }
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      }
    }
  }

  void _handleMessageOnResume(RemoteMessage message) async {
    if (message.notification != null && message.notification!.title != null) {
      if (notificationId != message.data['notification_id']) {
        debugPrint("==================> FCM <==================");
        //printLog("onResume :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        preferences.setNotificationRedirect(message.data["screen"] ?? "");
        preferences.setNotificationLoan(message.data["loan_no"] ?? "");
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});

        DeleteNotificationEntity deleteNotificationEntity =
        DeleteNotificationEntity(
            isForRead: 1,
            isForClear: 0,
            notificationName: message.data["name"]);
        if (await _connectionInfo.isConnected) {
          showDialogLoading(Strings.please_wait);
          DataState<NotificationResponseEntity> response =
          await _deleteOrClearNotificationUseCase.call(
              DeleteNotificationParams(
                  deleteNotificationEntity: deleteNotificationEntity));
          Get.back(); //pop dialog
          debugPrint("response block");
          debugPrint("response   ${response.data}");
          if (response is DataSuccess) {
            if (response.data != null) {
              await notificationNavigator(message.data["screen"], message.data["loan_no"]);
              await preferences.setNotificationRedirect("");
              await preferences.setNotificationLoan("");
            }
          } else if (response is DataFailed) {
            if (response.error!.statusCode == 403) {
              commonDialog(Strings.session_timeout, 4);
              debugPrint(
                  "response.error!.statusCode  ${response.error!.statusCode}");
            } else {
              Utility.showToastMessage(response.error!.message);
              debugPrint("response.error!.message  ${response.error!.message}");
            }
          }
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      }
    }
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint("payload ===>> $payload");
      String screen = payload.split("&")[0];
      String loan = payload.split("&")[1];
      String name = payload.split("&")[2];
      debugPrint("Screen ===>> $screen");
      debugPrint("Loan ===>> $loan");
      debugPrint("Name ===>> $name");

      DeleteNotificationEntity deleteNotificationEntity =
      DeleteNotificationEntity(
          isForRead: 1,
          isForClear: 0,
          notificationName: name);
      if (await _connectionInfo.isConnected) {
        showDialogLoading(Strings.please_wait);
        DataState<NotificationResponseEntity> response =
        await _deleteOrClearNotificationUseCase.call(
            DeleteNotificationParams(
                deleteNotificationEntity: deleteNotificationEntity));
        Get.back(); //pop dialog
        if (response is DataSuccess) {
          if (response.data != null) {
            await notificationNavigator( screen, loan);
          }
        } else if (response is DataFailed) {
          if (response.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(response.error!.message);
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
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

  //On click of notification redirect user to particular screen
  notificationNavigator( String screenName, String? loanNumber) async {
    if (screenName == "My Loans") {
      Get.toNamed(dashboardView, arguments: DashboardArguments(selectedIndex: 2,isFromPinScreen: false));
    } else if (screenName == "Dashboard") {
      Get.toNamed(dashboardView);
    } else if (screenName == "Margin Shortfall Action") {
      showDialogLoading( Strings.please_wait);
      if (await _connectionInfo.isConnected) {
        GetLoanDetailsRequestEntity loanDetailsRequestEntity =
        GetLoanDetailsRequestEntity(
          loanName: loanNumber,
          transactionsPerPage: 15,
          transactionsStart: 0,
        );
        DataState<LoanDetailsResponseEntity> loanDetailsResponse =
        await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
            loanDetailsRequestEntity: loanDetailsRequestEntity));

        if (loanDetailsResponse is DataSuccess) {
          if (loanDetailsResponse.data != null) {
            if (loanDetailsResponse.data!.data != null) {
              if (loanDetailsResponse.data!.data!.marginShortfall == null) {
                Get.toNamed(dashboardView,
                    arguments: DashboardArguments(
                        selectedIndex: 2, isFromPinScreen: false));
              } else {
                Get.toNamed(marginShortfallView,
                    arguments: MarginShortfallArguments(
                        loanData: loanDetailsResponse.data!.data,
                        pledgorBoid:
                            loanDetailsResponse.data!.data!.pledgorBoid,
                        isSellCollateral:
                            loanDetailsResponse.data!.data!.sellCollateral == null
                                ? true
                                : false,
                        isSaleTriggered: loanDetailsResponse
                                    .data!.data!.marginShortfall!.status ==
                                "Sell Triggered"
                            ? true
                            : false,
                        isRequestPending: loanDetailsResponse
                                    .data!.data!.marginShortfall!.status ==
                                "Request Pending"
                            ? true
                            : false,
                        msg: loanDetailsResponse
                                .data!.data!.marginShortfall!.actionTakenMsg ??
                            "",
                        loanType: loanDetailsResponse
                            .data!.data!.loan!.instrumentType!,
                        schemeType:
                            loanDetailsResponse.data!.data!.loan!.schemeType!));
              }
            }
          }
        }else if (loanDetailsResponse is DataFailed) {
          if (loanDetailsResponse.error!.statusCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(loanDetailsResponse.error!.message);
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    }
  }
}
