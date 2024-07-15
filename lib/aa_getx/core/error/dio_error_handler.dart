import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/util/Utility.dart';

class DioErrorHandler {
  static bool isInternet = false;

  static ErrorCodeAndMesage handleDioError(DioException error) {
    internetChecker();
    if (isInternet) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return ErrorCodeAndMesage(0, Strings.requestCancelledErrorMsg);
        case DioExceptionType.connectionTimeout:
          return ErrorCodeAndMesage(0, Strings.connectionTimeoutErrorMsg);
        case DioExceptionType.sendTimeout:
          return ErrorCodeAndMesage(0, Strings.sendTimeoutErrorMsg);
        case DioExceptionType.receiveTimeout:
          return ErrorCodeAndMesage(0, Strings.receiveTimeoutErrorMsg);
        case DioExceptionType.badResponse:
          return _handleResponseError(error.response!);
        case DioExceptionType.unknown:
          return ErrorCodeAndMesage(0, Strings.unknownErrorMsg);
        default:
          return ErrorCodeAndMesage(0, Strings.defaultErrorMsg);
      }
    }else{
      return ErrorCodeAndMesage(0, Strings.no_internet_message);
    }
  }

  static Future<void> internetChecker() async {
    isInternet = await Utility.isNetworkConnection();
  }

  static ErrorCodeAndMesage _handleResponseError(Response response) {
    switch (response.statusCode) {
      case 400:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);
      case 401:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 403:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 404:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 409:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 500:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 502:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      case 503:
        return ErrorCodeAndMesage(
            response.statusCode!, response.data['error']['message']);

      default:
        return ErrorCodeAndMesage(0, Strings.defaultErrorMsg);
    }
  }
}

class ErrorCodeAndMesage extends Failure {
  ErrorCodeAndMesage(int statusCode, String message)
      : super(message, statusCode);
}
