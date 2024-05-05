import '../ModelWrapper.dart';

class NotificationResponseBean extends ModelWrapper<NotificationData>{
  String? message;
  List<NotificationData>? notificationData;

  NotificationResponseBean({this.message, this.notificationData});

  NotificationResponseBean.fromJson(Map<String, dynamic> json) {
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
}
