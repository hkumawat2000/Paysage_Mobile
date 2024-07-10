import 'package:lms/aa_getx/core/utils/data_state.dart';

typedef ResultFuture<T> = Future<DataState<T>>;

//typedef ResultVoidFuture = Future<DataState<void>>;

typedef ResultWithoutFuture<T> = DataState<T>;

//typedef ResultVoidWithoutFuture = DataState<void>;