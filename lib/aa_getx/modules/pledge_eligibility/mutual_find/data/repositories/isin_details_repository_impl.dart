import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/datasource/isin_details_datasource.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/isin_details_request_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/isin_details_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/repositories/isin_details_repository.dart';

class IsinDetailsRepositoryImpl implements IsinDetailsRepository {
  final IsinDetailsDatasource isinDetailsDatasource;
  IsinDetailsRepositoryImpl(this.isinDetailsDatasource);

  ResultFuture<IsinDetailResponseEntity> getIsinDetails(
      IsinDetailsRequestEntity isinDetailsRequestEntity) async {
    try {
      IsinDetailsRequestModel isinDetailsRequestModel =
          IsinDetailsRequestModel.fromEntity(isinDetailsRequestEntity);
      final isinDetailsResponse =
          await isinDetailsDatasource.getIsinDetails(isinDetailsRequestModel);
      return DataSuccess(isinDetailsResponse.toEntity());
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