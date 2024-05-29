import 'dart:async';

import 'package:lms/network/responsebean/LenderResponseBean.dart';
import 'package:lms/network/responsebean/NotificationResponseBean.dart';
import 'package:lms/notification/NotificationRepository.dart';

class NotificationBloc {
  final notificationRepository = NotificationRepository();

  final _notificationController = StreamController<List<NotificationData>>.broadcast();

  get notificationList => _notificationController.stream;

  Future<NotificationResponseBean> getNotification() async {
    NotificationResponseBean notificationResponseBean = await notificationRepository.getNotificationList();
    if (notificationResponseBean.isSuccessFull!) {
      if(notificationResponseBean.notificationData != null){
        _notificationController.sink.add(notificationResponseBean.notificationData!);
      }
    } else {
      if (notificationResponseBean.errorCode == 403) {
        _notificationController.sink.addError(notificationResponseBean.errorCode.toString());
      } else {
        _notificationController.sink.addError(notificationResponseBean.errorMessage!);
      }
    }
    return notificationResponseBean;
  }

  Future<NotificationResponseBean> deleteOrClearNotification(isForRead, isForClear, notificationName) async {
    NotificationResponseBean notificationResponseBean = await notificationRepository
        .deleteOrClearNotification(isForRead, isForClear, notificationName);
    return notificationResponseBean;
  }

  void dispose() {
    _notificationController.close();
  }
}
