import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/mf_scheme_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/repositories/pledge_mf_repository.dart';

class MfSchemeUsecase
    implements
        UsecaseWithParams<MfSchemeResponseEntity, MfSchemeRequestParams> {
  PledgeMfRepository pledgeMfRepository;
  MfSchemeUsecase(this.pledgeMfRepository);

  @override
  ResultFuture<MfSchemeResponseEntity> call(params) async {
    return await pledgeMfRepository
        .getSchemesList(params.mfSchemeRequestEntity);
  }
}

class MfSchemeRequestParams {
  final MFSchemeRequestEntity mfSchemeRequestEntity;
  MfSchemeRequestParams({required this.mfSchemeRequestEntity});
}
