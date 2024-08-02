
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/repositories/notification_repository.dart';

class DeleteOrClearNotificationUseCase extends UsecaseWithParams<NotificationResponseEntity, DeleteNotificationParams> {
  final NotificationRepository notificationRepository;

  DeleteOrClearNotificationUseCase(this.notificationRepository);

  @override
  ResultFuture<NotificationResponseEntity> call(DeleteNotificationParams params) async {
    return await notificationRepository.deleteOrClearNotification(params.deleteNotificationEntity);
  }
}

class DeleteNotificationParams {
  final DeleteNotificationEntity deleteNotificationEntity;
  DeleteNotificationParams({
    required this.deleteNotificationEntity,
  });
}

