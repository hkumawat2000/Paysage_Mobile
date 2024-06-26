import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:lms/additional_account_detail/AdditionalAccountDetailScreen.dart';
import 'package:lms/account_setting/AccountSettingScreen.dart';
import 'package:lms/approved_shares_and_mf/ApprovedShares.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/complete_kyc/CompleteKYCScreen.dart';
import 'package:lms/loan_renewal/KycUpdateScreen.dart';
import 'package:lms/loan_renewal/LoanSummaryScreen.dart';
import 'package:lms/new_dashboard/EsignConsentScreen.dart';
import 'package:lms/network/responsebean/LoanSummaryResponseBean.dart';
import 'package:lms/new_dashboard/YoutubeVideoPlayer.dart';
import 'package:lms/notification/NotificationBloc.dart';
import 'package:lms/notification/NotificationScreen.dart';
import 'package:lms/nsdl/BankDetailScreen.dart';
import 'package:lms/sell_collateral/MFInvokeScreen.dart';
import 'package:lms/feedback/FeedbackDialog.dart';
import 'package:lms/increase_loan_limit/IncreaseLoanLimit.dart';
import 'package:lms/interest/InterestScreen.dart';
import 'package:lms/my_loan/MarginShortFallScreen.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/my_loan/SingleMyActiveLoanScreen.dart';
import 'package:lms/pledged_securities/MyPledgedListScreen.dart';
import 'package:lms/sell_collateral/SellCollateralscreen.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/NewDashboardResponse.dart';
import 'package:lms/shares/PledgedSecuritiesList.dart';
import 'package:lms/topup/top_up_loan/SubmitTopUP.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:cron/cron.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/new_dashboard/NewDashboardBloc.dart';
import 'package:lms/new_dashboard/PendingRequestSummary.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms/more/MoreScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mf_increase_loan/MFIncreaseLoan.dart';

class DashBoard extends StatefulWidget {

  final int selectedIndex;
  final bool isFromPinScreen;

  DashBoard({this.selectedIndex = 0, this.isFromPinScreen = false});

  @override
  _DashBoardState createState() => _DashBoardState(selectedIndex: selectedIndex, isFromPinScreen: isFromPinScreen);
}

class _DashBoardState extends State<DashBoard> {

  int selectedIndex;
  bool isFromPinScreen;
  _DashBoardState({this.selectedIndex = 0, this.isFromPinScreen = false});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseInAppMessaging _firebaseInAppMessaging = FirebaseInAppMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  Preferences preferences = Preferences();
  static var notificationId, messageId;
  final notificationBloc = NotificationBloc();
  NewDashboardBloc newDashboardBloc = NewDashboardBloc();

  final List<Widget> _children = [
    HomeScreen(),
    MyPledgeSecurityScreen(),
    SingleMyActiveLoanScreen(),
    MoreScreen()
  ];

  @override
  void initState() {
    forceUpdate();
    fcmConfigure();
    redirectNotification();
    redirectSms();
    _localAuthentication.stopAuthentication();
    flutterLocalNotificationsPlugin.cancelAll();
    super.initState();
  }

