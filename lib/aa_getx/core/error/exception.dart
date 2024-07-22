// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String? message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException(message: $message)';
}

class ApiServerException implements Exception {
  final String? message;
  final int? statusCode;
  ApiServerException({this.message, this.statusCode});

  @override
  String toString() => 'ServerException(message: $message)';
}

class LocalStorageException implements Exception {
  String? message;
  LocalStorageException(this.message);

  @override
  String toString() => 'ServerException(message: $message)';
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

class ParsingException implements Exception {
  final String message;

  ParsingException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class FormatException implements Exception {
  final String message;

  FormatException(this.message);
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class ConnectionException implements Exception {
  final String message;
  ConnectionException(this.message);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

//Custom Error Entity Class to implemetn Exception
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";

    return "Exception code $code, $message";
  }
}