
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase
    extends UsecaseWithoutParams<NotificationResponseEntity> {
  final NotificationRepository notificationRepository;

  GetNotificationsUseCase(this.notificationRepository);

  @override
  ResultFuture<NotificationResponseEntity> call() async {
    return await notificationRepository.getNotifications();
  }
}