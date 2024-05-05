import 'package:choice/network/responsebean/NotificationResponseBean.dart';
import 'package:choice/notification/NotificationDao.dart';

class NotificationRepository{

  final notificationDao = NotificationDao();

  Future<NotificationResponseBean> getNotificationList() => notificationDao.getNotificationList();

  Future<NotificationResponseBean> deleteOrClearNotification(isForRead, isForClear, notificationName) => notificationDao.deleteOrClearNotification(isForRead, isForClear, notificationName);
}