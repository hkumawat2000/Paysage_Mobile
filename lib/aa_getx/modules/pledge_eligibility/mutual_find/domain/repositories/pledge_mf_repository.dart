import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/mf_scheme_request_entity.dart';

abstract class PledgeMfRepository {
  ResultFuture<MfSchemeResponseEntity> getSchemesList(MFSchemeRequestEntity mfSchemeRequestEntity);
}
