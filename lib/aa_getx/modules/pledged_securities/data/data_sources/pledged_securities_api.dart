
import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/my_pledged_securities_details_response_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';

abstract class PledgedSecuritiesApi {
  Future<MyPledgedSecuritiesDetailsResponseModel> getMyPledgedSecurities(MyPledgedSecuritiesRequestModel myPledgedSecuritiesRequestModel);
}

class PledgedSecuritiesApiImpl extends PledgedSecuritiesApi with BaseDio{
  @override
  Future<MyPledgedSecuritiesDetailsResponseModel> getMyPledgedSecurities(MyPledgedSecuritiesRequestModel myPledgedSecuritiesRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.myPledgeSecurities,
          queryParameters: myPledgedSecuritiesRequestModel.toJson());
      if (response.statusCode == 200) {
        return MyPledgedSecuritiesDetailsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}