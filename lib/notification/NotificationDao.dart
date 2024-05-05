import 'package:choice/network/responsebean/NotificationResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class NotificationDao with BaseDio {

  Future<NotificationResponseBean> getNotificationList() async {
    Dio dio = await getBaseDio();
    NotificationResponseBean wrapper = NotificationResponseBean();
    try {
      Response response = await dio.get(Constants.notificationList);
      if (response.statusCode == 200) {
        wrapper = NotificationResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<NotificationResponseBean> deleteOrClearNotification(int isForRead, int isForClear, String notificationName) async {
    Dio dio = await getBaseDio();
    NotificationResponseBean wrapper = NotificationResponseBean();
    try {
      Response response = await dio.post(Constants.notificationReadOrClear,
          data: {
            ParametersConstants.isForRead: isForRead,
            ParametersConstants.isForClear: isForClear,
            ParametersConstants.notificationName: notificationName,
          });
      if (response.statusCode == 200) {
        wrapper = NotificationResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}
