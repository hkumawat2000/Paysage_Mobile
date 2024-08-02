
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/notification/data/models/notification_response_model.dart';
import 'package:lms/aa_getx/modules/notification/data/models/request/delete_notification_request_model.dart';

abstract class NotificationApi {
  Future<NotificationResponseModel> getNotifications();

  Future<NotificationResponseModel> deleteOrClearNotification(DeleteNotificationRequest deleteNotificationRequest);

}

class NotificationApiImpl with BaseDio implements NotificationApi{

  Future<NotificationResponseModel> getNotifications() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.notificationList);
      if (response.statusCode == 200) {
        return NotificationResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<NotificationResponseModel> deleteOrClearNotification(DeleteNotificationRequest deleteNotificationRequest)  async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.notificationReadOrClear, data: deleteNotificationRequest.toJson());
      if (response.statusCode == 200) {
        return NotificationResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}