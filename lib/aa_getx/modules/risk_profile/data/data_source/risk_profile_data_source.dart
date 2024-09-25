import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/models/response/get_risk_category_response_model.dart';

abstract class RiskProfileDataSource {

  Future<GetRiskCategoryResponseModel> getRiskProfileCategory();

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

}