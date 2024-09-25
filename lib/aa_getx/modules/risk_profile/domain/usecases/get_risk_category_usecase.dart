import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/repositories/risk_profile_repository.dart';

class GetRiskCategoryUsecase implements UsecaseWithoutParams<GetRiskCategoryResponseEntity>{

  final RiskProfileRepository riskProfileRepository;
  GetRiskCategoryUsecase(this.riskProfileRepository);

  @override
  ResultFuture<GetRiskCategoryResponseEntity> call() async {
    return await riskProfileRepository.getRiskProfileCategory();
  }

}