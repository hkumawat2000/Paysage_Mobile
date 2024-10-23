import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';

class DeleteNotificationRequest {
  int? isForRead;
  int? isForClear;
  String? notificationName;

  DeleteNotificationRequest(
  {required this.isForRead, required this.isForClear, required this.notificationName});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_for_read'] = isForRead;
    data['is_for_clear'] = isForClear;
    data['notification_name'] = notificationName;
    return data;
  }

  DeleteNotificationEntity toEntity() => DeleteNotificationEntity(
    isForClear: isForClear,
    isForRead: isForRead,
    notificationName: notificationName,
  );

  factory DeleteNotificationRequest.fromEntity(
      DeleteNotificationEntity deleteNotificationEntity) {
    return DeleteNotificationRequest(
      isForClear: deleteNotificationEntity.isForClear,
      isForRead: deleteNotificationEntity.isForRead,
      notificationName: deleteNotificationEntity.notificationName,
    );
  }
}
