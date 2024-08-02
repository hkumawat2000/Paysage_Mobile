import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
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

  NotificationController(this._getNotificationsUseCase, this._connectionInfo,
      this._deleteOrClearNotificationUseCase);

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
            this._deleteOrClearNotificationUseCase);
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
          notificationNavigator(Get.context!, screenToOpen, loan);
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
      notificationNavigator(Get.context!, screenToOpen, loan);
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
          isResponsed.value = true;
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

    /* notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
    notificationList.value.add(NotificationData(message: "New Message 1",name: "new message", title: "new message", clickAction: "sgjf", isCleared: 0,isRead: 0, loan: "gvj",loanCustomer: "jgj",notificationId: "111",notificationType: "hhhh", screenToOpen: "hj", time: "gfh"));
*/
  }
}
