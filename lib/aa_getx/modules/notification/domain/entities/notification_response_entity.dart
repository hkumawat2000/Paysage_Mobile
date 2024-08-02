
import 'package:lms/network/ModelWrapper.dart';

class NotificationResponseEntity extends ModelWrapper<NotificationDataEntity> {
  String? message;
  List<NotificationDataEntity>? notificationData;

  NotificationResponseEntity({this.message, this.notificationData});
}

class NotificationDataEntity {
  String? name;
  String? title;
  String? loanCustomer;
  String? screenToOpen;
  String? notificationId;
  String? clickAction;
  String? notificationType;
  String? message;
  int? isCleared;
  int? isRead;
  String? time;
  String? loan;

  NotificationDataEntity({this.name,
    this.title,
    this.loanCustomer,
    this.screenToOpen,
    this.notificationId,
    this.clickAction,
    this.notificationType,
    this.message,
    this.isCleared,
    this.isRead,
    this.time,
    this.loan});
}