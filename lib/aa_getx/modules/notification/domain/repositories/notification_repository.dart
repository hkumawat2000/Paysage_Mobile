
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';

abstract class NotificationRepository {
  ResultFuture<NotificationResponseEntity> getNotifications();

  ResultFuture<NotificationResponseEntity> deleteOrClearNotification(DeleteNotificationEntity deleteNotificationEntity);

}