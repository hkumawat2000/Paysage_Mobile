import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/response/get_risk_category_response_model.dart';

abstract class RiskProfileRepository {

  ResultFuture<GetRiskCategoryResponseModel> getRiskProfileCategory();

}