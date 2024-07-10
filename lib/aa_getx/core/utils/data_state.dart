import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
//This wrappper class will be used to determine our state of the network calls.

abstract class DataState<T> {
  final T? data;
  final Failure? error;

  const DataState({this.data, this.error});
}
//Success State
class DataSuccess<T> extends DataState<T> {
  const DataSuccess( T data) : super(data: data);
}

//Failure State
class DataFailed<T> extends DataState<T> {
    DataFailed (Failure error) :  super(error :  error);
}