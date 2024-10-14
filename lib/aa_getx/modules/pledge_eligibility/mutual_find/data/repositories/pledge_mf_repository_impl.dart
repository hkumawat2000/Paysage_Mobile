import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/datasource/pledge_mf_datasource.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/mf_scheme_request_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/mf_scheme_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/repositories/pledge_mf_repository.dart';

class PledgeMfRepositoryImpl implements PledgeMfRepository {
  final PledgeMfDatasource pledgeMfDatasource;
  PledgeMfRepositoryImpl(this.pledgeMfDatasource);

  ResultFuture<MfSchemeResponseEntity> getSchemesList(
      MFSchemeRequestEntity mfschemeRequestEntity) async {
    try {
      MFSchemeRequestModel mfSchemeRequestModel =
          MFSchemeRequestModel.fromEntity(mfschemeRequestEntity);
      final getConsentTextResponse =
          await pledgeMfDatasource.getSchemesList(mfSchemeRequestModel);
      return DataSuccess(getConsentTextResponse.toEntity());
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
