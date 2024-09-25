import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';

abstract class RiskProfileRepository {

  ResultFuture<GetRiskCategoryResponseEntity> getRiskProfileCategory();

}