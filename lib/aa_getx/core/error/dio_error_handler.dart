import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/exception.dart';

// class DioErrorHandler {
//   static bool isInternet = false;

//   static ErrorCodeAndMesage handleDioError(DioException error) {
//     internetChecker();
//     if (isInternet) {
//       switch (error.type) {
//         case DioExceptionType.cancel:
//           return ErrorCodeAndMesage(0, Strings.requestCancelledErrorMsg);
//         case DioExceptionType.connectionTimeout:
//           return ErrorCodeAndMesage(0, Strings.connectionTimeoutErrorMsg);
//         case DioExceptionType.sendTimeout:
//           return ErrorCodeAndMesage(0, Strings.sendTimeoutErrorMsg);
//         case DioExceptionType.receiveTimeout:
//           return ErrorCodeAndMesage(0, Strings.receiveTimeoutErrorMsg);
//         case DioExceptionType.badResponse:
//           return _handleResponseError(error.response!);
//         case DioExceptionType.unknown:
//           return ErrorCodeAndMesage(0, Strings.unknownErrorMsg);
//         default:
//           return ErrorCodeAndMesage(0, Strings.defaultErrorMsg);
//       }
//     }else{
//       return ErrorCodeAndMesage(0, Strings.no_internet_message);
//     }
//   }

//   static Future<void> internetChecker() async {
//     isInternet = await Utility.isNetworkConnection();
//   }

//   static ErrorCodeAndMesage _handleResponseError(Response response) {
//     switch (response.statusCode) {
//       case 400:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);
//       case 401:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 403:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 404:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 409:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 500:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 502:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       case 503:
//         return ErrorCodeAndMesage(
//             response.statusCode!, response.data['error']['message']);

//       default:
//         return ErrorCodeAndMesage(0, Strings.defaultErrorMsg);
//     }
//   }
// }

// class ErrorCodeAndMesage extends Failure {
//   ErrorCodeAndMesage(int statusCode, String message)
//       : super(message, statusCode);
// }


ErrorEntity createErrorEntity(DioException error){
  switch(error.type){
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificates");

    case DioExceptionType.badResponse:
      final errorMessage = error.response!.statusMessage;
      final errorCode = error.response!.statusCode;
      switch(error.response!.statusCode){
        case 400:
          return ErrorEntity(code: 400, message: "Bad request");
        case 401:
          return ErrorEntity(code: 401, message: "Permission denied");
        case 403:
          return ErrorEntity(code: 403, message: "Authentication request");
        case 500:
          return ErrorEntity(code: 500, message: "Server internal error");
      }
      return ErrorEntity(code: error.response!.statusCode!, message: "Server bad response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo){
  print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
  switch(eInfo.code){
    case 400:
      print("Server syntax error");
      break;
    case 401:
      print("You are denied to continue");
      break;
    case 500:
      print("Server internal error");
      break;
    default:
      print("Unknown error");
      break;

  }
}

//This function is used to catch Dio Exception and dynamically pass the message and StatusCode
Exception handleDioClientError(DioException e) {
  switch (e.type) {
    case DioExceptionType.cancel:
      return NetworkException(message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
      return NetworkException(message: "Connection timeout with API server");
    case DioExceptionType.unknown:
      return NetworkException(message: "Connection to API server failed due to internet connection");
    case DioExceptionType.receiveTimeout:
      return NetworkException(message: "Receive timeout in connection with API server");
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.statusMessage ?? "Received invalid status code: $statusCode";
      return ApiServerException(message: message, statusCode: statusCode);
    case DioExceptionType.sendTimeout:
      return NetworkException(message: "Send timeout in connection with API server");
    default:
      return NetworkException(message: "Unexpected error occurred");
  }
}
