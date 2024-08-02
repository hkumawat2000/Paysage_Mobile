
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/network/ModelWrapper.dart';

class NotificationResponseModel extends ModelWrapper<NotificationData> {
  String? message;
  List<NotificationData>? notificationData;

  NotificationResponseModel({this.message, this.notificationData});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notificationData != null) {
      data['data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  NotificationResponseEntity toEntity() =>
      NotificationResponseEntity(
        message: message,
        notificationData:  notificationData != null
            ? notificationData!.map((x) => x.toEntity()).toList()
            : null,
      );
}

class NotificationData {
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

  NotificationData(
      {this.name,
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

  NotificationData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    loanCustomer = json['loan_customer'];
    screenToOpen = json['screen_to_open'];
    notificationId = json['notification_id'];
    clickAction = json['click_action'];
    notificationType = json['notification_type'];
    message = json['message'];
    isCleared = json['is_cleared'];
    isRead = json['is_read'];
    time = json['time'];
    loan = json['loan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['loan_customer'] = this.loanCustomer;
    data['screen_to_open'] = this.screenToOpen;
    data['notification_id'] = this.notificationId;
    data['click_action'] = this.clickAction;
    data['notification_type'] = this.notificationType;
    data['message'] = this.message;
    data['is_cleared'] = this.isCleared;
    data['is_read'] = this.isRead;
    data['time'] = this.time;
    data['loan'] = this.loan;
    return data;
  }

  NotificationDataEntity toEntity() =>
      NotificationDataEntity(
        name: name,
        title:title,
        loanCustomer:loanCustomer,
        screenToOpen:screenToOpen,
        notificationId:notificationId,
        clickAction:clickAction,
        notificationType:notificationType,
        message:message,
        isCleared:isCleared,
        isRead:isRead,
        time:time,
        loan:loan,
      );

  factory NotificationData.fromEntity(NotificationDataEntity notificationDataEntity) {
    return NotificationData(
      title: notificationDataEntity.title != null ? notificationDataEntity.title as String : null,
     time: notificationDataEntity.time != null ? notificationDataEntity.time as String : null,
      screenToOpen: notificationDataEntity.screenToOpen != null ? notificationDataEntity.screenToOpen as String : null,
      notificationType: notificationDataEntity.notificationType != null ? notificationDataEntity.notificationType as String : null,
      notificationId: notificationDataEntity.notificationId != null ? notificationDataEntity.notificationId as String : null,
      loanCustomer: notificationDataEntity.loanCustomer != null ? notificationDataEntity.loanCustomer as String : null,
      loan: notificationDataEntity.loan != null ? notificationDataEntity.loan as String : null,
      isRead: notificationDataEntity.isRead != null ? notificationDataEntity.isRead as int : null,
      isCleared: notificationDataEntity.isCleared != null ? notificationDataEntity.isCleared as int : null,
      clickAction: notificationDataEntity.clickAction != null ? notificationDataEntity.clickAction as String : null,
      name: notificationDataEntity.name != null ? notificationDataEntity.name as String : null,
      message: notificationDataEntity.message != null ? notificationDataEntity.message as String : null,
    );
  }
  }

