
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/notification/data/data_source/notification_api.dart';
import 'package:lms/aa_getx/modules/notification/data/models/request/delete_notification_request_model.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/notification_response_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/entities/request/delete_notification_entity.dart';
import 'package:lms/aa_getx/modules/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository{
  final NotificationApi notificationApi;

  NotificationRepositoryImpl(this.notificationApi);

  @override
  ResultFuture<NotificationResponseEntity> getNotifications() async{
    try {
      final notificationsResponse = await notificationApi.getNotifications();
      return DataSuccess(notificationsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg,0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<NotificationResponseEntity> deleteOrClearNotification(DeleteNotificationEntity deleteNotificationEntity)  async {
    try {
      DeleteNotificationRequest deleteNotificationRequest = DeleteNotificationRequest
          .fromEntity(deleteNotificationEntity);
      final deleteClearNotificationResponse = await notificationApi
          .deleteOrClearNotification(deleteNotificationRequest);
      return DataSuccess(deleteClearNotificationResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}