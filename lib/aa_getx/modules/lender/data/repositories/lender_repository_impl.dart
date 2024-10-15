import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/lender/data/datasources/lender_datasource.dart';
import 'package:lms/aa_getx/modules/lender/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/lender/domain/repositories/lender_repository.dart';

class LenderRepositoryImpl implements LenderRepository{
  LenderDatasource lenderDatasource;
  LenderRepositoryImpl(this.lenderDatasource);

  
  @override
  ResultFuture<LenderResponseEntity> getLendersList() async {
    try {
      final lenderResponse =
      await lenderDatasource.getLendersList();
      return DataSuccess(lenderResponse.toEntity());
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