  forceUpdate(){
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String packageName = packageInfo.packageName;
        String localVersion = packageInfo.version;
        if(packageName == Strings.ios_prod_package || packageName == Strings.android_prod_package){
          await newDashboardBloc.forceUpdate().then((value) async {
            if (value.isSuccessFull!) {
              if(value.updateData != null){
                String storeURL, storeWhatsNew, storeVersion;
                if(Platform.isAndroid) {
                  storeURL = value.updateData!.playStoreLink!;
                  storeVersion = value.updateData!.androidVersion!;
                } else {
                  storeURL = value.updateData!.appStoreLink!;
                  storeVersion = value.updateData!.iosVersion!;
                }
                storeWhatsNew = value.updateData!.whatsNew!;
                bool canUpdateValue = await Utility().canUpdateVersion(storeVersion, localVersion);
                printLog("storeVersion ==> $storeVersion");
                printLog("localVersion ==> $localVersion");
                printLog("canUpdateValue ==> $canUpdateValue");
                if(canUpdateValue != null && canUpdateValue && value.updateData!.forceUpdate == 1){
                  Utility().forceUpdatePopUp(context, true, storeURL, storeWhatsNew);
                }
              }
            } else {
              Utility.showToastMessage(value.errorMessage!);
            }
          });
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  // Future<void> checkForUpdate() async {
  //   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   // String packageName = packageInfo.packageName;
  //   // if(packageName == Strings.ios_prod_package || packageName == Strings.android_prod_package){
  //     final newVersion = NewVersion(
  //         iOSId: 'loans.atrinatechnologies.lms',
  //         androidId: 'com.atriina.lms',
  //         iOSAppStoreCountry: 'IN'
  //     );
  //
  //     final status = await newVersion.getVersionStatus();
  //     if (status != null) {
  //       if(status.canUpdate) {
  //         String releaseNote = status.releaseNotes!.replaceAll("-", "\n-");
  //         newVersion.showUpdateDialog(
  //             context: context,
  //             versionStatus: status,
  //             allowDismissal: false,
  //             dialogTitle: 'Update Available!',
  //             dialogText: 'New version of the app is available; Kindly update the app to continue.\n\nWhat\'s New:$releaseNote',
  //             updateButtonText: 'Update Now',
  //             dismissButtonText: 'Close App',
  //             dismissAction: () {
  //               SystemNavigator.pop();
  //             }
  //         );
  //       }
  //       printLog("ReleaseNotes ==> ${status.releaseNotes}");
  //       printLog("AppStoreLink ==> ${status.appStoreLink}");
  //       printLog("LocalVersion ==> ${status.localVersion}");
  //       printLog("StoreVersion ==> ${status.storeVersion}");
  //       printLog("CanUpdate ==> ${status.canUpdate}");
  //     }
  //   // }
  // }


  redirectNotification() async {
    String screenToOpen = await preferences.getNotificationRedirect();
    String notificationLoan = await preferences.getNotificationLoan();
    printLog("screenToOpen for notification ====>> $screenToOpen");
    printLog("notificationLoan ====>> $notificationLoan");
    if(screenToOpen != ""){
      await notificationNavigator(context, screenToOpen, notificationLoan);
      await preferences.setNotificationRedirect("");
      await preferences.setNotificationLoan("");
    }
  }

  redirectSms() async {
    String screenToOpen = await preferences.getSmsRedirection();
    printLog("screenToOpen for sms ====>> $screenToOpen");
    if(screenToOpen != null && screenToOpen.isNotEmpty){
      await smsNavigator(context, screenToOpen);
      await preferences.setSmsRedirection("");
    }
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

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && isFromPinScreen) {
      _handleMessageOnLaunch(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOnResume);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog("==================> FCM <==================");
      printLog("onMessage :: ${json.encode(message.data)}");
      if (message.messageId != messageId){
        if(message.notification != null && message.notification!.title != null) {
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
    }
    );

    _firebaseMessaging.requestPermission(sound: true, badge: false, alert: true);
  }

  void _handleMessageOnLaunch(RemoteMessage message) async {
    if(message.notification != null && message.notification!.title != null) {
      if (notificationId != message.data['notification_id']) {
        printLog("==================> FCM <==================");
        printLog("onLaunch :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});
        if (mounted) {
          LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
          notificationBloc.deleteOrClearNotification(1, 0, message.data["name"]).then((value) async {
            Navigator.pop(context);
            if (value.isSuccessFull!) {
              await notificationNavigator(context, message.data["screen"], message.data["loan_no"]);
            } else if(value.errorCode == 403) {
              commonDialog(context, Strings.session_timeout, 4);
            } else {
              Utility.showToastMessage(value.errorMessage!);
            }
          });
        }
      }
    }
  }

  void _handleMessageOnResume(RemoteMessage message) async {
    if(message.notification != null && message.notification!.title != null) {
      if (notificationId != message.data['notification_id']) {
        printLog("==================> FCM <==================");
        printLog("onResume :: ${json.encode(message.data)}");
        preferences.setNotificationId(message.data['notification_id']);
        preferences.setNotificationRedirect(message.data["screen"] ?? "");
        preferences.setNotificationLoan(message.data["loan_no"] ?? "");
        notificationId = message.data['notification_id'].toString();
        Future.delayed(const Duration(milliseconds: 100), () {});
        if (mounted) {
          LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
          notificationBloc.deleteOrClearNotification(1, 0, message.data["name"]).then((value) async {
            Navigator.pop(context);
            if (value.isSuccessFull!) {
              await notificationNavigator(context, message.data["screen"], message.data["loan_no"]);
              await preferences.setNotificationRedirect("");
              await preferences.setNotificationLoan("");
            } else if(value.errorCode == 403) {
              commonDialog(context, Strings.session_timeout, 4);
            } else {
              Utility.showToastMessage(value.errorMessage!);
            }
          });
        }
      }
    }
  }


  Future selectNotification(String? payload) async {
    if (payload != null){
      printLog("payload ===>> $payload");
      String screen = payload.split("&")[0];
      String loan = payload.split("&")[1];
      String name = payload.split("&")[2];
      printLog("Screen ===>> $screen");
      printLog("Loan ===>> $loan");
      printLog("Name ===>> $name");
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      notificationBloc.deleteOrClearNotification(1, 0, name).then((value) async {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          await notificationNavigator(context, screen, loan);
        } else if(value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }

  void showSimpleNotification(int id, String title, String body, String payload) async{
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        Strings.channelID,
        Strings.channelName,
        importance: Importance.high,
        priority: Priority.high,
        groupKey: Strings.groupKey,
        playSound: true,
        styleInformation: BigTextStyleInformation(''),
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: payload);

    if(Platform.isAndroid) {
      NotificationDetails groupNotification = getGroupNotifier(id);
      await flutterLocalNotificationsPlugin.show(0, title, body, groupNotification, payload: payload);
    }
  }

  NotificationDetails getGroupNotifier(int id){
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        [],
        contentTitle: 'new notifications',
        summaryText: '');

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      Strings.channelID, Strings.channelName,
      styleInformation: inboxStyleInformation,
      groupKey: Strings.groupKey,
      playSound: false,
      setAsGroupSummary: true,
      priority: Priority.high,
    );

    return NotificationDetails(android: androidNotificationDetails);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _children[selectedIndex],
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: bottomNavigationBar,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => onBackPressDialog(1, Strings.exit_app),
    ) ?? false;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget get bottomNavigationBar {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                label: "",
                icon: HomeMenuItem(false, Icons.home, text: 'Home'),
                activeIcon: HomeMenuItem(true, Icons.home, text: 'Home'),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 30,
                      child: Image.asset(AssetsImagePath.document,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Securities',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
                activeIcon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 30,
                      child: Image.asset(AssetsImagePath.document,
                          color: appTheme),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Securities',
                      style: TextStyle(fontSize: 10, color: appTheme),
                    )
                  ],
                ),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Text(
                        '₹',
                        style: TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Loans',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
                activeIcon: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: appTheme, width: 2)),
                      child: Text(
                        '₹',
                        style: TextStyle(fontSize: 20.0, color: appTheme),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'My Loans',
                      style: TextStyle(fontSize: 10, color: appTheme),
                    )
                  ],
                ),
                // title: Container(),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: HomeMenuItem(false, Icons.menu, text: 'More'),
                activeIcon: HomeMenuItem(true, Icons.menu, text: 'More'),
                // title: Container(),
              ),
            ],
          )),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _NewDashboardScreenState createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<HomeScreen> {
  NewDashboardBloc newDashboardBloc = NewDashboardBloc();
  Preferences? preferences = Preferences();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  Customer? customer = Customer();
  MyLoansBloc myLoansBloc = MyLoansBloc();
  bool isTimerDone = false;
  bool isAPIResponded = false;
  bool isLoanAPIResponded = false;
  bool isDashBoardAPIResponded = false;
  bool isViewProgressBarIndicator = false;
  bool isViewMarginShortFallCard = false;
  bool isViewInterestCard = false;
  bool isViewLoanSummaryCard = false;
  bool isViewPledgedESignCard = false;
  bool isViewLoanRenewalESignCard = false;
  bool isViewIncreaseESignCard = false;
  bool isViewTopUpESignCard = false;
  bool isViewTopUpCard = false;
  bool isViewCategoryItem = false;
  // bool isViewYoutubeVideo = false;
  bool isViewPlayVideoCard = false;
  bool isViewInviteCard = false;
  // bool isKYCUpdatePending = false;
  bool isKYCComplete = false;
  bool viewEmailVisible = false;
  bool isSellCollateral = false;
  bool isSellTriggered = false;
  bool isIncreaseLoan = false;
  bool isMarginSellCollateral = false;
  String? interestDueDate = '', totalInterestAmount = '', profilePhotoUrl = '';
  int? dpdText;
  List<LaPendingEsigns> eSignLoanList = <LaPendingEsigns>[];
  List<LoanRenewalEsigns> eSignLoanRenewalList = <LoanRenewalEsigns>[];
  List<LaPendingEsigns> eSignIncreaseLoanList = <LaPendingEsigns>[];
  List<TopupPendingEsigns> topUpESignLoanList = <TopupPendingEsigns>[];
  List<ActiveLoans> activeLoanList = <ActiveLoans>[];
  List<ActionableLoan> actionableLoanList = <ActionableLoan>[];
  List<UnderProcessLa> underProcessLoanList = <UnderProcessLa>[];
  List<UnderProcessLoanRenewalApp> underProcessLoanRenewalList = <UnderProcessLoanRenewalApp>[];
  List<TopupList> topUpList = <TopupList>[];
  List<InterestLoanList> interestLoanNameList = <InterestLoanList>[];
  List<LoanWithMarginShortfallList> marginShortfallList = <LoanWithMarginShortfallList>[];
  List<SellCollateralList> pendingSellCollateralList = <SellCollateralList>[];
  List<UnpledgeList> pendingUnPledgeList = <UnpledgeList>[];
  List<String> videoIDList = <String>[];
  List<String> videoNameList = <String>[];
  List<SellCollateralTopupAndUnpledgeList> sellCollateralTopUpAndUnpledgeList = <SellCollateralTopupAndUnpledgeList>[];
  String userFullName = '', loanName = '';
  int shortFallHours = 0, shortFallMin = 0, shortFallSec = 0;
  var timerDays = 0, timerHours = 0, timerMin = 0, timerSec = 0;
  // var pledgor_oid;
  LoanDetailsResponse? temp;
  AndroidNotificationChannel? channel;
  int notificationCount = 0;
  int isTodayHoliday = 0;
  Cron cron = new Cron();
  String? loanType;
  bool? isClicked;
  // bool? isVisitedCams;
  String? kycStatus = "";
  String? bankStatus = "";
  var baseURL;
  String? kycDocName;
  bool? isExpired = false;
  bool? isTimerShow = true;
  List<LoanRenewalApplication>? loanRenewal = <LoanRenewalApplication>[];
  ScrollController _hideButtonController = new ScrollController();
  bool isUpdateFlushVisible = false, isUpdateRequired = false;
  String? storeURL, storeWhatsNew;
  String? schemeType;

  @override
  void dispose() {
    newDashboardBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getData();
        callDashBoardApi();
        callLoanStatementApi();
        // newDashboardBloc.getWeeklyPledgedData();
        runClone();
      } else {
        commonDialog(context, Strings.no_internet_message, 0);
      }
    });
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          if(isUpdateRequired) {
            isUpdateFlushVisible = false;
          }
        });
      }
      if (_hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          if(isUpdateRequired) {
            isUpdateFlushVisible = true;
          }
        });
      }
    });
    super.initState();
  }

  getData() async {
    String? privacyPolicyUrl;
      var base_url = await preferences!.getBaseURL();
      setState(() {
        baseURL = base_url;
      });
    privacyPolicyUrl = await preferences!.getPrivacyPolicyUrl();
    isClicked = await preferences!.getOkClicked();
    // isVisitedCams = await preferences!.getIsVisitedCams();
    // printLog("Ok Clicked  --- $isClicked");
    // printLog("Ok Clicked  --- ${isVisitedCams.toString()}");
    // if(isClicked!){
    //   Navigator.push(context, MaterialPageRoute(
    //       builder: (context) => DematDetailScreen(1,"", "", "", "")));
    // }
    if(isClicked!){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => AdditionalAccountDetailScreen(2, "", "", "")));
    }
  }

  runClone(){
    cron.schedule(new Schedule.parse('0 0 * * *'), () async {
      callDashBoardApi();
      callLoanStatementApi();
    });
  }

  // getMarginShortFallPreferenceValue() async {
  //   pledgor_oid = await preferences!.getPledgorBoid();
  // }

  callDashBoardApi() async {
    newDashboardBloc.getDashboardData().then((value) {
      if(mounted) {
      if (value.isSuccessFull!) {
        setState(() {
          isDashBoardAPIResponded = true;
          isTimerDone = false;
          marginShortfallList.clear();
          interestLoanNameList.clear();
          videoIDList.clear();
          eSignLoanList.clear();
          eSignLoanRenewalList.clear();
          eSignIncreaseLoanList.clear();
          topUpESignLoanList.clear();
          if (isDashBoardAPIResponded && isLoanAPIResponded) {
            isAPIResponded = true;
          }
          // if(value.data!.userKyc != null){
          //   kycStatus = value.data!.userKyc!.kycStatus!;
          // }else{
          //   kycStatus = "New";
          // }
          if (value.newDashboardData!.customer != null) {
            isViewProgressBarIndicator = true;
            isViewCategoryItem = true;
            isViewPlayVideoCard = true;
            isViewInviteCard = true;
            customer = value.newDashboardData!.customer;
            // preferences!.setLoanOpen(customer!.loanOpen!);
            viewEmailVisible = customer!.isEmailVerified == 1 ? false : true;
            // isKYCUpdatePending = customer!.kycUpdate == 0 ? true : false;
            isKYCComplete = customer!.kycUpdate == 1 ? true : false;
            // preferences!.setUserKYC(isKYCComplete);
          }

            if (value.data!.userKyc != null) {
              kycDocName = value.data!.userKyc!.name;
              String kycType = value.data!.userKyc!.kycType!;
              kycStatus = value.data!.userKyc!.kycStatus!;
              if(kycType == "CHOICE"){
                preferences!.setIsChoiceUser(true);
              }else{
                preferences!.setIsChoiceUser(false);
              }
              if(kycStatus == "Pending" || kycStatus == "Rejected"){
                userFullName = value.data!.customer!.fullName!;
              }else{
                userFullName = value.data!.userKyc!.fullname!;
              }

            if(value.data!.userKyc!.bankAccount != null && value.data!.userKyc!.bankAccount!.length != 0){
               bankStatus = value.data!.userKyc!.bankAccount![0].bankStatus;
               if(bankStatus != null && bankStatus!.isEmpty){
                 bankStatus = "New";
               }
            } else {
              bankStatus = "New";
            }
          } else {
            kycStatus = "New";
            if (value.data!.customer != null) {
              userFullName = value.data!.customer!.fullName!;
            }
          }

            if (value.data!.marginShortfallCard!.loanWithMarginShortfallList != null) {
              isViewMarginShortFallCard = true;
              value.data!.marginShortfallCard!.loanWithMarginShortfallList!.forEach((v) {
                marginShortfallList.add(v);
              });
              // getMarginShortFallPreferenceValue();
              if (value.data!.marginShortfallCard!.earliestDeadline!.isNotEmpty) {
                if (value.data!.marginShortfallCard!.earliestDeadline == "00:00:00"
                    || value.data!.marginShortfallCard!.loanWithMarginShortfallList![0].status == "Request Pending") {
                  isTimerDone = true;
                }
                shortFallHours = int.parse(value.data!.marginShortfallCard!.earliestDeadline!.split(":")[0]);
                shortFallMin = int.parse(value.data!.marginShortfallCard!.earliestDeadline!.split(":")[1]);
                shortFallSec = int.parse(value.data!.marginShortfallCard!.earliestDeadline!.split(":")[2]);
              }
              isTodayHoliday = value.data!.marginShortfallCard!.loanWithMarginShortfallList![0].isTodayHoliday!;
            } else {
              isViewMarginShortFallCard = false;
            }

            if (value.data!.totalInterestAllLoansCard != null &&
                value.data!.totalInterestAllLoansCard!.loansInterestDueDate != null) {
              isViewInterestCard = true;
              totalInterestAmount = value.data!.totalInterestAllLoansCard!.totalInterestAmount!;
              dpdText = value.data!.totalInterestAllLoansCard!.loansInterestDueDate!.dpdTxt;
              interestDueDate = value.data!.totalInterestAllLoansCard!.loansInterestDueDate!.dueDate!;
              value.data!.totalInterestAllLoansCard!.interestLoanList!.forEach((v) {
                interestLoanNameList.add(v);
              });
            } else {
              isViewInterestCard = false;
            }

          if (value.data!.pendingEsignsList!.laPendingEsigns != null &&
              value.data!.pendingEsignsList!.laPendingEsigns!.length != 0) {
            if (value.data!.pendingEsignsList!.laPendingEsigns![0].increaseLoanMessage == null) {
              value.data!.pendingEsignsList!.laPendingEsigns!.forEach((v) {
                eSignLoanList.add(v);
              });
              isViewPledgedESignCard = true;
            } else {
              value.data!.pendingEsignsList!.laPendingEsigns!.forEach((v) {
                eSignIncreaseLoanList.add(v);
              });
              isViewIncreaseESignCard = true;
            }
          }

          // printLog("topupesig${jsonEncode(value.data!.pendingEsignsList!.topupPendingEsigns)}");

            if (value.data!.pendingEsignsList!.topupPendingEsigns != null &&
                value.data!.pendingEsignsList!.topupPendingEsigns!.length != 0) {
              value.data!.pendingEsignsList!.topupPendingEsigns!.forEach((v) {
                topUpESignLoanList.add(v);
              });
              isViewTopUpESignCard = true;
            } else {
              isViewTopUpESignCard = false;
            }

          if (value.data!.pendingEsignsList!.loanRenewalEsigns != null &&
              value.data!.pendingEsignsList!.loanRenewalEsigns!.length != 0) {
            value.data!.pendingEsignsList!.loanRenewalEsigns!.forEach((v) {
              eSignLoanRenewalList.add(v);
            });
            isViewLoanRenewalESignCard = true;
          } else {
            isViewLoanRenewalESignCard = false;
          }
        });

        if(value.data!.profilePhotoUrl != null) {
          profilePhotoUrl = value.data!.profilePhotoUrl!;
        }

        if (value.data!.fCMUnreadCount != null) {
          notificationCount = value.data!.fCMUnreadCount!;
        }

        if (value.data!.youtubeID != null) {
          // videoNameList.clear();
          value.data!.youtubeID!.forEach((v) {
            videoIDList.add(v);
          });

            for (int i = 0; i < videoIDList.length; i++) {
              videoNameList.add("");
              getTitle(videoIDList[i], i);
            }
            // isViewYoutubeVideo = true;
          } else {
            // isViewYoutubeVideo = false;
          }

          if (value.data!.showFeedbackPopup == 1) {
            feedbackDialog(context);
          }
          // printLog('POP UP VALUE ====>>>> ${value.data!.showFeedbackPopup}');
          setValuesInPreference();
        } else if (value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else {
          commonDialog(context, value.errorMessage, 0);
        }
      }
    });
  }

  callLoanStatementApi() {
    loanRenewal!.clear();
    isTimerShow = true;
    newDashboardBloc.getLoanSummaryData().then((value) async{
      if (mounted) {
        if (value.isSuccessFull!) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String packageName = packageInfo.packageName;
          String localVersion = packageInfo.version;
          String storeVersion;
          if(packageName == Strings.ios_prod_package || packageName == Strings.android_prod_package) {
            if(Platform.isAndroid) {
              storeURL = value.loanSummaryData!.versionDetails!.playStoreLink!;
              storeVersion = value.loanSummaryData!.versionDetails!.androidVersion!;
            } else {
              storeURL = value.loanSummaryData!.versionDetails!.appStoreLink!;
              storeVersion = value.loanSummaryData!.versionDetails!.iosVersion!;
            }
            storeWhatsNew = value.loanSummaryData!.versionDetails!.whatsNew!;
            bool canUpdateValue = await Utility().canUpdateVersion(storeVersion, localVersion);
            printLog("storeVersion2 ==> $storeVersion");
            printLog("localVersion2 ==> $localVersion");
            printLog("canUpdateValue2 ==> $canUpdateValue");
            if(canUpdateValue != null && canUpdateValue && value.loanSummaryData!.versionDetails!.forceUpdate == 0){
              isUpdateRequired = true;
              isUpdateFlushVisible = true;
            }
          }

          setState(() {
            loanType = value.loanSummaryData!.instrumentType;
            schemeType = value.loanSummaryData!.schemeType;
            if(value.loanSummaryData!.loanRenewalApplication != null && value.loanSummaryData!.loanRenewalApplication!.length != 0){
              loanRenewal!.addAll(value.loanSummaryData!.loanRenewalApplication!);
              if(loanRenewal![0].isExpired == 1){
                isExpired = true;
                if(loanRenewal![0].actionStatus == "Pending"){
                  isTimerShow = false;
                }
                if(loanRenewal![0].timeRemaining != null){
                  timerDays = int.parse(value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[0][0]); // 5D:12h:35m:20s
                  timerHours = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[1]).substring(0, 2));
                  timerMin = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[2]).substring(0, 2));
                  timerSec = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[3]).substring(0, 2));
                }
              }
            }
            isLoanAPIResponded = true;
            if (isDashBoardAPIResponded && isLoanAPIResponded) {
              isAPIResponded = true;
            }
            if (value.loanSummaryData!.topupList!.length != 0) {
              isViewTopUpCard = true;
            }
            if (value.loanSummaryData!.activeLoans!.length != 0 ||
                value.loanSummaryData!.actionableLoan!.length != 0 ||
                value.loanSummaryData!.underProcessLa!.length != 0 ||
                value.loanSummaryData!.underProcessLoanRenewalApp!.length != 0) {
              isViewLoanSummaryCard = true;
            }
          });
        }
      }
    });
  }

  setValuesInPreference() async {
    preferences!.setEmail(customer!.user!);
  }

  getTitle(String vid, int index) async {
    String videoUrl = 'https://www.youtube.com/watch?v=$vid';
    var embedUrl = Uri.parse("https://www.youtube.com/oembed?url=$videoUrl&format=json");
    String title;
    var res = await http.get(embedUrl);
    try {
      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        title = map["title"];
        printLog("TITLE ==> $title");
        setState(() {
          videoNameList[index] = title;
        });
      } else {
        title = "";
      }
    } on FormatException catch (e) {
      printLog('invalid JSON' + e.toString());
      title = "";
    }
    return title;
  }

  Future<void> pullRefresh() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        callDashBoardApi();
        callLoanStatementApi();
        // newDashboardBloc.getWeeklyPledgedData();
      } else {
        commonDialog(context, Strings.no_internet_message, 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: pullRefresh,
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            controller: _hideButtonController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  userHeader(),
                  shimmerEffect(),
                  progressBarIndicator(),
                  verifyEmail(),
                  kycDetailsPendingCard(),
                  loanRenewalPendingCard(),
                  loanRenewalVerificationPending(),
                  tncPendingCard(),
                  loanRenewalTimer(),
                  kycDetailsVerificationPending(),
                  bankDetailsPendingCard(),
                  bankDetailsVerificationPending(),
                  marginShortFallCard(),
                  interestAmountCard(),
                  loanSummaryCard(),
                  pledgedESignCard(),
                  loanRenewalESignCard(),
                  increaseESignCard(),
                  topUpESignCard(),
                  topUpCard(),
                  //ToDo for time being we hide the graph card
                  // pledgePerformanceCard(),
                  categoryItemsCard(),
                  isAPIResponded
                      ? customer!.isEmailVerified == 1
                          ? customer!.pledgeSecurities == 0
                              ? isViewLoanSummaryCard == false
                                  ? newLoanCard()
                                  : SizedBox()
                              : SizedBox()
                          : SizedBox()
                      : SizedBox(),
                  youtubeVideoBanner(),
                  // playVideoCard(),
                  inviteCard(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: isUpdateFlushVisible,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15,
              bottom: Platform.isAndroid
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.1 + 28),
          child: Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            backgroundColor: appTheme,
            mainButton: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: MaterialButton(
                color: red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                height: 25,
                minWidth: 10,
                child: Text("UPDATE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                onPressed: () {
                  Utility().forceUpdatePopUp(context, false, storeURL!, storeWhatsNew!);
                },
              ),
            ),
            messageText: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("New app version available!",
                    style: TextStyle(color: colorWhite, fontWeight: FontWeight.w300)),
              ],
            ),

            // duration: Duration(seconds: 2),
          ),
        ),
      ),
    );
  }

  Widget shimmerEffect() {
    return Visibility(
      visible: !isAPIResponded,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration:
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(26.0)),
            ),
            child: CircleAvatar(
              backgroundColor: colorLightBlue,
              backgroundImage: profilePhotoUrl!.isNotEmpty ? NetworkImage(profilePhotoUrl!)
                  : AssetImage(AssetsImagePath.profile) as ImageProvider,
              radius: 26.0,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello! $userFullName',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: appTheme,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: notificationCount == 0
                ? Image.asset(AssetsImagePath.bell, width: 22.0, height: 22.0)
                : Image.asset(AssetsImagePath.notification_icon, width: 25.0, height: 25.0),
            onTap: () {
              Utility.isNetworkConnection().then((isNetwork) async {
                if (isNetwork) {
                  final notificationResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                  if(notificationResult != null) {
                    if(notificationCount != 0){
                      pullRefresh();
                    }
                  }
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
          ),
          SizedBox(width: 4),
          GestureDetector(
            child: Image.asset(
              AssetsImagePath.manage_settings_icon,
              width: 22.0,
              height: 22.0,
              color: appTheme,
            ),
            onTap: () {
             Utility.isNetworkConnection().then((isNetwork) async {
               if (isNetwork) {
                final result = await Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => AccountSettingScreen()));
                 if(result != null) {
                   if (profilePhotoUrl!.isEmpty) {
                     pullRefresh();
                   }
                 }
               } else {
                 Utility.showToastMessage(Strings.no_internet_message);
               }
             });
            },
          ),
        ],
      ),
    );
  }

  Widget progressBarIndicator() {
    return Visibility(
      visible: isViewProgressBarIndicator,
      child: Column(
        children: [
          customer!.loanOpen == 1
              ? Container(height: 0)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            customer!.registeration == 1
                                ? checkedWidget()
                                : customer!.registeration == 0
                                    ? inProgressWidget()
                                    : ReusableProcessBar(),
                            SizedBox(height: 5),
                            Text('${Strings.registration}\n',
                                style: statusBarText),
                          ],
                        ),
                        dottedLineWidget(),
                        Column(
                          children: <Widget>[
                            customer!.kycUpdate == 1
                                ? checkedWidget()
                                : customer!.kycUpdate == 0
                                    ? inProgressWidget()
                                    : ReusableProcessBar(),
                            SizedBox(height: 5),
                            Text('${Strings.add}\n${Strings.kyc}',
                                style: statusBarText),
                          ],
                        ),
                        dottedLineWidget(),
                        Column(
                          children: <Widget>[
                            customer!.bankUpdate == 1
                                ? checkedWidget()
                                : customer!.bankUpdate == 0
                                    ? inProgressWidget()
                                    : ReusableProcessBar(),
                            SizedBox(height: 5),
                            Text('${Strings.add}\n${Strings.bank}',
                                style: statusBarText),
                          ],
                        ),
                        dottedLineWidget(),
                        Column(
                          children: <Widget>[
                            customer!.pledgeSecurities == 1
                                ? checkedWidget()
                                : customer!.pledgeSecurities == 0
                                    ? inProgressWidget()
                                    : ReusableProcessBar(),
                            SizedBox(height: 5),
                            Text('${Strings.pledge}\n${Strings.securities}',
                                style: statusBarText),
                          ],
                        ),
                        dottedLineWidget(),
                        Column(
                          children: <Widget>[
                            customer!.loanOpen == 1
                                ? checkedWidget()
                                : customer!.loanOpen == 0
                                    ? inProgressWidget()
                                    : ReusableProcessBar(),
                            SizedBox(height: 5),
                            Text('${Strings.loan}\n${Strings.open}',
                                style: statusBarText),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget dottedLineWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: DottedLine(
        lineLength: 30,
        dashColor: appTheme,
        dashLength: 0.8,
      ),
    );
  }

  Widget checkedWidget() {
    return ReusableProcessCheckedBar(
      processBarIcon: Icon(
        Icons.check,
        size: 18.0,
        color: appTheme,
      ),
    );
  }

  Widget inProgressWidget() {
    return ReusableProcessBar(
      processBarIcon: Icon(
        Icons.brightness_1,
        size: 10.0,
        color: appTheme,
      ),
    );
  }

  Widget verifyEmail() {
    return Visibility(
      visible: viewEmailVisible,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          Strings.need_email_verification,
                          style: boldTextStyle_18,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          Strings.check_email,
                          style: mediumTextStyle_14_gray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget marginShortFallCard() {
    return Visibility(
      visible: isViewMarginShortFallCard,
      child: marginShortfallList.length != 0 ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 35, width: 35, color: red),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.margin_shortfall,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        Text(Strings.margin_shortfall_text1,
                            style: TextStyle(color: appTheme, fontSize: 10)),
                        Text(Strings.margin_shortfall_text2,
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: appTheme,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          !isTimerDone
                              ? isTodayHoliday == 1
                                ? Column(
                                    children: [
                                      Text(Strings.time_remaining, style: TextStyle(fontSize: 9, color: Colors.indigo)),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text('${marginShortfallList[0].deadline}', textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))),],
                                )
                                : TweenAnimationBuilder<Duration>(
                                  duration: Duration(hours: shortFallHours, minutes: shortFallMin, seconds: shortFallSec),
                                  tween: Tween(
                                      begin: Duration(hours: shortFallHours, minutes: shortFallMin, seconds: shortFallSec),
                                      end: Duration.zero),
                                  onEnd: () {
                                    setState(() {
                                      isTimerDone = true;
                                    });
                                  },
                                  builder: (BuildContext context, Duration? value, Widget? child) {
                                    final hours = (value!.inHours).toString();
                                    final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
                                    final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
                                    String hour = '';
                                    if (hours == '0') {
                                      hour = '';
                                    } else {
                                      hour = '$hours:';
                                    }
                                    return Column(
                                      children: [
                                        Text(Strings.time_remaining,
                                            style: TextStyle(fontSize: 9, color: Colors.indigo)),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Text('$hour$minutes:$seconds', textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))),
                                      ],
                                    );
                                  })
                              : marginShortfallList[0].status == "Request Pending"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text('Action Taken',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(Strings.sale_triggered,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                    ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: appTheme,
                      child: Image.asset(AssetsImagePath.right_arrow_icon,
                          color: colorWhite),
                      radius: 20.0,
                    ),
                    onTap: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                          myLoansBloc.getLoanDetails(marginShortfallList[0].name).then((value) async {
                            Navigator.pop(context);
                            if (value.isSuccessFull!) {
                              Preferences preferences = Preferences();
                              // await preferences.setPledgorBoid(value.data!.pledgorBoid!);
                              if (value.data!.sellCollateral == null) {
                                isMarginSellCollateral = true;
                              } else {
                                isMarginSellCollateral = false;
                              }


                              String? mobile = await preferences.getMobile();
                              String email = await preferences.getEmail();
                              // Firebase Event
                              Map<String, dynamic> parameter = new Map<String, dynamic>();
                              parameter[Strings.mobile_no] = mobile;
                              parameter[Strings.email] = email;
                              parameter[Strings.margin_shortfall_name] = value.data!.marginShortfall!.name;
                              parameter[Strings.loan_number] = value.data!.loan!.name;
                              parameter[Strings.margin_shortfall_status] = marginShortfallList[0].status;
                              parameter[Strings.date_time] = getCurrentDateAndTime();
                              firebaseEvent(Strings.margin_shortFall_click, parameter);

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                          MarginShortfallScreen(
                                              value.data!,
                                              value.data!.pledgorBoid!,
                                              isMarginSellCollateral,
                                              marginShortfallList[0].status == "Sell Triggered" ? true : false,
                                              marginShortfallList[0].status == "Request Pending" ? true : false,
                                              value.data!.marginShortfall!.actionTakenMsg ?? "",
                                          loanType!,schemeType!)));
                            } else if (value.errorCode == 403) {
                              commonDialog(context, Strings.session_timeout, 4);
                            } else {
                              commonDialog(context, value.errorMessage, 0);
                            }
                          });
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ) : SizedBox(),
    );
  }

  Widget interestAmountCard() {
    return Visibility(
      visible: isViewInterestCard,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: appTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.percentage_icon,
                      height: 40, width: 30),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            Strings.interest_due,
                            style: TextStyle(
                                color: colorLightGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '₹${numberToString(totalInterestAmount!)}',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Days Past Due - ",
                              style: TextStyle(
                                  color: colorLightGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("$dpdText",
                              style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: Text(
                          Strings.pay_now,
                          style: TextStyle(
                              fontSize: 14,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: () {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      InterestScreen(
                                          interestLoanNameList[0]
                                              .interestAmount!,
                                          interestLoanNameList[0].loanName!,
                                          actionableLoanList[0].balance!,
                                          interestDueDate!)));
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanSummaryCard() {
    return StreamBuilder(
      stream: newDashboardBloc.listLoanSummary,
      builder: (context, AsyncSnapshot<LoanSummaryData> value) {
        if (value.hasData) {
          if (value.data == null) {
            return SizedBox(height: 0);
          } else {
            sellCollateralTopUpAndUnpledgeList.clear();
            actionableLoanList.clear();
            activeLoanList.clear();
            underProcessLoanList.clear();
            underProcessLoanRenewalList.clear();
            pendingSellCollateralList.clear();
            pendingUnPledgeList.clear();
            topUpList.clear();
            if (value.data!.sellCollateralTopupAndUnpledgeList!.length != 0) {
              value.data!.sellCollateralTopupAndUnpledgeList!.forEach((v) {
                sellCollateralTopUpAndUnpledgeList.add(v);
              });
            }

            if (value.data!.activeLoans!.length != 0 ||
                value.data!.actionableLoan!.length != 0 ||
                value.data!.underProcessLa!.length != 0 ||
                value.data!.underProcessLoanRenewalApp!.length != 0) {
              if (value.data!.actionableLoan!.length != 0) {
                value.data!.actionableLoan!.forEach((v) {
                  actionableLoanList.add(v);
                });
              }
              if (value.data!.activeLoans!.length != 0) {
                value.data!.activeLoans!.forEach((v) {
                  activeLoanList.add(v);
                });
              }
              if (value.data!.underProcessLa!.length != 0) {
                value.data!.underProcessLa!.forEach((v) {
                  underProcessLoanList.add(v);
                });
              }
              if (value.data!.underProcessLoanRenewalApp != null && value.data!.underProcessLoanRenewalApp!.length != 0) {
                value.data!.underProcessLoanRenewalApp!.forEach((v) {
                  underProcessLoanRenewalList.add(v);
                });
              }
              isViewLoanSummaryCard = true;
            }

            if (value.data!.activeLoans!.length == 0 &&
                value.data!.actionableLoan!.length == 0 &&
                value.data!.underProcessLa!.length == 0 &&
                value.data!.underProcessLoanRenewalApp!.length == 0) {
              isViewLoanSummaryCard = false;
            }

            if (value.data!.sellCollateralList!.length != 0) {
              for (int i = 0; i < value.data!.sellCollateralList!.length; i++) {
                if (value.data!.sellCollateralList![i].sellCollateralAvailable != null) {
                  pendingSellCollateralList.add(value.data!.sellCollateralList![i]);
                }
              }
              if (value.data!.sellCollateralList![0].sellCollateralAvailable == null) {
                isSellCollateral = true;
                loanName = value.data!.sellCollateralList![0].loanName!;
              } else {
                loanName = value.data!.sellCollateralList![0].loanName!;
                isSellCollateral = false;
              }
              if (value.data!.sellCollateralList![0].isSellTriggered == 1) {
                isSellTriggered = true;
              } else {
                isSellTriggered = false;
              }
            }
            if (value.data!.unpledgeList!.length != 0) {
              for (int i = 0; i < value.data!.unpledgeList!.length; i++) {
                if (value.data!.unpledgeList![i].unpledgeApplicationAvailable != null) {
                  pendingUnPledgeList.add(value.data!.unpledgeList![i]);
                }
              }
            }
            if (value.data!.topupList!.length != 0) {
              value.data!.topupList!.forEach((v) {
                topUpList.add(v);
              });
              isViewTopUpCard = true;
            } else {
              isViewTopUpCard = false;
            }

            if (value.data!.increaseLoanList!.length != 0) {
              if (value.data!.increaseLoanList![0].increaseLoanAvailable == 1) {
                isIncreaseLoan = true;
                loanName = value.data!.increaseLoanList![0].loanName!;
              } else {
                isIncreaseLoan = false;
              }
            }
            return Visibility(
              visible: isViewLoanSummaryCard,
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    color: colorLightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(Strings.loan_summary,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: appTheme)),
                            ],
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                              sellCollateralTopUpAndUnpledgeList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (sellCollateralTopUpAndUnpledgeList[index]
                                    .unpledgeApplicationAvailable !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .sellCollateralAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .existingTopupApplication ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.unpledge,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .unpledgeApplicationAvailable!
                                          .workflowState!,
                                      odBalance: '',
                                      pendingUnPledge:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .unpledgeApplicationAvailable!,
                                  loanType: loanType);
                                } else if (sellCollateralTopUpAndUnpledgeList[
                                index]
                                    .sellCollateralAvailable !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .unpledgeApplicationAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .existingTopupApplication ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.sell_collateral,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .sellCollateralAvailable!
                                          .workflowState!,
                                      odBalance: '',
                                      pendingSellCollateral:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .sellCollateralAvailable!,
                                      loanType: loanType);
                                } else if (sellCollateralTopUpAndUnpledgeList[
                                index]
                                    .existingTopupApplication !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .sellCollateralAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .unpledgeApplicationAvailable ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.top_up,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .existingTopupApplication!
                                          .workflowState!,
                                      odBalance: '',
                                      loanType: loanType);
                                } else {
                                  return SizedBox();
                                }
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: underProcessLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: underProcessLoanList[index].name!,
                                    status: Strings.under_process_loan,
                                    withdrawal:
                                    underProcessLoanList[index].status!,
                                    odBalance: '',
                                    loanType: loanType);
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: underProcessLoanRenewalList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: underProcessLoanRenewalList[index].name!,
                                    status: Strings.loanRenewal,
                                    withdrawal:
                                    underProcessLoanRenewalList[index].status!,
                                    odBalance: '',
                                    loanType: loanType);
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: actionableLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: actionableLoanList[index].name!,
                                    status: Strings.actionable_loan,
                                    withdrawal: numberToString(
                                        actionableLoanList[index]
                                            .drawingPower!
                                            .toStringAsFixed(2)),
                                    odBalance: numberToString(
                                        actionableLoanList[index]
                                            .balance!
                                            .toStringAsFixed(2)),
                                    odBalanceisNegative: (actionableLoanList[index]
                                        .balance! < 0.0) ? true : false,
                                    loanType: loanType
                                );
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: activeLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: activeLoanList[index].name!,
                                    status: Strings.active_loan,
                                    withdrawal: numberToString(
                                        activeLoanList[index]
                                            .drawingPower!
                                            .toStringAsFixed(2)),
                                    odBalance: numberToString(
                                        activeLoanList[index]
                                            .balance!
                                            .toStringAsFixed(2)),
                                    odBalanceisNegative: (activeLoanList[index]
                                        .balance! < 0) ? true : false,
                                    loanType: loanType
                                );

                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        } else if (value.hasError) {
          return ErrorMessageWidget(error: value.error.toString());
        } else {
          return SizedBox(height: 0);
        }
      },
    );
  }

  // Widget loanSummaryCard2() {
  //   return Visibility(
  //     visible: isViewLoanSummaryCard,
  //     child: Column(
  //       children: [
  //         Card(
  //           elevation: 6.0,
  //           color: colorlightBlue,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Text(Strings.loan_summary,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18, color: appTheme)),
  //                   ],
  //                 ),
  //                 SizedBox(height: 10),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: pendingSellCollateralList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: pendingSellCollateralList[index].loanName,
  //                           status: Strings.sell_collateral,
  //                           withdrawal: pendingSellCollateralList[index].sellCollateralAvailable.workflowState,
  //                           odBalance: '',
  //                           pendingSellCollateral: pendingSellCollateralList[index]);
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: pendingUnPledgeList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: pendingUnPledgeList[index].loanName,
  //                           status: Strings.unpledge,
  //                           withdrawal: pendingUnPledgeList[index].unpledgeApplicationAvailable.workflowState,
  //                           odBalance: '',
  //                           pendingUnPledge: pendingUnPledgeList[index]);
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: underProcessLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: underProcessLoanList[index].name,
  //                           status: Strings.under_process_loan,
  //                           withdrawal: underProcessLoanList[index].status,
  //                           odBalance: '');
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: actionableLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: actionableLoanList[index].loanName,
  //                           status: Strings.actionable_loan,
  //                           withdrawal: numberToString(actionableLoanList[index].drawingPower.toStringAsFixed(2)),
  //                           odBalance: numberToString(actionableLoanList[index].balance.toStringAsFixed(2)));
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: activeLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: activeLoanList[index].name,
  //                           status: Strings.active_loan,
  //                           withdrawal: numberToString(activeLoanList[index].drawingPower.toStringAsFixed(2)),
  //                           odBalance: numberToString(activeLoanList[index].balance.toStringAsFixed(2)));
  //                     }),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //       ],
  //     ),
  //   );
  // }

  Widget pledgedESignCard() {
    return Visibility(
      visible: isViewPledgedESignCard,
      child: eSignLoanList.length != 0
          ? Column(
              children: [
                Card(
                  elevation: 2.0,
                  color: colorLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)), //
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey,
                                    blurRadius: 1,
                                    offset: Offset(1, 0),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        child: Text(Strings.sanction_letter, style: buttonTextRed,),
                                      onTap: (){
                                          Utility.isNetworkConnection().then((isNetwork){
                                            if(isNetwork){
                                              _launchURL(eSignLoanList[0].sanctionLetter!.sanctionLetter);
                                            }else{
                                              Utility.showToastMessage(Strings.no_internet_message);
                                            }
                                          });
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text(loanType == Strings.shares ? Strings.pledged_security : "Lien Schemes",
                                        style: buttonTextRed,
                                      ),
                                      onTap: () {
                                        Utility.isNetworkConnection().then((isNetwork) {
                                          if (isNetwork) {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (BuildContextcontext) =>
                                                    PledgedSecuritiesListScreen(
                                                        eSignLoanList[0]
                                                            .loanApplication!
                                                            .items!,
                                                        eSignLoanList[0]
                                                            .loanApplication!
                                                            .name!,
                                                        eSignLoanList[0]
                                                            .loanApplication!
                                                            .totalCollateralValue!,
                                                        eSignLoanList[0]
                                                            .loanApplication!
                                                            .drawingPower!, loanType),
                                              ),
                                            );
                                          } else {
                                            Utility.showToastMessage(
                                                Strings.no_internet_message);
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(eSignLoanList[0].message!),
                                SizedBox(height: 5),
                                subHeadingText(
                                    eSignLoanList[0].loanApplication!.name!),
                                Text(Strings.loan_application_no,
                                    style: subHeading),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignLoanList[0].loanApplication!.drawingPower!.toStringAsFixed(2))}'),
                                          Text(Strings.sanctioned_limit,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignLoanList[0].loanApplication!.totalCollateralValue!.toStringAsFixed(2))}'),
                                          Text(Strings.total_collateral_value,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0))),
                                      foregroundColor: Colors.white,
                                      backgroundColor: appTheme,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        Strings.e_sign,
                                        style: buttonTextWhite,
                                      ),
                                    ),
                                    onPressed: () async {
                                      String? mobile = await preferences!.getMobile();
                                      String email = await preferences!.getEmail();
                                      Utility.isNetworkConnection().then((isNetwork) {
                                        if (isNetwork) {
                                          // Firebase Event
                                          Map<String, dynamic> parameter = new Map<String, dynamic>();
                                          parameter[Strings.mobile_no] = mobile;
                                          parameter[Strings.email] = email;
                                          parameter[Strings.loan_application_no_prm] = eSignLoanList[0].loanApplication!.name;
                                          parameter[Strings.total_collateral_value_prm] = numberToString(eSignLoanList[0].loanApplication!.totalCollateralValue!.toStringAsFixed(2));
                                          parameter[Strings.sanctioned_limit_prm] = numberToString(eSignLoanList[0].loanApplication!.drawingPower!.toStringAsFixed(2));
                                          parameter[Strings.date_time] = getCurrentDateAndTime();
                                          firebaseEvent(Strings.loan_e_sign_click, parameter);

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (BuildContextcontext) =>
                                                  EsignConsentScreen(
                                                      eSignLoanList[0].loanApplication!.name!,
                                                      0,
                                                      Strings.pledge,
                                                      numberToString(eSignLoanList[0].loanApplication!.totalCollateralValue!.toStringAsFixed(2)),
                                                      numberToString(eSignLoanList[0].loanApplication!.drawingPower!.toStringAsFixed(2)))));
                                        } else {
                                          Utility.showToastMessage(Strings.no_internet_message);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            )
          : SizedBox(),
    );
  }

  Widget loanRenewalESignCard() {
    return Visibility(
      visible: isViewLoanRenewalESignCard,
      child: eSignLoanRenewalList.length != 0
          ? Column(
              children: [
                Card(
                  elevation: 2.0,
                  color: colorLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)), //
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey,
                                    blurRadius: 1,
                                    offset: Offset(1, 0),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        Strings.sanction_letter,
                                        style: buttonTextRed,
                                      ),
                                      onTap: () {
                                        _launchURL(eSignLoanRenewalList[0]
                                            .sanctionLetter!
                                            .sanctionLetter);
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        Strings.loanRenewal,
                                        style: buttonTextRed,
                                      ),
                                      onTap: () {
                                        Utility.isNetworkConnection()
                                            .then((isNetwork) {
                                          if (isNetwork) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContextcontext) =>
                                                    PledgedSecuritiesListScreen(
                                                        eSignLoanRenewalList[0]
                                                            .loanItems!,
                                                        eSignLoanRenewalList[0]
                                                            .loanRenewalApplicationDoc!
                                                            .name!,
                                                        eSignLoanRenewalList[0]
                                                            .loanRenewalApplicationDoc!
                                                            .totalCollateralValue!,
                                                        eSignLoanRenewalList[0]
                                                            .loanRenewalApplicationDoc!
                                                            .drawingPower!,
                                                        loanType),
                                              ),
                                            );
                                          } else {
                                            Utility.showToastMessage(
                                                Strings.no_internet_message);
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(eSignLoanRenewalList[0].mess!),
                                SizedBox(height: 5),
                                subHeadingText(eSignLoanRenewalList[0]
                                    .loanRenewalApplicationDoc!
                                    .name!),
                                Text(Strings.loan_renewal_application,
                                    style: subHeading),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.drawingPower!.toStringAsFixed(2))}'),
                                          Text(Strings.sanctioned_limit,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.totalCollateralValue!.toStringAsFixed(2))}'),
                                          Text(Strings.total_collateral_value,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0))),
                                      foregroundColor: Colors.white,
                                      backgroundColor: appTheme,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        Strings.e_sign,
                                        style: buttonTextWhite,
                                      ),
                                    ),
                                    onPressed: () async {
                                      String? mobile =
                                          await preferences!.getMobile();
                                      String email =
                                          await preferences!.getEmail();
                                      Utility.isNetworkConnection()
                                          .then((isNetwork) {
                                        if (isNetwork) {
                                          // Firebase Event
                                          Map<String, dynamic> parameter =
                                              new Map<String, dynamic>();
                                          parameter[Strings.mobile_no] = mobile;
                                          parameter[Strings.email] = email;
                                          parameter[Strings
                                                  .loan_application_no_prm] =
                                              eSignLoanRenewalList[0]
                                                  .loanRenewalApplicationDoc!
                                                  .name;
                                          parameter[Strings
                                                  .total_collateral_value_prm] =
                                              numberToString(
                                                  eSignLoanRenewalList[0]
                                                      .loanRenewalApplicationDoc!
                                                      .totalCollateralValue!
                                                      .toStringAsFixed(2));
                                          parameter[Strings
                                                  .sanctioned_limit_prm] =
                                              numberToString(
                                                  eSignLoanRenewalList[0]
                                                      .loanRenewalApplicationDoc!
                                                      .drawingPower!
                                                      .toStringAsFixed(2));
                                          parameter[Strings.date_time] =
                                              getCurrentDateAndTime();
                                          firebaseEvent(
                                              Strings.loan_e_sign_click,
                                              parameter);

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (BuildContextcontext) =>
                                            EsignConsentScreen(
                                                eSignLoanRenewalList[0].loanRenewalApplicationDoc!.name!,
                                                2,
                                                Strings.loanRenewal,
                                                numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.totalCollateralValue!.toStringAsFixed(2)),
                                                numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.drawingPower!.toStringAsFixed(2)))));
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  _launchURL(pathPDF) async {
    String dummy = pathPDF;

    if (await canLaunch(dummy)) {
      await launch(dummy);
    } else {
      throw 'Could not launch $dummy';
    }
  }

  Widget increaseESignCard() {
    return Visibility(
      visible: isViewIncreaseESignCard,
      child: eSignIncreaseLoanList.length != 0
          ? Column(
              children: [
                Card(
                  elevation: 2.0,
                  color: colorLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)), //
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey,
                                    blurRadius: 1,
                                    offset: Offset(1, 0),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(Strings.sanction_letter, style: buttonTextRed,),
                                      onTap: (){
                                        Utility.isNetworkConnection().then((isNetwork){
                                          if(isNetwork){
                                            _launchURL(eSignIncreaseLoanList[0].sanctionLetter!.sanctionLetter);
                                          }else{
                                            Utility.showToastMessage(Strings.no_internet_message);
                                          }
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        loanType == Strings.shares ? Strings.pledged_security : "Pledged Scheme",
                                        style: buttonTextRed,
                                      ),
                                      onTap: () {
                                        Utility.isNetworkConnection().then((isNetwork) {
                                          if (isNetwork) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    PledgedSecuritiesListScreen(
                                                  eSignIncreaseLoanList[0]
                                                      .loanApplication!
                                                      .items!,
                                                  eSignIncreaseLoanList[0]
                                                      .loanApplication!
                                                      .name!,
                                                  eSignIncreaseLoanList[0]
                                                      .loanApplication!
                                                      .totalCollateralValue!,
                                                  eSignIncreaseLoanList[0]
                                                      .loanApplication!
                                                      .drawingPower!, loanType
                                                ),
                                              ),
                                            );
                                          } else {
                                            Utility.showToastMessage(Strings.no_internet_message);
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(eSignIncreaseLoanList[0].message!),
                                SizedBox(height: 5),
                                subHeadingText(eSignIncreaseLoanList[0]
                                    .loanApplication!
                                    .name),
                                Text(Strings.loan_application_no,
                                    style: subHeading),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.existingLimit!.toStringAsFixed(2))}'),
                                          Text(Strings.existing_limit,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.newLimit!.toStringAsFixed(2))}'),
                                          Text(Strings.new_limit,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.existingCollateralValue!.toStringAsFixed(2))}'),
                                          Text(
                                              Strings.existing_collateral_value,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText(
                                              '₹${numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.newCollateralValue!.toStringAsFixed(2))}'),
                                          Text(Strings.new_collateral_value,
                                              style: subHeading),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        Strings.e_sign,
                                        style: buttonTextWhite,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appTheme,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0))),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () async {
                                      String? mobile = await preferences!.getMobile();
                                      String email = await preferences!.getEmail();
                                      Utility.isNetworkConnection().then((isNetwork) {
                                        if (isNetwork) {
                                          // Firebase Event
                                          Map<String, dynamic> parameter = new Map<String, dynamic>();
                                          parameter[Strings.mobile_no] = mobile;
                                          parameter[Strings.email] = email;
                                          parameter[Strings.increase_loan_application_no] = eSignIncreaseLoanList[0].loanApplication!.name;
                                          parameter[Strings.existing_total_collateral_value] = numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.existingCollateralValue!.toStringAsFixed(2));
                                          parameter[Strings.new_total_collateral_value] = numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.newCollateralValue!.toStringAsFixed(2));
                                          parameter[Strings.date_time] = getCurrentDateAndTime();
                                          firebaseEvent(Strings.increase_loan_e_sign_click, parameter);

                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext
                                                  context) => EsignConsentScreen(
                                                          eSignIncreaseLoanList[0].loanApplication!.name!,
                                                          0,
                                                          Strings.increase_loan,
                                                          numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.existingCollateralValue!.toStringAsFixed(2)),
                                                          numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.newCollateralValue!.toStringAsFixed(2)))));
                                        } else {
                                          Utility.showToastMessage(Strings.no_internet_message);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            )
          : SizedBox(),
    );
  }

  Widget topUpESignCard() {
    return Visibility(
      visible: isViewTopUpESignCard,
      child: topUpESignLoanList.length != 0
          ? Column(
              children: [
                Card(
                  elevation: 2.0,
                  color: colorLightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)), //
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey,
                                    blurRadius: 1,
                                    offset: Offset(1, 0),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: Text(Strings.sanction_letter, style: buttonTextRed,),
                                      onTap: (){
                                        Utility.isNetworkConnection().then((isNetwork){
                                          if(isNetwork){
                                            _launchURL(topUpESignLoanList[0].sanctionLetter!.sanctionLetter);
                                          }else{
                                            Utility.showToastMessage(Strings.no_internet_message);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(topUpESignLoanList[0].mess!),
                                SizedBox(height: 6),
                                subHeadingText(topUpESignLoanList[0].topupApplicationDoc!.name),
                                Text(Strings.top_up_application_name, style: subHeading),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText('${topUpESignLoanList[0].topupApplicationDoc!.loan}'),
                                          Text(Strings.loan_application_no, style: subHeading),
                                          // SizedBox(height: 10),
                                          // scripsNameText('${topUpESignLoanList[0].topupApplicationDoc!.loan}'),
                                          // Text(Strings.loan_application_no, style: subHeading),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          scripsNameText('₹${topUpESignLoanList[0].topupApplicationDoc!.topUpAmount}'),
                                          Text(Strings.top_up_amount, style: subHeading),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      foregroundColor: Colors.white,
                                      backgroundColor: appTheme,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        Strings.e_sign,
                                        style: buttonTextWhite,
                                      ),
                                    ),
                                    onPressed: () async {
                                      String? mobile = await preferences!.getMobile();
                                      String email = await preferences!.getEmail();

                                      Utility.isNetworkConnection().then((isNetwork) {
                                        if (isNetwork) {
                                          // Firebase Event
                                          Map<String, dynamic> parameter = new Map<String, dynamic>();
                                          parameter[Strings.mobile_no] = mobile;
                                          parameter[Strings.email] = email;
                                          parameter[Strings.top_up_application] = topUpESignLoanList[0].topupApplicationDoc!.name;
                                          parameter[Strings.top_up_amount_prm] = topUpESignLoanList[0].topupApplicationDoc!.topUpAmount;
                                          parameter[Strings.loan_number] = topUpESignLoanList[0].topupApplicationDoc!.loan!;
                                          parameter[Strings.date_time] = getCurrentDateAndTime();
                                          firebaseEvent(Strings.top_up_e_sign_click, parameter);

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (BuildContext context) => EsignConsentScreen(
                                                          topUpESignLoanList[0].topupApplicationDoc!.name!,
                                                          1,
                                                          Strings.top_up,
                                                          topUpESignLoanList[0].topupApplicationDoc!.loan!,
                                                          topUpESignLoanList[0].topupApplicationDoc!.topUpAmount!)));
//                                          }
                                        } else {
                                          Utility.showToastMessage(Strings.no_internet_message);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            )
          : SizedBox(),
    );
  }

  Widget topUpCard() {
    return Visibility(
      visible: isViewTopUpCard,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.check_value_title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: appTheme),
                            ),
                            SizedBox(height: 2),
                            Text(
                              Strings.check_value_subtitle,
                              style: TextStyle(fontSize: 12, color: appTheme),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                decoration: BoxDecoration(
                                    color: colorLightAppTheme,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  Strings.check_value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: () {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    if(isIncreaseLoan){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SubmitTopUP(
                                                      topUpList[0].topUpAmount,
                                                      topUpList[0].loanName)));
                                    }else{
                                      commonDialog(context, "Your increase loan application: ${underProcessLoanList[0].name.toString()} is pending", 0);
                                    }

                                  } else {
                                    Utility.showToastMessage(
                                        Strings.no_internet_message);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(width: 120)
                    ],
                  ),
                ),
                Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AssetsImagePath.top_up),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget pledgePerformanceCard() {
  //   return StreamBuilder(
  //     stream: newDashboardBloc.listAllWeeklyPledged,
  //     builder: (context, AsyncSnapshot<List<WeeklyData>> snapshot) {
  //       if (snapshot.hasData) {
  //         if (snapshot.data == null && snapshot.data!.length == 0) {
  //           return SizedBox(height: 0);
  //         } else {
  //           return Column(
  //             children: [
  //               Card(
  //                 elevation: 2.0,
  //                 color: colorLightGreen,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         height: 200,
  //                         width: double.infinity,
  //                         child: new charts.LineChart(
  //                           _getSeriesData(snapshot.data!),
  //                           animate: true,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text(
  //                         '₹ ${numberToString(snapshot.data![0].weeklyAmountForAllLoans!.toStringAsFixed(2))}',
  //                         style: TextStyle(
  //                             fontSize: 22,
  //                             color: appTheme,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       Row(
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: Text(
  //                               Strings.pledged_text,
  //                               style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: appTheme,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                               child: Image.asset(
  //                                 AssetsImagePath.info,
  //                                 width: 16.0,
  //                                 height: 16.0,
  //                                 color: appTheme,
  //                               ),
  //                               onTap: () {
  //                                 minimumValueDialog();
  //                               })
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //             ],
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         return ErrorMessageWidget(error: snapshot.error.toString());
  //       } else {
  //         return SizedBox(height: 0);
  //       }
  //     },
  //   );
  // }

  Future<void> minimumValueDialog() {
    return showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Container(
                // width: 80,
                // height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.cancel,
                            color: colorLightGray,
                            size: 20,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            Text('Graph Parameter', style: boldTextStyle_24),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('X Axis ➠ ', style: boldTextStyle_14),
                                    Expanded(
                                        child: Text('Number of weeks',
                                            style: regularTextStyle_14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Y Axis ➠ ', style: boldTextStyle_14),
                                    Expanded(
                                        child: Text('Total collateral value',
                                            style: regularTextStyle_14)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ), //
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

//   _getSeriesData(List<WeeklyData> weeklyListData) {
// //    var sort = List.generate(
// //        weeklyListData.length, (index) => weeklyListData[index].week)
// //        .toSet()
// //        .toList();
// //    sort.sort((b, a) => a.compareTo(b));
// //    printLog("sort${sort}");
//     List<charts.Series<WeeklyData, int>> security = [
//       charts.Series(
//         id: "Security",
//         data: weeklyListData,
//         domainFn: (WeeklyData security, _) => security.week!,
//         measureFn: (WeeklyData security, _) => security.weeklyAmountForAllLoans,
//         colorFn: (WeeklyData security, _) =>
//             charts.MaterialPalette.blue.shadeDefault,
//         domainUpperBoundFn: (WeeklyData security, _) => 0,
//         domainLowerBoundFn: (WeeklyData security, _) => 60,
//       )
//     ];
//     return security;
//   }

  Widget categoryItemsCard() {
    return Visibility(
      visible: isViewCategoryItem,
      child: customer!.loanOpen != null && customer!.loanOpen == 1
          ? Column(
              children: [
                Card(
                  elevation: 2.0,
                  color: colorWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Image.asset(AssetsImagePath.increase_limit,
                                    width: 30, height: 30, color: red),
                                SizedBox(height: 5),
                                Text(Strings.increase_loan,
                                    style: TextStyle(
                                        color: appTheme,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            onTap: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  if(loanType == Strings.mutual_fund){
                                    if (isIncreaseLoan) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => MFIncreaseLoan(loanName, Strings.increase_loan, null, loanType!, schemeType!)));
                                    } else {
                                      commonDialog(context, Strings.increase_loan_request_pending, 0);
                                    }
                                  } else {
                                    if (isIncreaseLoan) {
                                      if(sellCollateralTopUpAndUnpledgeList.length != 0 && sellCollateralTopUpAndUnpledgeList[0].existingTopupApplication != null){
                                        commonDialog(context, "Your top-up application: ${sellCollateralTopUpAndUnpledgeList[0].existingTopupApplication!.name.toString()} is pending", 0);
                                      }else{
                                        getLatestLoan();
                                      }
                                    } else {
                                      commonDialog(context, Strings.increase_loan_request_pending, 0);
                                    }
                                  }
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Image.asset(AssetsImagePath.credit_score_icon,
                                    width: 30, height: 30, color: red),
                                SizedBox(height: 5),
                                Text(Strings.check_your_credit_score,
                                    style: TextStyle(
                                        color: appTheme,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            onTap: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  commonDialog(context, Strings.coming_soon, 0);
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Image.asset(AssetsImagePath.sell_collateral,
                                    width: 30, height: 30, color: red),
                                SizedBox(height: 5),
                                Text(loanType == Strings.shares ? Strings.sell_securities : Strings.invoke,
                                    style: TextStyle(
                                        color: appTheme,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            onTap: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  if (isSellCollateral) {
                                    if(!isSellTriggered){
                                      if(loanType == Strings.shares){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    SellCollateralScreen(loanName,
                                                        Strings.all, "", loanType!)));
                                      }else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    MFInvokeScreen(loanName,
                                                        Strings.all, "", "")));
                                      }

                                    } else {
                                      commonDialog(context, Strings.sale_triggered_small, 0);
                                    }
                                  } else {
                                    commonDialog(context, loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending , 0);
                                  }
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: GestureDetector(
                        //     child: Column(
                        //       children: [
                        //         Image.asset(AssetsImagePath.reminder, width: 30, height: 30, color: red),
                        //         SizedBox(height: 5),
                        //         Text(Strings.add_payment_reminder,
                        //             style: TextStyle(
                        //                 color: appTheme, fontSize: 12, fontWeight: FontWeight.bold),
                        //             textAlign: TextAlign.center),
                        //       ],
                        //     ),
                        //     onTap: (){
                        //       Utility.isNetworkConnection().then((isNetwork) {
                        //         if (isNetwork) {
                        //           commonDialog(context, Strings.coming_soon, 0);
                        //         } else {
                        //           Utility.showToastMessage(Strings.no_internet_message);
                        //         }
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            )
          : SizedBox(),
    );
  }

  getLatestLoan() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    myLoansBloc.getLoanDetails(loanName).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        if (value.data!.loan != null) {
          if (value.data!.increaseLoan == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => IncreaseLoanLimit(
                        value.data!.loan!.drawingPower,
                        value.data!.loan!.totalCollateralValue,
                        value.data!.loan!.name,
                        value.data!.loan!.drawingPowerStr,
                        value.data!.loan!.totalCollateralValueStr,
                        value.data!.pledgorBoid)));
          } else {
            commonDialog(context, Strings.increase_loan_request_pending, 0);
          }
        } else {
          commonDialog(context, 'Something went wrong! Try Again', 0);
        }
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        commonDialog(context, value.errorMessage, 0);
      }
    });
  }

  Widget youtubeVideoBanner() {
    return videoIDList.length != 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child:
                    Text(Strings.understanding_lms, style: boldTextStyle_18),
              ),
              SizedBox(height: 6),
              Container(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: videoIDList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoCard(
                      title: videoNameList[index] != null
                          ? videoNameList[index]
                          : "",
                      videoID: videoIDList[index],
                      videoIDList: videoIDList,
                      titleList: videoNameList,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          )
        : SizedBox();
  }

  Widget playVideoCard() {
    return Visibility(
      visible: isViewPlayVideoCard,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(width: 120),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.lms_title,
                          style: TextStyle(
                              fontSize: 22,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          Strings.lms_subtitle,
                          style: TextStyle(
                              fontSize: 14,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                              child: Text(
                                Strings.play_video,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             PlayVideoScreen()));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                        ),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget inviteCard() {
    return Visibility(
      visible: isViewInviteCard,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              Strings.referral,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Strings.rewards,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          Strings.referral_subtitle,
                          style: TextStyle(
                              fontSize: 14,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 32,
                          width: 113,
                          child: Material(
                            color: appTheme,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 1.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    commonDialog(context, Strings.coming_soon, 0);
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.invite_friend,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(AssetsImagePath.rewards_icon,
                      width: 60, height: 60, color: red),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget newLoanCard() {
    return Visibility(
      visible: customer!.bankUpdate == 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          largeHeadingText(Strings.get_your_loan),
          SizedBox(height: 10),
          Center(
            child: Text(
              Strings.financial_needs,
              textAlign: TextAlign.center,
              style: mediumTextStyle_16_gray,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 45,
            width: 130,
            child: Material(
              color: colorBg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                  side: BorderSide(color: red)),
              elevation: 1.0,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      // Firebase Event
                      Map<String, dynamic> parameter = new Map<String, dynamic>();
                      parameter[Strings.mobile_no] = customer!.phone;
                      parameter[Strings.email] = customer!.user;
                      parameter[Strings.date_time] = getCurrentDateAndTime();
                      firebaseEvent(Strings.new_loan_click, parameter);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ApprovedSharesScreen()));
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
                child: Text(
                  Strings.new_loan,
                  style: buttonTextRed,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget kycDetailsPendingCard() {
    return Visibility(
      visible: kycStatus == "New" || kycStatus == "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kycStatus == "Rejected"
                            ? Strings.kyc_details_rejected : Strings.kyc_details_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(kycStatus == "Rejected"
                            ? Strings.update_kyc_again : Strings.kyc_details_text,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    height: 24,
                    width: 81,
                    child: Material(
                      color: appTheme,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CompleteKYCScreen()));
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Text(kycStatus == "Rejected" ?
                        Strings.update_kyc : Strings.add_kyc,
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget kycDetailsVerificationPending() {
    return Visibility(
      visible: kycStatus == "Pending",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.kyc_verification_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          Strings.kyc_verification_process,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget bankDetailsPendingCard() {
    return Visibility(
      visible: customer!.kycUpdate == 1 && (bankStatus == "New" || bankStatus == "Rejected"),
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bankStatus == "Rejected" ? Strings.bank_details_rejected : Strings.bank_details_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                       Text( bankStatus == "Rejected" ? Strings.update_bank_again : Strings.bank_details_text,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    height: 24,
                    width: 86,
                    child: Material(
                      color: appTheme,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BankDetailScreen()));
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Text(bankStatus == "Rejected" ?
                        Strings.update_bank : Strings.add_bank,
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget bankDetailsVerificationPending() {
    return Visibility(
      visible: customer!.kycUpdate == 1 && bankStatus == "Pending",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.bank_verification_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          Strings.bank_verification_process,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanRenewalTimer() {
    return Visibility(
      visible: loanRenewal != null && loanRenewal!.isNotEmpty && isExpired! && loanRenewal![0].status! == "Pending" && loanRenewal![0].timeRemaining != "0D:00h:00m:00s",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 35, width: 35, color: red),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TIME IS TICKING⏰",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        Text("Hurry! Renew Your Loan Before It Expires!",
                            style: TextStyle(color: appTheme, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: appTheme,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          isTimerShow!
                              ?  TweenAnimationBuilder<Duration>(
                              duration: Duration(days: timerDays, hours: timerHours, minutes: timerMin, seconds: timerSec),
                              tween: Tween(
                                  begin: Duration(days: timerDays,hours: timerHours, minutes: timerMin, seconds: timerSec),
                                  end: Duration.zero),
                              onEnd: () {
                                setState(() {
                                  // isTimerDone = true;
                                });
                              },
                              builder: (BuildContext context, Duration? value, Widget? child) {
                                final days = (value!.inDays).toString();
                                final hours = (value.inHours % 24).toString().padLeft(2, '0');
                                final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
                                final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
                                String hour = '';
                                String day = '';
                                if (hours == '0') {
                                  hour = '';
                                } else {
                                  hour = '$hours';
                                }
                                if (days == '0') {
                                  day = '';
                                } else {
                                  day = '$days';
                                }
                                return Column(
                                  children: [
                                    Text(Strings.time_remaining,
                                        style: TextStyle(fontSize: 9, color: Colors.indigo)),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: timerDays < 1 ? Text('$hour:$minutes:$seconds', textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) :
                                            timerDays == 1 ? Text('$day Day $hour Hour', textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) :
                                                timerDays > 1 ? Text('$day Days $hour Hour', textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) : SizedBox(),
                                    ),
                                  ],
                                );
                              })
                              : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('Action Taken',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      )
    );
  }

  Widget loanRenewalPendingCard() {
    return Visibility(
      visible: loanRenewal != null && loanRenewal!.isNotEmpty && loanRenewal![0].tncComplete != 1 && loanRenewal![0].updatedKycStatus != "Pending" && loanRenewal![0].updatedKycStatus! != "Approved" &&  loanRenewal![0].status != "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loanRenewal!.length != 0 ? Text("Loan Renewal Pending!",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)) : Container(),
                        SizedBox(width: 4),
                        loanRenewal!.length != 0 ? loanRenewal![0].isExpired == 0 ? Text("Your loan account number ${loanRenewal![0].loan} is due for renewal. Please renew before the expiry date, ${loanRenewal![0].expiryDate}.",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ) : Text("Your loan account ${loanRenewal![0].loan} is due for renewal. Please RENEW before the time RUNS OUT!",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ) : Container(),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text("Renew Loan",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: () {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      KycUpdateScreen(kycDocName!, loanName, loanRenewal![0].name!)));
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget tncPendingCard() {
    return Visibility(
      visible: loanRenewal!.length != 0 && loanRenewal != null && loanRenewal.toString().isNotEmpty && loanRenewal![0].tncComplete != 1 && loanRenewal![0].updatedKycStatus == "Approved" && loanRenewal![0].updatedKycStatus != "" && loanRenewal![0].status != "Rejected" && loanRenewal![0].tncShow == 0,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Terms and Conditions",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text("Please refer and accept the terms and conditions to proceed with the Loan Renew journey",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text("Click Here",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: () {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoanSummaryScreen(true, loanRenewal![0].name!, loanName)));
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanRenewalVerificationPending() {
    return Visibility(
      visible: loanRenewal!.length != 0 && loanRenewal != null && loanRenewal![0].updatedKycStatus! == "Pending" && loanRenewal![0].tncComplete! == 0 && loanRenewal![0].status != "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("KYC Verification pending",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          "Your KYC verification is in process, please wait for the approval.",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


  Future<void> feedbackDialog(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return FeedbackDialog();
      },
    );
  }

}

class LoanSummaryTile extends StatelessWidget {
  final String? acNo;
  final String? status;
  final String? withdrawal;
  final String? odBalance;
  final SellCollateralAvailable? pendingSellCollateral;
  final UnpledgeApplicationAvailable? pendingUnPledge;
  final bool? odBalanceisNegative;
  final String? loanType;

  const LoanSummaryTile(
      {Key? key,
      this.acNo,
      this.status,
      this.withdrawal,
      this.odBalance,
      this.pendingSellCollateral,
      this.pendingUnPledge,
      this.odBalanceisNegative = false,
      this.loanType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
      decoration: new BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.loan_no,
                    style: TextStyle(fontSize: 10, color: colorLightAppTheme)),
                SizedBox(height: 3),
                Text('$acNo',
                    style: TextStyle(
                        fontSize: 12,
                        color: appTheme,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(width: 12),
            if (status == Strings.active_loan)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.drawing_power,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text('₹$withdrawal',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.loan_balance,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text(odBalanceisNegative! ? negativeValue(double.parse(odBalance!.replaceAll(",", ""))) : '₹$odBalance',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: odBalanceisNegative! ? colorGreen : appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(AssetsImagePath.active_loan_icon,
                        height: 20, width: 20, color: colorGreen),
                    // SizedBox(width: 2),
                    // Image.asset(AssetsImagePath.document,
                    //     height: 20, width: 20, color: appTheme),
                  ],
                ),
              )
            else if (status == Strings.actionable_loan)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.drawing_power,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text('₹$withdrawal',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.loan_balance,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text(odBalanceisNegative! ? negativeValue(double.parse(odBalance!.replaceAll(",", ""))) : '₹$odBalance',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: odBalanceisNegative! ? colorGreen : appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(AssetsImagePath.warning_icon,
                        height: 20, width: 20, color: red),
                    // SizedBox(width: 2),
                    // Image.asset(AssetsImagePath.document,
                    //     height: 20, width: 20, color: appTheme),
                  ],
                ),
              )
            else if (status == Strings.under_process_loan)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(Strings.new_loan,
                            style: TextStyle(
                                fontSize: 10,
                                color: red,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 2),
                        Text('Status',
                            style: TextStyle(fontSize: 10, color: appTheme)),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      withdrawal!,
                      style: TextStyle(
                          fontSize: 12,
                          color: appTheme,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            else if (status == Strings.loanRenewal)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(Strings.loanRenewal,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: red,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 2),
                            Text('Status',
                                style: TextStyle(fontSize: 10, color: appTheme)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          withdrawal!,
                          style: TextStyle(
                              fontSize: 12,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
            else if (status == Strings.sell_collateral)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(loanType == Strings.shares ? Strings.sell_collateral : Strings.invoke,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: red,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),
                              Text('Status',
                                  style:
                                      TextStyle(fontSize: 10, color: appTheme)),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            withdrawal!,
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(AssetsImagePath.info,
                          height: 20, width: 20),
                      onTap: () {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PendingRequestSummary(
                                        Strings.sell_collateral,
                                        pendingSellCollateral!.loan,
                                        pendingSellCollateral!.creation,
                                        pendingSellCollateral!.totalCollateralValue,
                                        pendingSellCollateral!.sellItems!.length,
                                        pendingSellCollateral!.sellItems!,
                                        [],
                                        loanType)));
                          } else {
                            Utility.showToastMessage(
                                Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                  ],
                ),
              )
            else if (status == Strings.unpledge)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: red,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),
                              Text('Status',
                                  style:
                                      TextStyle(fontSize: 10, color: appTheme)),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            withdrawal!,
                            style: TextStyle(
                                fontSize: 12,
                                color: appTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(AssetsImagePath.info,
                          height: 20, width: 20),
                      onTap: () {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PendingRequestSummary(
                                        Strings.unpledge,
                                        pendingUnPledge!.loan,
                                        pendingUnPledge!.creation,
                                        pendingUnPledge!.totalCollateralValue,
                                        pendingUnPledge!.unpledgeItems!.length,
                                        [],
                                        pendingUnPledge!.unpledgeItems!,
                                    loanType)));
                          } else {
                            Utility.showToastMessage(
                                Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                  ],
                ),
              )
            else if (status == Strings.top_up)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(Strings.top_up,
                            style: TextStyle(
                                fontSize: 10,
                                color: red,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 2),
                        Text('Status',
                            style: TextStyle(fontSize: 10, color: appTheme)),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(withdrawal!,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String? videoID;
  final String? title;
  final List<String>? videoIDList;
  final List<String>? titleList;

  const VideoCard(
      {Key? key, this.videoID, this.title, this.videoIDList, this.titleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      // child: GestureDetector(
      // child: RaisedButton(
      child: Card(
        elevation: 2.0,
        color: colorLightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          height: 180,
          width: 300,
          decoration: new BoxDecoration(
            color: colorLightGray,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(children: <Widget>[
            Container(
              height: 180,
              width: 300,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://i3.ytimg.com/vi/${videoID}/maxresdefault.jpg'
                      // 'https://i.ytimg.com/vi/${videoID}/hqdefault.jpg'
                      // 'https://i3.ytimg.com/vi/${videoID}/mqdefault.jpg'
                  ),
                ),
                color: colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: appTheme,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(AssetsImagePath.youtube,
                        height: 30, width: 40, fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            TextButton(
              //TODO:
              // splashColor: Colors.transparent,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10)),
              onPressed: () async {
                Preferences preferences = Preferences();
                String email = await preferences.getEmail();
                String? mobile = await preferences.getMobile();
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    // Firebase Event
                    Map<String, dynamic> parameters = new Map<String, dynamic>();
                    parameters[Strings.mobile_no] = mobile;
                    parameters[Strings.email] = email;
                    parameters[Strings.date_time] = getCurrentDateAndTime();
                    firebaseEvent(Strings.youtube_video_play, parameters);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YoutubeVideoPlayer(
                                videoID!, title!, videoIDList!, titleList!)));
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ]),
        ),
      ),
      //   onTap: () {
      //     Utility.isNetworkConnection().then((isNetwork) {
      //       if (isNetwork) {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => VideoPlayerScreen(
      //                     videoID, title, videoIDList, titleList)));
      //       } else {
      //         Utility.showToastMessage(Strings.no_internet_message);
      //       }
      //     });
      //   },
      // ),
    );
  }
}

class ReusableProcessBar extends StatefulWidget {
  final Icon? processBarIcon;

  ReusableProcessBar({this.processBarIcon});

  @override
  _ReusableProcessBarState createState() => _ReusableProcessBarState();
}

class _ReusableProcessBarState extends State<ReusableProcessBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)) // set rounded corner radius
                    ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15.0,
                    child: widget.processBarIcon)),
          ],
        ),
      ],
    );
  }
}

class ReusableProcessCheckedBar extends StatefulWidget {
  final Icon? processBarIcon;

  ReusableProcessCheckedBar({this.processBarIcon});

  @override
  _ReusableProcessCheckedBarState createState() =>
      _ReusableProcessCheckedBarState();
}

class _ReusableProcessCheckedBarState extends State<ReusableProcessCheckedBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)) // set rounded corner radius
                    ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18.0,
                    child: widget.processBarIcon)),
          ],
        ),
      ],
    );
  }
}

class Fcm {
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    printLog("onBackgroundMessage :: $message");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }
}