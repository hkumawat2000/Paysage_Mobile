import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/request/risk_profile_request_model.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/request/risk_profile_request_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/risk_profile_response_entity.dart';

abstract class RiskProfileRepository {

  ResultFuture<GetRiskCategoryResponseEntity> getRiskProfileCategory();

  ResultFuture<RiskProfileResponseEntity> saveRiskProfileCategory(RiskProfileRequestEntity riskProfileRequestEntity);

}