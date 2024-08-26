
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/loan_summary_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/new_dashboard_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_loan_summary_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/views/home_view.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetLoanSummaryDataUseCase _getLoanSummaryDataUseCase;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;
  HomeController (this._connectionInfo,  this._getDashboardDataUseCase, this._getLoanSummaryDataUseCase, this._getLoanDetailsUseCase);

  Preferences? preferences = Preferences();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  Rx<CustomerEntity?> customer = CustomerEntity().obs;
  MyLoansBloc myLoansBloc = MyLoansBloc();
  RxBool isTimerDone = false.obs;
  RxBool isAPIResponded = false.obs;
  RxBool isLoanAPIResponded = false.obs;
  RxBool isDashBoardAPIResponded = false.obs;
  RxBool isViewProgressBarIndicator = false.obs;
  RxBool isViewMarginShortFallCard = false.obs;
  RxBool isViewInterestCard = false.obs;
  RxBool isViewLoanSummaryCard = false.obs;
  RxBool isViewPledgedESignCard = false.obs;
  RxBool isViewLoanRenewalESignCard = false.obs;
  RxBool isViewIncreaseESignCard = false.obs;
  RxBool isViewTopUpESignCard = false.obs;
  RxBool isViewTopUpCard = false.obs;
  RxBool isViewCategoryItem = false.obs;
  // bool isViewYoutubeVideo = false;
  RxBool isViewPlayVideoCard = false.obs;
  RxBool isViewInviteCard = false.obs;
  // bool isKYCUpdatePending = false;
  RxBool isKYCComplete = false.obs;
  RxBool viewEmailVisible = false.obs;
  bool isSellCollateral = false;
  bool isSellTriggered = false;
  bool isIncreaseLoan = false;
  bool isMarginSellCollateral = false;
  RxString interestDueDate = ''.obs, totalInterestAmount = ''.obs, profilePhotoUrl = ''.obs;
  RxInt dpdText = 0.obs;
  RxList<LaPendingEsignsEntity> eSignLoanList = <LaPendingEsignsEntity>[].obs;
  RxList<LoanRenewalEsignsEntity> eSignLoanRenewalList = <LoanRenewalEsignsEntity>[].obs;
  RxList<LaPendingEsignsEntity> eSignIncreaseLoanList = <LaPendingEsignsEntity>[].obs;
  RxList<TopupPendingEsignsEntity> topUpESignLoanList = <TopupPendingEsignsEntity>[].obs;
  List<ActiveLoansEntity> activeLoanList = <ActiveLoansEntity>[];
  List<ActionableLoanEntity> actionableLoanList = <ActionableLoanEntity>[];
  List<UnderProcessLaEntity> underProcessLoanList = <UnderProcessLaEntity>[];
  List<UnderProcessLoanRenewalAppEntity> underProcessLoanRenewalList = <UnderProcessLoanRenewalAppEntity>[];
  List<TopupListEntity> topUpList = <TopupListEntity>[];
  RxList<InterestLoanListEntity> interestLoanNameList = <InterestLoanListEntity>[].obs;
  RxList<LoanWithMarginShortfallListEntity> marginShortfallList = <LoanWithMarginShortfallListEntity>[].obs;
  List<SellCollateralListEntity> pendingSellCollateralList = <SellCollateralListEntity>[];
  List<UnpledgeListEntity> pendingUnPledgeList = <UnpledgeListEntity>[];
  RxList<String> videoIDList = <String>[].obs;
  RxList<String> videoNameList = <String>[].obs;
  List<SellCollateralTopupAndUnpledgeListEntity> sellCollateralTopUpAndUnpledgeList = <SellCollateralTopupAndUnpledgeListEntity>[];
  RxString userFullName = ''.obs, loanName = ''.obs;
  RxInt shortFallHours = 0.obs, shortFallMin = 0.obs, shortFallSec = 0.obs;
  var timerDays = 0.obs, timerHours = 0.obs, timerMin = 0.obs, timerSec = 0.obs;
  // var pledgor_oid;
  AndroidNotificationChannel? channel;
  RxInt notificationCount = 0.obs;
  RxInt isTodayHoliday = 0.obs;
  Cron cron = new Cron();
  RxString loanType = "".obs;
  bool? isClicked;
  // bool? isVisitedCams;
  RxString kycStatus = "".obs;
  RxString bankStatus = "".obs;
  RxString baseURL = "".obs;
  RxString kycDocName="".obs;
  RxString hitID = "".obs;
  RxString cibilScore = "".obs;
  RxString cibilScoreDate = "".obs;
  RxBool isExpired = false.obs;
  RxBool isTimerShow = true.obs;
  RxList<LoanRenewalApplicationEntity>? loanRenewal = <LoanRenewalApplicationEntity>[].obs;
  ScrollController hideButtonController = new ScrollController();
  RxBool isUpdateFlushVisible = false.obs;
  bool isUpdateRequired = false;
  String? storeURL, storeWhatsNew;
  RxString schemeType = "".obs;


  @override
  void onInit() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getData();
        callDashBoardApi();
        callLoanStatementApi();
        // newDashboardBloc.getWeeklyPledgedData();
        runClone();
      } else {
        commonDialog(Strings.no_internet_message, 0);
      }
    });
    hideButtonController.addListener(() {
      if (hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
          if(isUpdateRequired) {
            isUpdateFlushVisible.value = false;
          }
      }
      if (hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
          if(isUpdateRequired) {
            isUpdateFlushVisible.value = true;
          }
      }
    });
    super.onInit();
  }

  Future getData() async {
    String? privacyPolicyUrl;
    var base_url = await preferences!.getBaseURL();
    baseURL.value = base_url!;
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
      ///todo: uncomment below code after AdditionalAccountDetailScreen is developed
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => AdditionalAccountDetailScreen(2, "", "", "")));
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

  Future callDashBoardApi() async {
    if (await _connectionInfo.isConnected){
      DataState<NewDashboardResponseEntity> response = await _getDashboardDataUseCase.call();

      if(response is DataSuccess) {
        if (response.data != null) {
          isDashBoardAPIResponded.value = true;
          isTimerDone.value = false;
          marginShortfallList.clear();
          interestLoanNameList.clear();
          videoIDList.clear();
          eSignLoanList.clear();
          eSignLoanRenewalList.clear();
          eSignIncreaseLoanList.clear();
          topUpESignLoanList.clear();
          if (isDashBoardAPIResponded.value && isLoanAPIResponded.value) {
            isAPIResponded.value = true;
          }
          // if(value.data!.userKyc != null){
          //   kycStatus = value.data!.userKyc!.kycStatus!;
          // }else{
          //   kycStatus = "New";
          // }
          if (response.data!.newDashboardData!.customer != null) {
            isViewProgressBarIndicator.value = true;
            isViewCategoryItem.value = true;
            isViewPlayVideoCard.value = true;
            isViewInviteCard.value = true;
            customer.value = response.data!.newDashboardData!.customer;
            // preferences!.setLoanOpen(customer!.loanOpen!);
            viewEmailVisible.value = customer.value!.isEmailVerified == 1 ? false : true;
            // isKYCUpdatePending = customer!.kycUpdate == 0 ? true : false;
            isKYCComplete.value = customer.value!.kycUpdate == 1 ? true : false;
            hitID.value = customer.value!.hitId ?? "";
            cibilScore.value = customer.value!.cibilScore ?? "";
            cibilScoreDate.value = customer.value!.cibilScoreDate ?? "";
            // preferences!.setUserKYC(isKYCComplete);
          }

          if (response.data!.newDashboardData!.userKyc != null) {
            kycDocName.value = response.data!.newDashboardData!.userKyc!.name ?? "";
            String kycType = response.data!.newDashboardData!.userKyc!.kycType!;
            kycStatus.value = response.data!.newDashboardData!.userKyc!.kycStatus!;
            if(kycType == "CHOICE"){
              preferences!.setIsChoiceUser(true);
            }else{
              preferences!.setIsChoiceUser(false);
            }
            if(kycStatus == "Pending" || kycStatus == "Rejected"){
              userFullName.value = response.data!.newDashboardData!.customer!.fullName!;
            }else{
              userFullName.value = response.data!.newDashboardData!.userKyc!.fullname!;
            }

            if(response.data!.newDashboardData!.userKyc!.bankAccount != null && response.data!.newDashboardData!.userKyc!.bankAccount!.length != 0){
              bankStatus.value = response.data!.newDashboardData!.userKyc!.bankAccount![0].bankStatus ?? "";
              if(bankStatus.isEmpty){
                bankStatus.value = "New";
              }
            } else {
              bankStatus.value = "New";
            }
          } else {
            kycStatus.value = "New";
            if (response.data!.newDashboardData!.customer != null) {
              userFullName.value = response.data!.newDashboardData!.customer!.fullName!;
            }
          }

          if (response.data!.newDashboardData!.marginShortfallCard!.loanWithMarginShortfallList != null) {
            isViewMarginShortFallCard.value = true;
            response.data!.newDashboardData!.marginShortfallCard!.loanWithMarginShortfallList!.forEach((v) {
              marginShortfallList.add(v);
            });
            // getMarginShortFallPreferenceValue();
            if (response.data!.newDashboardData!.marginShortfallCard!.earliestDeadline!.isNotEmpty) {
              if (response.data!.newDashboardData!.marginShortfallCard!.earliestDeadline == "00:00:00"
                  || response.data!.newDashboardData!.marginShortfallCard!.loanWithMarginShortfallList![0].status == "Request Pending") {
                isTimerDone.value = true;
              }
              shortFallHours.value = int.parse(response.data!.newDashboardData!.marginShortfallCard!.earliestDeadline!.split(":")[0]);
              shortFallMin.value = int.parse(response.data!.newDashboardData!.marginShortfallCard!.earliestDeadline!.split(":")[1]);
              shortFallSec.value = int.parse(response.data!.newDashboardData!.marginShortfallCard!.earliestDeadline!.split(":")[2]);
            }
            isTodayHoliday.value = response.data!.newDashboardData!.marginShortfallCard!.loanWithMarginShortfallList![0].isTodayHoliday!;
          } else {
            isViewMarginShortFallCard.value = false;
          }

          if (response.data!.newDashboardData!.totalInterestAllLoansCard != null &&
              response.data!.newDashboardData!.totalInterestAllLoansCard!.loansInterestDueDate != null) {
            isViewInterestCard.value = true;
            totalInterestAmount.value = response.data!.newDashboardData!.totalInterestAllLoansCard!.totalInterestAmount!;
            dpdText.value = response.data!.newDashboardData!.totalInterestAllLoansCard!.loansInterestDueDate!.dpdTxt!;
            interestDueDate.value = response.data!.newDashboardData!.totalInterestAllLoansCard!.loansInterestDueDate!.dueDate!;
            response.data!.newDashboardData!.totalInterestAllLoansCard!.interestLoanList!.forEach((v) {
              interestLoanNameList.add(v);
            });
          } else {
            isViewInterestCard.value = false;
          }

          if (response.data!.newDashboardData!.pendingEsignsList!.laPendingEsigns != null &&
              response.data!.newDashboardData!.pendingEsignsList!.laPendingEsigns!.length != 0) {
            if (response.data!.newDashboardData!.pendingEsignsList!.laPendingEsigns![0].increaseLoanMessage == null) {
              response.data!.newDashboardData!.pendingEsignsList!.laPendingEsigns!.forEach((v) {
                eSignLoanList.add(v);
              });
              isViewPledgedESignCard.value = true;
            } else {
              response.data!.newDashboardData!.pendingEsignsList!.laPendingEsigns!.forEach((v) {
                eSignIncreaseLoanList.add(v);
              });
              isViewIncreaseESignCard.value = true;
            }
          }

          // printLog("topupesig${jsonEncode(value.data!.pendingEsignsList!.topupPendingEsigns)}");

          if (response.data!.newDashboardData!.pendingEsignsList!.topupPendingEsigns != null &&
              response.data!.newDashboardData!.pendingEsignsList!.topupPendingEsigns!.length != 0) {
            response.data!.newDashboardData!.pendingEsignsList!.topupPendingEsigns!.forEach((v) {
              topUpESignLoanList.add(v);
            });
            isViewTopUpESignCard.value = true;
          } else {
            isViewTopUpESignCard.value = false;
          }

          if (response.data!.newDashboardData!.pendingEsignsList!.loanRenewalEsigns != null &&
              response.data!.newDashboardData!.pendingEsignsList!.loanRenewalEsigns!.length != 0) {
            response.data!.newDashboardData!.pendingEsignsList!.loanRenewalEsigns!.forEach((v) {
              eSignLoanRenewalList.add(v);
            });
            isViewLoanRenewalESignCard.value = true;
          } else {
            isViewLoanRenewalESignCard.value = false;
          }

          if(response.data!.newDashboardData!.profilePhotoUrl != null) {
            profilePhotoUrl.value = response.data!.newDashboardData!.profilePhotoUrl!;
          }

          if (response.data!.newDashboardData!.fCMUnreadCount != null) {
            notificationCount.value = response.data!.newDashboardData!.fCMUnreadCount!;
          }

          if (response.data!.newDashboardData!.youtubeID != null) {
            // videoNameList.clear();
            response.data!.newDashboardData!.youtubeID!.forEach((v) {
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

          if (response.data!.newDashboardData!.showFeedbackPopup == 1) {
            feedbackDialog();
          }
          // printLog('POP UP VALUE ====>>>> ${value.data!.showFeedbackPopup}');
          setValuesInPreference();
        }
      }else if (response is DataFailed) {
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

  Future callLoanStatementApi() async{
    loanRenewal!.clear();
    isTimerShow.value = true;
    if (await _connectionInfo.isConnected){
      DataState<LoanSummaryResponseEntity> response = await _getLoanSummaryDataUseCase.call();

      if(response is DataSuccess) {
        if(response.data != null){
          loanSummaryCardFunction(response.data!);
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String packageName = packageInfo.packageName;
          String localVersion = packageInfo.version;
          String storeVersion;
          if(packageName == Strings.ios_prod_package || packageName == Strings.android_prod_package) {
            if(Platform.isAndroid) {
              storeURL = response.data!.loanSummaryData!.versionDetails!.playStoreLink!;
              storeVersion = response.data!.loanSummaryData!.versionDetails!.androidVersion!;
            } else {
              storeURL = response.data!.loanSummaryData!.versionDetails!.appStoreLink!;
              storeVersion = response.data!.loanSummaryData!.versionDetails!.iosVersion!;
            }
            storeWhatsNew = response.data!.loanSummaryData!.versionDetails!.whatsNew!;
            bool canUpdateValue = await Utility().canUpdateVersion(storeVersion, localVersion);
            debugPrint("storeVersion2 ==> $storeVersion");
            debugPrint("localVersion2 ==> $localVersion");
            debugPrint("canUpdateValue2 ==> $canUpdateValue");
            if(canUpdateValue != null && canUpdateValue && response.data!.loanSummaryData!.versionDetails!.forceUpdate == 0){
              isUpdateRequired = true;
              isUpdateFlushVisible.value = true;
            }
          }

          loanType.value = response.data!.loanSummaryData!.instrumentType!;
          schemeType.value = response.data!.loanSummaryData!.schemeType!;
          if(response.data!.loanSummaryData!.loanRenewalApplication != null && response.data!.loanSummaryData!.loanRenewalApplication!.length != 0){
            loanRenewal!.addAll(response.data!.loanSummaryData!.loanRenewalApplication!);
            if(loanRenewal![0].isExpired == 1){
              isExpired.value = true;
              if(loanRenewal![0].actionStatus == "Pending"){
                isTimerShow.value = false;
              }
              if(loanRenewal![0].timeRemaining != null){
                timerDays.value = int.parse(response.data!.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[0][0]); // 5D:12h:35m:20s
                timerHours.value = int.parse((response.data!.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[1]).substring(0, 2));
                timerMin.value = int.parse((response.data!.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[2]).substring(0, 2));
                timerSec.value = int.parse((response.data!.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[3]).substring(0, 2));
              }
            }
          }
          isLoanAPIResponded.value = true;
          if (isDashBoardAPIResponded.value && isLoanAPIResponded.value) {
            isAPIResponded.value = true;
          }
          if (response.data!.loanSummaryData!.topupList!.length != 0) {
            isViewTopUpCard.value = true;
          }
          if (response.data!.loanSummaryData!.activeLoans!.length != 0 ||
              response.data!.loanSummaryData!.actionableLoan!.length != 0 ||
              response.data!.loanSummaryData!.underProcessLa!.length != 0 ||
              response.data!.loanSummaryData!.underProcessLoanRenewalApp!.length != 0) {
            isViewLoanSummaryCard.value = true;
          }
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

    /*newDashboardBloc.getLoanSummaryData().then((value) async{
        if (value.isSuccessFull!) {
          ///todo uncomment this loanSummaryCardFunction(value);
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
            debugPrint("storeVersion2 ==> $storeVersion");
            debugPrint("localVersion2 ==> $localVersion");
            debugPrint("canUpdateValue2 ==> $canUpdateValue");
            if(canUpdateValue != null && canUpdateValue && value.loanSummaryData!.versionDetails!.forceUpdate == 0){
              isUpdateRequired = true;
              isUpdateFlushVisible.value = true;
            }
          }

            loanType.value = value.loanSummaryData!.instrumentType!;
            schemeType.value = value.loanSummaryData!.schemeType!;
            if(value.loanSummaryData!.loanRenewalApplication != null && value.loanSummaryData!.loanRenewalApplication!.length != 0){
              ///todo uncomment this  loanRenewal!.addAll(value.loanSummaryData!.loanRenewalApplication!);
              if(loanRenewal![0].isExpired == 1){
                isExpired.value = true;
                if(loanRenewal![0].actionStatus == "Pending"){
                  isTimerShow.value = false;
                }
                if(loanRenewal![0].timeRemaining != null){
                  timerDays.value = int.parse(value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[0][0]); // 5D:12h:35m:20s
                  timerHours.value = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[1]).substring(0, 2));
                  timerMin.value = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[2]).substring(0, 2));
                  timerSec.value = int.parse((value.loanSummaryData!.loanRenewalApplication![0].timeRemaining!.split(":")[3]).substring(0, 2));
                }
              }
            }
            isLoanAPIResponded.value = true;
            if (isDashBoardAPIResponded.value && isLoanAPIResponded.value) {
              isAPIResponded.value = true;
            }
            if (value.loanSummaryData!.topupList!.length != 0) {
              isViewTopUpCard.value = true;
            }
            if (value.loanSummaryData!.activeLoans!.length != 0 ||
                value.loanSummaryData!.actionableLoan!.length != 0 ||
                value.loanSummaryData!.underProcessLa!.length != 0 ||
                value.loanSummaryData!.underProcessLoanRenewalApp!.length != 0) {
              isViewLoanSummaryCard.value = true;
            }
        }
    });*/
  }

  setValuesInPreference() async {
    preferences!.setEmail(customer.value!.user!);
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
        debugPrint("TITLE ==> $title");
          videoNameList[index] = title;
      } else {
        title = "";
      }
    } on FormatException catch (e) {
      debugPrint('invalid JSON' + e.toString());
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
        commonDialog(Strings.no_internet_message, 0);
      }
    });
  }


  getLatestLoan() async {
    showDialogLoading(Strings.please_wait);
    if (await _connectionInfo.isConnected) {
      GetLoanDetailsRequestEntity loanDetailsRequestEntity =
          GetLoanDetailsRequestEntity(
        loanName: loanName.value,
        transactionsPerPage: 15,
        transactionsStart: 0,
      );
      DataState<LoanDetailsResponseEntity> loanDetailsResponse =
          await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
              loanDetailsRequestEntity: loanDetailsRequestEntity));
      Get.back();
      if (loanDetailsResponse is DataSuccess) {
        if (loanDetailsResponse.data!.data!.loan != null) {
          if (loanDetailsResponse.data!.data!.increaseLoan == 1) {
            ///todo: uncomment below code after IncreaseLoanLimit is developed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => IncreaseLoanLimit(
            //             value.data!.loan!.drawingPower,
            //             value.data!.loan!.totalCollateralValue,
            //             value.data!.loan!.name,
            //             value.data!.loan!.drawingPowerStr,
            //             value.data!.loan!.totalCollateralValueStr,
            //             value.data!.pledgorBoid)));
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        } else {
          commonDialog('Something went wrong! Try Again', 0);
        }
      } else if (loanDetailsResponse is DataFailed) {
        if (loanDetailsResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(loanDetailsResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }

    /*myLoansBloc.getLoanDetails(loanName).then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        if (value.data!.loan != null) {
          if (value.data!.increaseLoan == 1) {
            ///todo: uncomment below code after IncreaseLoanLimit is developed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => IncreaseLoanLimit(
            //             value.data!.loan!.drawingPower,
            //             value.data!.loan!.totalCollateralValue,
            //             value.data!.loan!.name,
            //             value.data!.loan!.drawingPowerStr,
            //             value.data!.loan!.totalCollateralValueStr,
            //             value.data!.pledgorBoid)));
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        } else {
          commonDialog('Something went wrong! Try Again', 0);
        }
      } else if (value.errorCode == 403) {
        commonDialog( Strings.session_timeout, 4);
      } else {
        commonDialog(value.errorMessage, 0);
      }
    });*/
  }

  void notificationIconClicked() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        final notificationResult = await Get.toNamed(notificationView);
        if(notificationResult != null) {
          if(notificationCount != 0){
            pullRefresh();
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  settingsClicked() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        final result = await Get.toNamed(accountSettingsView);
        if(result != null) {
          if (profilePhotoUrl.isEmpty) {
            pullRefresh();
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> marginShortfallClicked() async {



    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        showDialogLoading( Strings.please_wait);
        ///todo: Need to move below api call in margin shortfall onInit
        myLoansBloc.getLoanDetails(marginShortfallList[0].name).then((value) async {
          Get.back();
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

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (BuildContext context) =>
            //         MarginShortfallScreen(
            //             value.data!,
            //             value.data!.pledgorBoid!,
            //             isMarginSellCollateral,
            //             marginShortfallList[0].status == "Sell Triggered" ? true : false,
            //             marginShortfallList[0].status == "Request Pending" ? true : false,
            //             value.data!.marginShortfall!.actionTakenMsg ?? "",
            //             loanType!,schemeType!)));
          } else if (value.errorCode == 403) {
            commonDialog(Strings.session_timeout, 4);
          } else {
            commonDialog( value.errorMessage, 0);
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void goToInterestScreen() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after InterestScreen is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             InterestScreen(
        //                 interestLoanNameList[0]
        //                     .interestAmount!,
        //                 interestLoanNameList[0].loanName!,
        //                 actionableLoanList[0].balance!,
        //                 interestDueDate!)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void sanctionLetterClicked() {
    Utility.isNetworkConnection().then((isNetwork){
      if(isNetwork){
        launchURL(eSignLoanList[0].sanctionLetter!.sanctionLetter);
      }else{
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future launchURL(pathPDF) async {
    String dummy = pathPDF;

    if (await canLaunchUrlString(dummy)) {
      await launchUrlString(dummy);
    } else {
      throw 'Could not launch $dummy';
    }
  }

  void goToPledgedSecuritiesListScreen() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after PledgedSecuritiesListScreen is developed
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (BuildContextcontext) =>
        //       PledgedSecuritiesListScreen(
        //           eSignLoanList[0]
        //               .loanApplication!
        //               .items!,
        //           eSignLoanList[0]
        //               .loanApplication!
        //               .name!,
        //           eSignLoanList[0]
        //               .loanApplication!
        //               .totalCollateralValue!,
        //           eSignLoanList[0]
        //               .loanApplication!
        //               .drawingPower!, loanType),
        // ),
        // );
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  Future<void> eSignClicked() async {
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
        ///todo: uncomment below code after EsignConsentScreen is developed
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContextcontext) =>
        //         EsignConsentScreen(
        //             eSignLoanList[0].loanApplication!.name!,
        //             0,
        //             Strings.pledge,
        //             numberToString(eSignLoanList[0].loanApplication!.totalCollateralValue!.toStringAsFixed(2)),
        //             numberToString(eSignLoanList[0].loanApplication!.drawingPower!.toStringAsFixed(2)))));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void loanRenewalClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after PledgedSecuritiesListScreen is developed
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContextcontext) =>
        //         PledgedSecuritiesListScreen(
        //             eSignLoanRenewalList[0]
        //                 .loanItems!,
        //             eSignLoanRenewalList[0]
        //                 .loanRenewalApplicationDoc!
        //                 .name!,
        //             eSignLoanRenewalList[0]
        //                 .loanRenewalApplicationDoc!
        //                 .totalCollateralValue!,
        //             eSignLoanRenewalList[0]
        //                 .loanRenewalApplicationDoc!
        //                 .drawingPower!,
        //             loanType),
        //   ),
        // );
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  Future<void> goToEsignConsentScreen() async {
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
        ///todo: uncomment below code after EsignConsentScreen is developed
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContextcontext) =>
        //         EsignConsentScreen(
        //             eSignLoanRenewalList[0].loanRenewalApplicationDoc!.name!,
        //             2,
        //             Strings.loanRenewal,
        //             numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.totalCollateralValue!.toStringAsFixed(2)),
        //             numberToString(eSignLoanRenewalList[0].loanRenewalApplicationDoc!.drawingPower!.toStringAsFixed(2)))));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void pledgedSecurityOrSchemeClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after PledgedSecuritiesListScreen is developed
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext
        //     context) =>
        //         PledgedSecuritiesListScreen(
        //             eSignIncreaseLoanList[0]
        //                 .loanApplication!
        //                 .items!,
        //             eSignIncreaseLoanList[0]
        //                 .loanApplication!
        //                 .name!,
        //             eSignIncreaseLoanList[0]
        //                 .loanApplication!
        //                 .totalCollateralValue!,
        //             eSignIncreaseLoanList[0]
        //                 .loanApplication!
        //                 .drawingPower!, loanType
        //         ),
        //   ),
        // );
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> eSignIncreaseLoanClicked() async {
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

        ///todo: uncomment below code after EsignConsentScreen is developed
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext
        // context) => EsignConsentScreen(
        //     eSignIncreaseLoanList[0].loanApplication!.name!,
        //     0,
        //     Strings.increase_loan,
        //     numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.existingCollateralValue!.toStringAsFixed(2)),
        //     numberToString(eSignIncreaseLoanList[0].increaseLoanMessage!.newCollateralValue!.toStringAsFixed(2)))));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> topUpESignClicked() async {
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

        ///todo: uncomment below code after EsignConsentScreen is developed
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) => EsignConsentScreen(
        //         topUpESignLoanList[0].topupApplicationDoc!.name!,
        //         1,
        //         Strings.top_up,
        //         topUpESignLoanList[0].topupApplicationDoc!.loan!,
        //         topUpESignLoanList[0].topupApplicationDoc!.topUpAmount!)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void topUpLoanClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(isIncreaseLoan){
          ///todo: uncomment below code after SubmitTopUP is developed
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             SubmitTopUP(
          //                 topUpList[0].topUpAmount,
          //                 topUpList[0].loanName)));
        }else{
          commonDialog( "Your increase loan application: ${underProcessLoanList[0].name.toString()} is pending", 0);
        }

      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void increaseLoanClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(loanType == Strings.mutual_fund){
          if (isIncreaseLoan) {
            ///todo: uncomment below code after MFIncreaseLoan is developed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => MFIncreaseLoan(loanName, Strings.increase_loan, null, loanType!, schemeType!)));
          } else {
            commonDialog( Strings.increase_loan_request_pending, 0);
          }
        } else {
          if (isIncreaseLoan) {
            if(sellCollateralTopUpAndUnpledgeList.length != 0 && sellCollateralTopUpAndUnpledgeList[0].existingTopupApplication != null){
              commonDialog( "Your top-up application: ${sellCollateralTopUpAndUnpledgeList[0].existingTopupApplication!.name.toString()} is pending", 0);
            }else{
              getLatestLoan();
            }
          } else {
            commonDialog( Strings.increase_loan_request_pending, 0);
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void sellSecuritiesOrInvokeClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (isSellCollateral) {
          if(!isSellTriggered){
            if(loanType == Strings.shares){
              ///todo: uncomment below code after SellCollateralScreen is developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             SellCollateralScreen(loanName,
              //                 Strings.all, "", loanType!)));
            }else{
              ///todo: uncomment below code after MFInvokeScreen is developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             MFInvokeScreen(loanName,
              //                 Strings.all, "", "")));
            }
          } else {
            commonDialog( Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog( loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending , 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void newLoanClicked()  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = customer.value!.phone;
        parameter[Strings.email] = customer.value!.user;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.new_loan_click, parameter);
        ///todo: uncomment below code after ApprovedSharesScreen is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             ApprovedSharesScreen()));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void goToCompleteKYCScreen() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after CompleteKYCScreen is developed
        Get.toNamed(kycView);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             CompleteKYCScreen()));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void goToBankDetailScreen()  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after BankDetailScreen is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             BankDetailScreen()));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void goToKycUpdateScreen()  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after KycUpdateScreen is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             KycUpdateScreen(controller.kycDocName!, controller.loanName, controller.loanRenewal![0].name!)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void goToLoanSummaryScreen()  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after LoanSummaryScreen is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             LoanSummaryScreen(true, loanRenewal![0].name!, loanName)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void gotoPendingRequestSummarySellCollateral(SellCollateralAvailableEntity? pendingSellCollateral, String? loanType) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after PendingRequestSummary is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PendingRequestSummary(
        //             Strings.sell_collateral,
        //             pendingSellCollateral!.loan,
        //             pendingSellCollateral!.creation,
        //             pendingSellCollateral!.totalCollateralValue,
        //             pendingSellCollateral!.sellItems!.length,
        //             pendingSellCollateral!.sellItems!,
        //             [],
        //             loanType)));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  Future goToYoutubeVideoPlayer()  async {
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
        ///todo: uncomment below code after YoutubeVideoPlayer is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => YoutubeVideoPlayer(
        //             videoID!, title!, videoIDList!, titleList!)));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void gotoPendingRequestSummaryUnpledgeRevoke(UnpledgeApplicationAvailableEntity? pendingUnPledge, String? loanType)  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: uncomment below code after PendingRequestSummary is developed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PendingRequestSummary(
        //             Strings.unpledge,
        //             pendingUnPledge!.loan,
        //             pendingUnPledge!.creation,
        //             pendingUnPledge!.totalCollateralValue,
        //             pendingUnPledge!.unpledgeItems!.length,
        //             [],
        //             pendingUnPledge!.unpledgeItems!,
        //             loanType)));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void loanSummaryCardFunction(LoanSummaryResponseEntity value) {

    //stream: controller.newDashboardBloc.listLoanSummary,

      sellCollateralTopUpAndUnpledgeList.clear();
      actionableLoanList.clear();
      activeLoanList.clear();
      underProcessLoanList.clear();
      underProcessLoanRenewalList.clear();
      pendingSellCollateralList.clear();
      pendingUnPledgeList.clear();
      topUpList.clear();
      if (value.loanSummaryData!.sellCollateralTopupAndUnpledgeList!.length != 0) {
        value.loanSummaryData!.sellCollateralTopupAndUnpledgeList!.forEach((v) {
          sellCollateralTopUpAndUnpledgeList.add(v);
        });
      }

      if (value.loanSummaryData!.activeLoans!.length != 0 ||
          value.loanSummaryData!.actionableLoan!.length != 0 ||
          value.loanSummaryData!.underProcessLa!.length != 0 ||
          value.loanSummaryData!.underProcessLoanRenewalApp!.length != 0) {
        if (value.loanSummaryData!.actionableLoan!.length != 0) {
          value.loanSummaryData!.actionableLoan!.forEach((v) {
            actionableLoanList.add(v);
          });
        }
        if (value.loanSummaryData!.activeLoans!.length != 0) {
          value.loanSummaryData!.activeLoans!.forEach((v) {
            activeLoanList.add(v);
          });
        }
        if (value.loanSummaryData!.underProcessLa!.length != 0) {
          value.loanSummaryData!.underProcessLa!.forEach((v) {
            underProcessLoanList.add(v);
          });
        }
        if (value.loanSummaryData!.underProcessLoanRenewalApp != null && value.loanSummaryData!.underProcessLoanRenewalApp!.length != 0) {
          value.loanSummaryData!.underProcessLoanRenewalApp!.forEach((v) {
            underProcessLoanRenewalList.add(v);
          });
        }
        isViewLoanSummaryCard.value = true;
      }

      if (value.loanSummaryData!.activeLoans!.length == 0 &&
          value.loanSummaryData!.actionableLoan!.length == 0 &&
          value.loanSummaryData!.underProcessLa!.length == 0 &&
          value.loanSummaryData!.underProcessLoanRenewalApp!.length == 0) {
        isViewLoanSummaryCard.value = false;
      }

      if (value.loanSummaryData!.sellCollateralList!.length != 0) {
        for (int i = 0; i < value.loanSummaryData!.sellCollateralList!.length; i++) {
          if (value.loanSummaryData!.sellCollateralList![i].sellCollateralAvailable != null) {
            pendingSellCollateralList.add(value.loanSummaryData!.sellCollateralList![i]);
          }
        }
        if (value.loanSummaryData!.sellCollateralList![0].sellCollateralAvailable == null) {
          isSellCollateral = true;
          loanName.value = value.loanSummaryData!.sellCollateralList![0].loanName!;
        } else {
          loanName.value = value.loanSummaryData!.sellCollateralList![0].loanName!;
          isSellCollateral = false;
        }
        if (value.loanSummaryData!.sellCollateralList![0].isSellTriggered == 1) {
          isSellTriggered = true;
        } else {
          isSellTriggered = false;
        }
      }
      if (value.loanSummaryData!.unpledgeList!.length != 0) {
        for (int i = 0; i < value.loanSummaryData!.unpledgeList!.length; i++) {
          if (value.loanSummaryData!.unpledgeList![i].unpledgeApplicationAvailable != null) {
            pendingUnPledgeList.add(value.loanSummaryData!.unpledgeList![i]);
          }
        }
      }
      if (value.loanSummaryData!.topupList!.length != 0) {
        value.loanSummaryData!.topupList!.forEach((v) {
          topUpList.add(v);
        });
        isViewTopUpCard.value = true;
      } else {
        isViewTopUpCard.value = false;
      }

      if (value.loanSummaryData!.increaseLoanList!.length != 0) {
        if (value.loanSummaryData!.increaseLoanList![0].increaseLoanAvailable == 1) {
          isIncreaseLoan = true;
          loanName.value = value.loanSummaryData!.increaseLoanList![0].loanName!;
        } else {
          isIncreaseLoan = false;
        }
      }

  }

  creditCheckClick() {
    if(hitID.value.isNotEmpty){
      Get.toNamed(cibilResultView, arguments: CibilResultArgs(
        hitId: hitID.value,
        cibilScore: cibilScore.value,
        cibilScoreDate: cibilScoreDate.value,
      ));
    } else {
      Get.toNamed(cibilView, arguments: CibilArgs(
        hitId: hitID.value,
        cibilScore: cibilScore.value,
        cibilScoreDate: cibilScoreDate.value,
      ));
    }
  }

}
