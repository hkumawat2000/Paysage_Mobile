import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/request/risk_profile_request_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/risk_profile_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/repositories/risk_profile_repository.dart';

class SaveRiskCategoryUsecase implements UsecaseWithParams<RiskProfileResponseEntity, SaveRiskProfileCategoryParams>{

  final RiskProfileRepository riskProfileRepository;
  SaveRiskCategoryUsecase(this.riskProfileRepository);

  @override
  ResultFuture<RiskProfileResponseEntity> call(SaveRiskProfileCategoryParams params) async {
    return await riskProfileRepository.saveRiskProfileCategory(params.riskProfileRequestEntity);
  }
}

class SaveRiskProfileCategoryParams {
  final RiskProfileRequestEntity riskProfileRequestEntity;

  SaveRiskProfileCategoryParams({required this.riskProfileRequestEntity});
}