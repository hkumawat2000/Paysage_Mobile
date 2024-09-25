import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/data_source/risk_profile_data_source.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/response/get_risk_category_response_model.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/repositories/risk_profile_repository.dart';

class RiskProfileRepositoryImpl implements RiskProfileRepository {

  final RiskProfileDataSource riskProfileDataSource;
  RiskProfileRepositoryImpl(this.riskProfileDataSource);

  @override
  ResultFuture<GetRiskCategoryResponseModel> getRiskProfileCategory() {
    // TODO: implement getRiskProfileCategory
    throw UnimplementedError();
  }

}