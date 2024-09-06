import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/arguments/margin_shortfall_arguments.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/delete_clear_notification_usecase.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/get_notification_usecase.dart';
import 'package:lms/aa_getx/modules/notification/presentation/views/notification_view.dart';
import 'package:lms/notification/NotificationBloc.dart';

class NotificationController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final notificationBloc = NotificationBloc();
  RxList<NotificationDataEntity> notificationList =
      <NotificationDataEntity>[].obs;
  RxBool isResponsed = false.obs;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final ConnectionInfo _connectionInfo;
  final DeleteOrClearNotificationUseCase _deleteOrClearNotificationUseCase;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;

  NotificationController(this._getNotificationsUseCase, this._connectionInfo,
      this._deleteOrClearNotificationUseCase, this._getLoanDetailsUseCase);

// final SlidableController slidableController = SlidableController();

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  Future<bool> willPopCallback() async {
    Get.back(result: "cancel");
    return true;
  }

  clearAllClicked() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        NotificationController controller = NotificationController(
            this._getNotificationsUseCase,
            this._connectionInfo,
            this._deleteOrClearNotificationUseCase,
            this._getLoanDetailsUseCase);
        deleteDialog("", Strings.clear_all, controller);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void onDismissClicked(NotificationDataEntity notificationList) {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        deleteApiCall(notificationList.name!, Strings.delete);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future noClicked() async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        Get.back(result: false);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void yesClicked(String name, String isComingFor) {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        Get.back(result: true);
        deleteApiCall(name, isComingFor);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future deleteApiCall(String name, String isComingFor) async {
    DeleteNotificationEntity deleteNotificationEntity =
        DeleteNotificationEntity(
            isForRead: 0, isForClear: 1, notificationName: name);
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      DataState<NotificationResponseEntity> response =
          await _deleteOrClearNotificationUseCase.call(DeleteNotificationParams(
              deleteNotificationEntity: deleteNotificationEntity));
      Get.back(); //pop dialog
      debugPrint("response block");
      debugPrint("response   ${response.data}");
      if (response is DataSuccess) {
        if (response.data != null) {
          if (isComingFor == Strings.delete) {
            notificationList.removeWhere((element) => element.name == name);
          } else if (isComingFor == Strings.clear_all) {
            notificationList.clear();
          }
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
      debugPrint("Strings.no_internet_message  ${Strings.no_internet_message}");
    }
  }

  notificationClicked(int index, int isRead, String name, String screenToOpen,
      String? loan) async {
    if (isRead == 0) {
      showDialogLoading(Strings.please_wait);

      DeleteNotificationEntity deleteNotificationEntity =
          DeleteNotificationEntity(
              isForRead: 1, isForClear: 0, notificationName: name);
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
          notificationList[index].isRead = 1;
          notificationNavigator(screenToOpen, loan);
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
        debugPrint(
            "Strings.no_internet_message  ${Strings.no_internet_message}");
      }
    } else {
      notificationNavigator(screenToOpen, loan);
    }
  }

  Future<void> getNotifications() async {
    if (await _connectionInfo.isConnected) {
      DataState<NotificationResponseEntity> response =
          await _getNotificationsUseCase.call();
      if (response is DataSuccess) {
        if (response.data != null) {
          if (response.data!.notificationData != null &&
              response.data!.notificationData!.length != 0) {
            notificationList.addAll(response.data!.notificationData!);
            notificationList.removeWhere((element) => element.isCleared == 1);
          }
        }
        isResponsed.value = true;
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

    /* notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
*/
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
