import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/aml_check/data/data_source/aml_data_source.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/entity/aml_check_response_entity.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/repositories/aml_check_repository.dart';

/// LoginRepositoryImpl is the concrete implementation of the LoginRepository
/// interface.
/// This class implements the methods defined in LoginRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AmlCheckRepositoryImpl implements AmlCheckRepository {
  final AmlCheckDataSourceApi amlDataSource;
  AmlCheckRepositoryImpl(this.amlDataSource);

  @override
  ResultFuture<AmlCheckResponseEntity> amlCheck() async {
    try {
      final amlCheckResponse = await amlDataSource.amlCheck();
      return DataSuccess(amlCheckResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }


}
