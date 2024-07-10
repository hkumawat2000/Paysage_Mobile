import 'package:equatable/equatable.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  const Failure(this.message,this.statusCode);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message,int statusCode) : super(message,statusCode);
}
class DataFailure extends Failure {
  const DataFailure(String message,int statusCode) : super(message,statusCode);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message,int statusCode) : super(message,statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message,int statusCode) : super(message,statusCode);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message,int statusCode) : super(message,statusCode);
}