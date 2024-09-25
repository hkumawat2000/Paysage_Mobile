import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/data_source/risk_profile_data_source.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/repositories/risk_profile_repository.dart';

class RiskProfileRepositoryImpl implements RiskProfileRepository {

  final RiskProfileDataSource riskProfileDataSource;
  RiskProfileRepositoryImpl(this.riskProfileDataSource);

  @override
  ResultFuture<GetRiskCategoryResponseEntity> getRiskProfileCategory() async {
    try {
      final getRiskProfileCategoryResponse = await riskProfileDataSource.getRiskProfileCategory();
      return DataSuccess(getRiskProfileCategoryResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}