import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/request/risk_profile_request_model.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/response/get_risk_category_response_model.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/response/risk_profile_response_model.dart';

abstract class RiskProfileDataSource {
  Future<GetRiskCategoryResponseModel> getRiskProfileCategory();

  Future<RiskProfileResponseModel> saveRiskProfileCategory(
      RiskProfileRequestModel riskProfileRequestModel);
}

class RiskProfileDataSourceImpl with BaseDio implements RiskProfileDataSource {
  @override
  Future<GetRiskCategoryResponseModel> getRiskProfileCategory() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.getRiskProfileCategory);
      if (response.statusCode == 200) {
        return GetRiskCategoryResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<RiskProfileResponseModel> saveRiskProfileCategory(
      RiskProfileRequestModel riskProfileRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.saveRiskProfileCategory,
          data: riskProfileRequestModel.toJson());
      if (response.statusCode == 200) {
        return RiskProfileResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
